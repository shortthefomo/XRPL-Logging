'use strict'

const { XrplClient } = require('xrpl-client')
const dotenv = require('dotenv')
const debug = require('debug')
const decimal = require('decimal.js')
const log = debug('main:logging')

const db = require('./persist/db')
const { setInterval } = require('timers')

class test {
	constructor() {
		let client = new XrplClient([process.env.LOCAL_NODE, 'wss://xrplcluster.com', 'wss://s2.ripple.com'])
		if (process.env.BACKFILL == 'true') {
			log('using full histroy nodes for back fill.')
			client = new XrplClient(['wss://xrplcluster.com', 'wss://s2.ripple.com'])
		}
		let backFillIndex = 0
		let retry = []
		let network_errors = 0
		
		Object.assign(this, {
			async run() {
				log('runnig')
				
				const self = this
				client.on('ledger', async (event) => {
					self.getLedger(event, true)
				})
			},
			async checkConnection() {
				const state = client.getState()
				log('client', state)

				if (state.online == false || state.online == 'false') {
					client.reinstate({forceNextUplink: true})
					log('reinstate client', await client.send({ command: 'server_info' }))
				}

                const books = {
                    'id': 4,
                    'command': 'book_offers',
                    'taker': 'rThREeXrp54XTQueDowPV1RxmkEAGUmg8',
                    'taker_gets': {'currency': 'USD', 'issuer': 'rvYAfWj5gh67oV6fW32ZzP3Aw4Eubs59B' },
                    'taker_pays': {'currency': 'XRP' },
                    'limit': 100
                }

                const result = await client.send(books)
                if ('error' in result) {
                    network_errors++
                    log('error', result.error)
                }
			
                if (network_errors > 10) {
                    client.reinstate({forceNextUplink: true})
                    log('reinstate client', await client.send({ command: 'server_info' }))
                    network_errors = 0
                }
                
            },
			checkState() {
				const self = this
				setInterval(async () => {
					await self.checkConnection()
				}, 100_000)
			},
			reTry() {
				// every 5 min try reinsert failed
				setInterval(async () => {
					while(retry.length > 0) {
						const retry_query = retry.pop()
						log('retry_query', retry_query)
						await db.query(retry_query)
					}
				}, 300000)
			},
			async backFill() {
				await client
				const endResult = await db.query(`SELECT * FROM three.Ledger ORDER BY ledger_index ASC LIMIT 1;`)
				if (endResult == undefined) {
					return false
				}
				backFillIndex = endResult[0].ledger_index
				
				const self = this
				while (backFillIndex > 0) {
					await self.fetchLedger(backFillIndex)
					backFillIndex--
				}
			},
			async findMissingLedgers() {
				// const start 
				await client
				const startResult = await db.query(`SELECT * FROM three.Ledger ORDER BY ledger_index DESC LIMIT 1;`)
				if (startResult == undefined) {
					return false
				}
				const ledgerStart = startResult[0].ledger_index

				const endResult = await db.query(`SELECT * FROM three.Ledger ORDER BY ledger_index ASC LIMIT 1;`)
				if (endResult == undefined) {
					return false
				}
				const ledgerEnd = endResult[0].ledger_index
				console.log({'start': ledgerStart, 'end': ledgerEnd})

				const rows = await db.query(`SELECT
					CONCAT(z.expected, IF(z.got-1>z.expected, CONCAT(' thru ',z.got-1), '')) AS missing
				FROM (
					SELECT
					@rownum:=@rownum+1 AS expected,
					IF(@rownum=ledger_index, 0, @rownum:=ledger_index) AS got
					FROM
					(SELECT @rownum:=0) AS a
					JOIN Ledger
					ORDER BY ledger_index
					) AS z
				WHERE z.got!=0;`)
				if (rows == undefined) {
					return false
				}
				// throw away 1 to ..... as we not fetching everything here.
				rows.shift()
				// console.log(rows)
				for (let index = 0; index < rows.length; index++) {
					const element = rows[index]
					console.log(element.missing.split(' thru '))
					let start = element.missing.split(' thru ')[0]
					let end = element.missing.split(' thru ')[1]

					if (end == undefined) {
						await this.fetchLedger(start)
					}
					else {
						start = start * 1
						end = end * 1
						for (let j = start; j <= end; j++) {
							await this.fetchLedger(j)
						}
					}
				}
			},
			async fetchLedger(index) {
				console.log('fetching ledger', index)
				let request = {
					'id': 'xrpl-backfill',
					'command': 'ledger',
					'ledger_index': index,
					'transactions': true,
					'expand': true,
					'owner_funds': true
				}

				let ledger_result = await client.send(request)
				
				if (!('ledger' in ledger_result)) { return }
				if (!('close_time_human' in ledger_result.ledger)) { return }

				const timestamp = Date.parse(ledger_result.ledger.close_time_human)
				const unix_time = new Date(timestamp).toISOString().slice(0, 19).replace('T', ' ')

				const newLedger = await this.logLedger(ledger_result.ledger.ledger_index, ledger_result.ledger.hash, unix_time)
				if (newLedger) {
					await this.logTransactions(ledger_result.ledger.ledger_index, ledger_result.ledger.transactions, unix_time)
				}
			},
			async getLedger(event, watch_balances = false) {
				let request = {
					'id': 'xrpl-local',
					'command': 'ledger',
					'ledger_hash': event.ledger_hash,
					'ledger_index': "validated",
					'transactions': true,
					'expand': true,
					'owner_funds': true
				}

				let ledger_result = await client.send(request)
				if (!('ledger' in ledger_result)) { return }
				if (!('close_time_human' in ledger_result.ledger)) { return }
				
				const timestamp = Date.parse(ledger_result.ledger.close_time_human)
				const unix_time = new Date(timestamp).toISOString().slice(0, 19).replace('T', ' ')

				const newLedger = await this.logLedger(ledger_result.ledger.ledger_index, ledger_result.ledger.hash, unix_time)
				if (newLedger) {
					await this.logTransactions(ledger_result.ledger.ledger_index, ledger_result.ledger.transactions, unix_time)
				}

				if (watch_balances)  {
					this.updateBalances(ledger_result.ledger.transactions)
				}
			},
			updateBalances(transactions) {
				for (let i = 0; i < transactions.length; i++) {
					const transaction = transactions[i]
					transaction.metaData.AffectedNodes.forEach(async function (item, index) {
						if ('ModifiedNode' in item) {
							if ('FinalFields' in item.ModifiedNode) {
								if ('Balance' in item.ModifiedNode.FinalFields) {
									if (typeof item.ModifiedNode.FinalFields.Balance != 'object') {
										let BalanceData = { 
											'account' : item.ModifiedNode.FinalFields.Account, 
											'balance' : decimal.div(item.ModifiedNode.FinalFields.Balance, '1000000').toFixed()
										}
		
										if (BalanceData.account == transaction.Account || BalanceData.account == transaction.Destination) {
											const result = await db.query(`INSERT INTO Balances (address, amount) VALUES('${BalanceData.account}', ${BalanceData.balance}) ON DUPLICATE KEY UPDATE address='${BalanceData.account}', amount=${BalanceData.balance};`)
										}
									}
								}
							}
						}
					})
				}
			},
			async logLedger(index, hash, unix_time) {
				const logTx = debug('main:logLedger')
				// logTx('logLedger')

				if (index == null) { return }

				const queryString = `INSERT INTO Ledger (ledger_index, hash, created) 
					VALUES('${index}', '${hash}', '${unix_time}');`
				//log(queryString)

				const rows = await db.query(queryString)
				if (rows == undefined) {
					log('SQL Error')
					log(queryString)
					retry.push(queryString)
					return false
				}
				return true
			},
			async logTransactions(index, transactions, unix_time) {
				// https://xrpl.org/transaction-types.html#transaction-types
				for (let i = 0; i < transactions.length; i++) {
					const transaction = transactions[i]
					//log(transaction)
					await this.transactionTypes(index, transaction, unix_time)
				}
				log(`added ${transactions.length} transactions, ledger: ${index}`)
			},
			async transactionTypes(index, transaction, unix_time) {
				switch (transaction.TransactionType) {
					case 'AccountSet':
						// log('AccountSet')
						await this.logAccountSet(index, transaction, unix_time)
						break;
					case 'AccountDelete':
						// log('AccountDelete')
						await this.logAccountDelete(index, transaction, unix_time)
						break;
					case 'CheckCancel':
						log('CheckCancel')
						// log(transaction)
						await this.logCheckCancel(index, transaction, unix_time)
						break;
					case 'CheckCash':
						log('CheckCash')
						// log(transaction)
						await this.logCheckCash(index, transaction, unix_time)
						break;
					case 'CheckCreate':
						log('CheckCreate')
						// log(transaction)
						await this.logCheckCreate(index, transaction, unix_time)
						break;
					case 'DepositPreauth':
						log('DepositPreauth')
						// log(transaction)
						await this.logDepositPreauth(index, transaction, unix_time)
						break;
					case 'EscrowCancel':
						log('EscrowCancel')
						// log(transaction)
						await this.logEscrowCancel(index, transaction, unix_time)
						break;
					case 'EscrowCreate':
						log('EscrowCreate')
						// log(transaction)
						await this.logEscrowCreate(index, transaction, unix_time)
						break;
					case 'EscrowFinish':
						log('EscrowFinish')
						// log(transaction)
						await this.logEscrowFinish(index, transaction, unix_time)
						break;
					case 'OfferCancel':
						await this.logOfferCancel(index, transaction, unix_time)
						break;
					case 'OfferCreate':
						await this.logOfferCreate(index, transaction, unix_time)
						break;
					case 'Payment':
						await this.logPayment(index, transaction, unix_time)
						break;
					case 'PaymentChannelClaim':
						log('logPaymentChannelClaim')
						await this.logPaymentChannelClaim(index, transaction, unix_time)
						break;
					case 'PaymentChannelCreate':
						log('PaymentChannelCreate')
						// log(transaction)
						await this.logPaymentChannelCreate(index, transaction, unix_time)
						break;
					case 'PaymentChannelFund':
						log('PaymentChannelFund')
						// log(transaction)
						await this.logPaymentChannelFund(index, transaction, unix_time)
						break;
					case 'SetRegularKey':
						log('SetRegularKey')
						await this.logSetRegularKey(index, transaction, unix_time)
						break;
					case 'SignerListSet':
						log('SignerListSet')
						// log(transaction)
						await this.logSignerListSet(index, transaction, unix_time)
						break;
					case 'TicketCreate':
						log('TicketCreate')
						// log(transaction. Account, transaction.metaData)
						await this.logTicketCreate(index, transaction, unix_time)
						break;
					case 'TrustSet':
						// log('TrustSet')
						await this.logTrustSet(index, transaction, unix_time)
						break;
					case 'NFTokenMint':
						log('NFTokenMint')
						// log(transaction)
						await this.logNFTokenMint(index, transaction, unix_time)
						break;
					case 'NFTokenCreateOffer':
						log('NFTokenCreateOffer')
						// log(transaction)
						await this.logNFTokenCreateOffer(index, transaction, unix_time)
						break;
					case 'NFTokenCancelOffer':
						log('NFTokenCancelOffer')
						// log(transaction)
						await this.logNFTokenCancelOffer(index, transaction, unix_time)
						break;
					case 'NFTokenBurn':
						log('NFTokenBurn')
						// log(transaction)
						await this.logNFTokenBurn(index, transaction, unix_time)
						break;
					case 'NFTokenAcceptOffer':
						log('NFTokenAcceptOffer')
						// log(transaction)
						await this.logNFTokenAcceptOffer(index, transaction, unix_time)
						break;
					default:
						//log('Unknown payment type: ' + transaction.TransactionType)
						break;
				}
			},
			async logNFTokenMint(index, transaction, unix_time) {
				const logTx = debug('main:NFTokenMint')
				logTx(`NFTokenMint # ${transaction.hash}`)

				if (transaction == null) { return }

				const queryString = `INSERT INTO NFTokenMint (account, hash, transaction_result, fee, created, ledger) 
					VALUES('${transaction.Account}', '${transaction.hash}', '${transaction.metaData.TransactionResult}', '${transaction.Fee}', '${unix_time}', '${index}');`
				//log(queryString)

				const rows = await db.query(queryString)
				if (rows == undefined) {
					log('SQL Error')
					log(queryString)
					retry.push(queryString)
				}
			},
			async logNFTokenCreateOffer(index, transaction, unix_time) {
				const logTx = debug('main:NFTokenCreateOffer')
				logTx(`NFTokenCreateOffer # ${transaction.hash}`)

				if (transaction == null) { return }

				const queryString = `INSERT INTO NFTokenCreateOffer (account, hash, transaction_result, fee, created, ledger) 
					VALUES('${transaction.Account}', '${transaction.hash}', '${transaction.metaData.TransactionResult}', '${transaction.Fee}', '${unix_time}', '${index}');`
				//log(queryString)

				const rows = await db.query(queryString)
				if (rows == undefined) {
					log('SQL Error')
					log(queryString)
					retry.push(queryString)
				}
			},
			async logNFTokenCancelOffer(index, transaction, unix_time) {
				const logTx = debug('main:NFTokenCancelOffer')
				logTx(`NFTokenCancelOffer # ${transaction.hash}`)

				if (transaction == null) { return }

				const queryString = `INSERT INTO NFTokenCancelOffer (account, hash, transaction_result, fee, created, ledger) 
					VALUES('${transaction.Account}', '${transaction.hash}', '${transaction.metaData.TransactionResult}', '${transaction.Fee}', '${unix_time}', '${index}');`
				//log(queryString)

				const rows = await db.query(queryString)
				if (rows == undefined) {
					log('SQL Error')
					log(queryString)
					retry.push(queryString)
				}
			},
			async logNFTokenBurn(index, transaction, unix_time) {
				const logTx = debug('main:NFTokenBurn')
				logTx(`NFTokenBurn # ${transaction.hash}`)

				if (transaction == null) { return }

				const queryString = `INSERT INTO NFTokenBurn (account, hash, transaction_result, fee, created, ledger) 
					VALUES('${transaction.Account}', '${transaction.hash}', '${transaction.metaData.TransactionResult}', '${transaction.Fee}', '${unix_time}', '${index}');`
				//log(queryString)

				const rows = await db.query(queryString)
				if (rows == undefined) {
					log('SQL Error')
					log(queryString)
					retry.push(queryString)
				}
			},
			async logNFTokenAcceptOffer(index, transaction, unix_time) {
				const logTx = debug('main:NFTokenAcceptOffer')
				logTx(`NFTokenAcceptOffer # ${transaction.hash}`)

				if (transaction == null) { return }

				const queryString = `INSERT INTO NFTokenAcceptOffer (account, hash, transaction_result, fee, created, ledger) 
					VALUES('${transaction.Account}', '${transaction.hash}', '${transaction.metaData.TransactionResult}', '${transaction.Fee}', '${unix_time}', '${index}');`
				//log(queryString)

				const rows = await db.query(queryString)
				if (rows == undefined) {
					log('SQL Error')
					log(queryString)
					retry.push(queryString)
				}
			},
			async logTicketCreate(index, transaction, unix_time) {
				const logTx = debug('main:TicketCreate')
				logTx(`TicketCreate # ${transaction.hash}`)

				if (transaction == null) { return }

				const queryString = `INSERT INTO TicketCreate (account, hash, transaction_result, fee, created, ledger) 
					VALUES('${transaction.Account}', '${transaction.hash}', '${transaction.metaData.TransactionResult}', '${transaction.Fee}', '${unix_time}', '${index}');`
				//log(queryString)

				const rows = await db.query(queryString)
				if (rows == undefined) {
					log('SQL Error')
					log(queryString)
					retry.push(queryString)
				}
			},
			async logSignerListSet(index, transaction, unix_time) {
				const logTx = debug('main:SignerListSet')
				logTx(`SignerListSet # ${transaction.hash}`)

				if (transaction == null) { return }

				const queryString = `INSERT INTO SignerListSet (account, hash, transaction_result, fee, created, ledger) 
					VALUES('${transaction.Account}', '${transaction.hash}', '${transaction.metaData.TransactionResult}', '${transaction.Fee}', '${unix_time}', '${index}');`
				//log(queryString)

				const rows = await db.query(queryString)
				if (rows == undefined) {
					log('SQL Error')
					log(queryString)
					retry.push(queryString)
				}
			},
			async logPaymentChannelFund(index, transaction, unix_time) {
				const logTx = debug('main:PaymentChannelFund')
				logTx(`PaymentChannelFund # ${transaction.hash}`)

				if (transaction == null) { return }

				const queryString = `INSERT HIGH_PRIORITY INTO PaymentChannelFund (account, hash, transaction_result, fee, created, ledger) 
					VALUES('${transaction.Account}', '${transaction.hash}', '${transaction.metaData.TransactionResult}', '${transaction.Fee}', '${unix_time}', '${index}');`
				//log(queryString)

				const rows = await db.query(queryString)
				if (rows == undefined) {
					log('SQL Error')
					log(queryString)
					retry.push(queryString)
				}
			},
			async logPaymentChannelCreate(index, transaction, unix_time) {
				const logTx = debug('main:PaymentChannelCreate')
				logTx(`PaymentChannelCreate # ${transaction.hash}`)

				if (transaction == null) { return }

				const queryString = `INSERT INTO PaymentChannelCreate (account, hash, transaction_result, fee, created, ledger) 
					VALUES('${transaction.Account}', '${transaction.hash}', '${transaction.metaData.TransactionResult}', '${transaction.Fee}', '${unix_time}', '${index}');`
				//log(queryString)

				const rows = await db.query(queryString)
				if (rows == undefined) {
					log('SQL Error')
					log(queryString)
					retry.push(queryString)
				}
			},
			async logEscrowFinish(index, transaction, unix_time) {
				const logTx = debug('main:EscrowFinish')
				logTx(`EscrowFinish # ${transaction.hash}`)

				if (transaction == null) { return }

				const queryString = `INSERT INTO EscrowFinish (account, hash, transaction_result, fee, created, ledger) 
					VALUES('${transaction.Account}', '${transaction.hash}', '${transaction.metaData.TransactionResult}', '${transaction.Fee}', '${unix_time}', '${index}');`
				//log(queryString)

				const rows = await db.query(queryString)
				if (rows == undefined) {
					log('SQL Error')
					log(queryString)
					retry.push(queryString)
				}
			},
			async logEscrowCreate(index, transaction, unix_time) {
				const logTx = debug('main:EscrowCreate')
				logTx(`EscrowCreate # ${transaction.hash}`)

				if (transaction == null) { return }
				const amount = transaction.Amount / 1_000_000
				const queryString = `INSERT INTO EscrowCreate (account, hash, amount, destination, finish_after, transaction_result, fee, created, ledger) 
					VALUES('${transaction.Account}', '${transaction.hash}', '${amount}', '${transaction.Destination}', '${transaction.FinishAfter}', '${transaction.metaData.TransactionResult}',' ${transaction.Fee}', '${unix_time}', '${index}');`
				//log(queryString)

				const rows = await db.query(queryString)
				if (rows == undefined) {
					log('SQL Error')
					log(queryString)
					retry.push(queryString)
				}
			},
			async logEscrowCancel(index, transaction, unix_time) {
				const logTx = debug('main:EscrowCancel')
				logTx(`EscrowCancel # ${transaction.hash}`)

				if (transaction == null) { return }

				const queryString = `INSERT INTO EscrowCancel (account, hash, transaction_result, fee, created, ledger) 
					VALUES('${transaction.Account}', '${transaction.hash}', '${transaction.metaData.TransactionResult}', '${transaction.Fee}', '${unix_time}', '${index}');`
				//log(queryString)

				const rows = await db.query(queryString)
				if (rows == undefined) {
					log('SQL Error')
					log(queryString)
					retry.push(queryString)
				}
			},
			async logDepositPreauth(index, transaction, unix_time) {
				const logTx = debug('main:DepositPreauth')
				logTx(`DepositPreauth # ${transaction.hash}`)

				if (transaction == null) { return }

				const queryString = `INSERT INTO DepositPreauth (account, hash, transaction_result, fee, created, ledger) 
					VALUES('${transaction.Account}', '${transaction.hash}', '${transaction.metaData.TransactionResult}', '${transaction.Fee}', '${unix_time}', '${index}');`
				//log(queryString)

				const rows = await db.query(queryString)
				if (rows == undefined) {
					log('SQL Error')
					log(queryString)
					retry.push(queryString)
				}
			},
			async logCheckCreate(index, transaction, unix_time) {
				const logTx = debug('main:CheckCreate')
				logTx(`CheckCreate # ${transaction.hash}`)

				if (transaction == null) { return }

				const queryString = `INSERT INTO CheckCreate (account, hash, transaction_result, fee, created, ledger) 
					VALUES('${transaction.Account}', '${transaction.hash}', '${transaction.metaData.TransactionResult}', '${transaction.Fee}', '${unix_time}', '${index}');`
				//log(queryString)

				const rows = await db.query(queryString)
				if (rows == undefined) {
					log('SQL Error')
					log(queryString)
					retry.push(queryString)
				}
			},
			async logCheckCash(index, transaction, unix_time) {
				const logTx = debug('main:CheckCash')
				logTx(`CheckCash # ${transaction.hash}`)

				if (transaction == null) { return }

				const queryString = `INSERT INTO CheckCash (account, hash, transaction_result, fee, created, ledger) 
					VALUES('${transaction.Account}', '${transaction.hash}', '${transaction.metaData.TransactionResult}', '${transaction.Fee}', '${unix_time}', '${index}');`
				//log(queryString)

				const rows = await db.query(queryString)
				if (rows == undefined) {
					log('SQL Error')
					log(queryString)
					retry.push(queryString)
				}
			},
			async logCheckCancel(index, transaction, unix_time) {
				const logTx = debug('main:CheckCancel')
				logTx(`CheckCancel # ${transaction.hash}`)

				if (transaction == null) { return }

				const queryString = `INSERT INTO CheckCancel (account, hash, transaction_result, fee, created, ledger) 
					VALUES('${transaction.Account}', '${transaction.hash}', '${transaction.metaData.TransactionResult}', '${transaction.Fee}', '${unix_time}', '${index}');`
				//log(queryString)

				const rows = await db.query(queryString)
				if (rows == undefined) {
					log('SQL Error')
					log(queryString)
					retry.push(queryString)
				}
			},
			async logSetRegularKey(index, transaction, unix_time) {
				const logTx = debug('main:SetRegularKey')
				logTx(`SetRegularKey # ${transaction.hash}`)

				if (transaction == null) { return }

				const queryString = `INSERT INTO SetRegularKey (account, hash, transaction_result, fee, created, ledger) 
					VALUES('${transaction.Account}', '${transaction.hash}', '${transaction.metaData.TransactionResult}', '${transaction.Fee}', '${unix_time}', '${index}');`
				//log(queryString)

				const rows = await db.query(queryString)
				if (rows == undefined) {
					log('SQL Error')
					log(queryString)
					retry.push(queryString)
				}
			},
			async logAccountSet(index, transaction, unix_time) {
				const logTx = debug('main:accountset')
				logTx(`AccountSet # ${transaction.hash}`)

				if (transaction == null) { return }

				const queryString = `INSERT INTO AccountSet (account, hash, transaction_result, fee, created, ledger) 
					VALUES('${transaction.Account}', '${transaction.hash}', '${transaction.metaData.TransactionResult}', '${transaction.Fee}', '${unix_time}', '${index}');`
				//log(queryString)

				const rows = await db.query(queryString)
				if (rows == undefined) {
					log('SQL Error')
					log(queryString)
					retry.push(queryString)
				}
			},
			async logAccountDelete(index, transaction, unix_time) {
				const logTx = debug('main:AccountDelete')
				logTx(`AccountDelete # ${transaction.hash}`)

				if (transaction == null) { return }

				const queryString = `INSERT INTO AccountDelete (account, hash, transaction_result, fee, created, ledger) 
					VALUES('${transaction.Account}', '${transaction.hash}', '${transaction.metaData.TransactionResult}', '${transaction.Fee}', '${unix_time}', '${index}');`
				//log(queryString)

				const rows = await db.query(queryString)
				if (rows == undefined) {
					log('SQL Error')
					log(queryString)
					retry.push(queryString)
				}
			},
			async logTrustSet(index, transaction, unix_time) {
				const logTx = debug('main:TrustSet')
				// logTx('TrustSet')

				if (transaction == null) { return }
				const currency = this.currencyHexToUTF8(transaction.LimitAmount.currency)

				const queryString = `INSERT INTO TrustSet (account, hash, currency, currency_hex, issuer, transaction_result, fee, created, ledger) 
					VALUES('${transaction.Account}', '${transaction.hash}', '${currency}', '${transaction.LimitAmount.currency}', '${transaction.LimitAmount.issuer}', '${transaction.metaData.TransactionResult}', '${transaction.Fee}', '${unix_time}', '${index}');`
				//log(queryString)

				const rows = await db.query(queryString)
				if (rows == undefined) {
					log('SQL Error')
					log(queryString)
					retry.push(queryString)
				}
			},
			async logPayment(index, transaction, unix_time) {
				const logTx = debug('main:Payment')
				// logTx('Payment')
				// logTx(transaction)

				if (transaction == null) { return }
				
				let amount = 0
				let currency = 'XRP'
				let currency_hex = currency
				let issuer = undefined

				if (typeof transaction.metaData.delivered_amount == 'object') {
					amount = transaction.metaData.delivered_amount.value
					currency = this.currencyHexToUTF8(transaction.metaData.delivered_amount.currency)
					currency_hex = transaction.metaData.delivered_amount.currency
					issuer = transaction.metaData.delivered_amount.issuer
				}
				else if ('delivered_amount' in transaction.metaData) {
					amount = decimal.div(transaction.metaData.delivered_amount, '1000000').toFixed()
				}
				
				let destination_tag = ('DestinationTag' in transaction) ? transaction.DestinationTag : null
				let source_tag = ('SourceTag' in transaction) ? transaction.SourceTag : null
				
				const queryString = `INSERT INTO Payment (account, destination, amount, currency, currency_hex, hash, destination_tag, source_tag, transaction_result, fee, issuer, created, ledger)
					VALUES('${transaction.Account}', '${transaction.Destination}', '${amount}', '${currency}', '${currency_hex}', '${transaction.hash}', '${destination_tag}', '${source_tag}', '${transaction.metaData.TransactionResult}', '${transaction.Fee}', '${issuer}', '${unix_time}', '${index}');`

				const rows = await db.query(queryString)
				if (rows == undefined) {
					log('SQL Error')
					log(queryString)
					retry.push(queryString)
				}

				// pull out the path transactions 
				if (transaction.metaData.TransactionResult == 'tesSUCCESS') {
					this.deriveExchanges(index, transaction, unix_time)
				}
			},
			async logPaymentChannelClaim(index, transaction, unix_time) {
				const logTx = debug('main:paymentchannelclaim')
				logTx(`PaymentChannelClaim # ${transaction.hash}`)

				if (transaction == null) { return }
			
				const queryString = `INSERT INTO PaymentChannelClaim (account, hash, transaction_result, fee, created, ledger) 
					VALUES('${transaction.Account}', '${transaction.hash}', '${transaction.metaData.TransactionResult}', '${transaction.Fee}', '${unix_time}', '${index}');`
				

				const rows = await db.query(queryString)
				if (rows == undefined) {
					log('SQL Error')
					log(queryString)
					retry.push(queryString)
				}
			},
			async logOfferCancel(index, transaction, unix_time) {
				if (transaction == null) { return }

				const logTx = debug('main:offercancel')
				// logTx('OfferCancel')

				const taker_gets = {}
				const taker_pays = {}
				transaction.metaData.AffectedNodes.forEach(element => {
					if ('DeletedNode' in element) {
						if ('LedgerEntryType' in element.DeletedNode && element.DeletedNode.LedgerEntryType == 'Offer') {
							if (typeof element.DeletedNode.FinalFields.TakerGets == 'object') {
								taker_gets.currency = this.currencyHexToUTF8(element.DeletedNode.FinalFields.TakerGets.currency) 
								taker_gets.currency_hex = element.DeletedNode.FinalFields.TakerGets.currency
								taker_gets.amount = element.DeletedNode.FinalFields.TakerGets.value * 1
								taker_gets.issuer = element.DeletedNode.FinalFields.TakerGets.issuer
							}
							else {
								taker_gets.currency = 'XRP'
								taker_gets.currency_hex = null
								taker_gets.amount = element.DeletedNode.FinalFields.TakerGets / 1_000_000
								taker_gets.issuer = null
							}

							if (typeof element.DeletedNode.FinalFields.TakerPays == 'object') {
								taker_pays.currency = this.currencyHexToUTF8(element.DeletedNode.FinalFields.TakerPays.currency)
								taker_pays.currency_hex = element.DeletedNode.FinalFields.TakerPays.currency
								taker_pays.amount = element.DeletedNode.FinalFields.TakerPays.value * 1
								taker_pays.issuer = element.DeletedNode.FinalFields.TakerPays.issuer
							}
							else {
								taker_pays.currency = 'XRP'
								taker_pays.currency_hex = null
								taker_pays.amount = element.DeletedNode.FinalFields.TakerPays / 1_000_000
								taker_pays.issuer = null
							}
						}
					}
				})
				
				const queryString = `INSERT INTO OfferCancel (account, hash, taker_gets_currency, taker_gets_currency_hex, taker_gets_issuer, taker_gets_amount, taker_pays_currency, taker_pays_currency_hex, taker_pays_issuer, taker_pays_amount, transaction_result, fee, created, ledger) 
					VALUES('${transaction.Account}', '${transaction.hash}', '${taker_gets.currency}', '${taker_gets.currency_hex}', '${taker_gets.issuer}', '${taker_gets.amount}', '${taker_pays.currency}', '${taker_pays.currency_hex}', '${taker_pays.issuer}', '${taker_pays.amount}', '${transaction.metaData.TransactionResult}', '${transaction.Fee}', '${unix_time}', '${index}');`
				const rows = await db.query(queryString)

				//COME BACK TO THIS ONE
				// if (rows == undefined) {
				// 	log('SQL Error')
				// 	log(queryString)
				// 	log(transaction.metaData.AffectedNodes)
				// }
			},
			async logOfferCreate(index, transaction, unix_time) {
				if (transaction == null) { return }

				const logTx = debug('main:offercreate')
				// logTx('OfferCreate')

				const taker_gets = {}
				const taker_pays = {}

				if (typeof transaction.TakerGets == 'object') {
					taker_gets.currency = this.currencyHexToUTF8(transaction.TakerGets.currency) 
					taker_gets.currency_hex = transaction.TakerGets.currency
					taker_gets.amount = transaction.TakerGets.value * 1
					taker_gets.issuer = transaction.TakerGets.issuer
				}
				else {
					taker_gets.currency = 'XRP'
					taker_gets.currency_hex = null
					taker_gets.amount = transaction.TakerGets / 1_000_000
					taker_gets.issuer = null
				}
				if (typeof transaction.TakerPays == 'object') {
					taker_pays.currency = this.currencyHexToUTF8(transaction.TakerPays.currency) 
					taker_pays.currency_hex = transaction.TakerPays.currency
					taker_pays.amount = transaction.TakerPays.value * 1
					taker_pays.issuer = transaction.TakerPays.issuer
				}
				else {
					taker_pays.currency = 'XRP'
					taker_pays.currency_hex = null
					taker_pays.amount = transaction.TakerPays / 1_000_000
					taker_pays.issuer = null
				}

				// logTx(taker_pays)
				// logTx(taker_gets)
				const flags = 'Flags' in transaction ? transaction.Flags : 0
				const queryString = `INSERT INTO OfferCreate (account, hash, taker_gets_currency, taker_gets_currency_hex, taker_gets_issuer, taker_gets_amount, taker_pays_currency, taker_pays_currency_hex, taker_pays_issuer, taker_pays_amount, flags, transaction_result, fee, created, ledger) 
					VALUES('${transaction.Account}', '${transaction.hash}', '${taker_gets.currency}', '${taker_gets.currency_hex}', '${taker_gets.issuer}', '${taker_gets.amount}', '${taker_pays.currency}', '${taker_pays.currency_hex}', '${taker_pays.issuer}', '${taker_pays.amount}', '${flags}', '${transaction.metaData.TransactionResult}', '${transaction.Fee}', '${unix_time}', '${index}');`
				const rows = await db.query(queryString)
				if (rows == undefined) {
					log('SQL Error')
					log(queryString)
					retry.push(queryString)
				}

				// pull out the trades
				if (transaction.metaData.TransactionResult == 'tesSUCCESS') {
					this.deriveExchanges(index, transaction, unix_time)
				}
			},
			async deriveExchanges(index, tx, unix_time){
				let hash = tx.hash || tx.transaction.hash
				let maker = tx.Account || tx.transaction.Account
				let exchanges = []


				for(let affected of (tx.meta || tx.metaData).AffectedNodes){
					let node = affected.ModifiedNode || affected.DeletedNode
			
					if(!node || node.LedgerEntryType !== 'Offer')
						continue
			
					if(!node.PreviousFields || !node.PreviousFields.TakerPays || !node.PreviousFields.TakerGets)
						continue
			
					let taker = node.FinalFields.Account
					let sequence = node.FinalFields.Sequence
					let previousTakerPays = this.fromLedgerAmount(node.PreviousFields.TakerPays)
					let previousTakerGets = this.fromLedgerAmount(node.PreviousFields.TakerGets)
					let finalTakerPays = this.fromLedgerAmount(node.FinalFields.TakerPays)
					let finalTakerGets = this.fromLedgerAmount(node.FinalFields.TakerGets)
			
					let takerPaid = {
						...finalTakerPays, 
						value: previousTakerPays.value.minus(finalTakerPays.value)
					}
			
					let takerGot = {
						...finalTakerGets, 
						value: previousTakerGets.value.minus(finalTakerGets.value)
					}
			
					const trade ={
						hash,
						maker,
						taker,
						sequence,
						base: {
							currency: this.currencyHexToUTF8(takerPaid.currency), 
							issuer: takerPaid.issuer
						},
						quote: {
							currency: this.currencyHexToUTF8(takerGot.currency), 
							issuer: takerGot.issuer
						},
						price: takerGot.value.div(takerPaid.value).toFixed(),
						volume: takerPaid.value
					}
					exchanges.push(trade)

					let queryString = `INSERT HIGH_PRIORITY INTO DEXTrades (hash, maker, taker, sequence, base_currency, base_issuer, quote_currency, quote_issuer, price, volume, created, ledger) 
						VALUES ('${trade.hash}', '${trade.maker}', '${trade.taker}', '${trade.sequence}', '${trade.base.currency}', '${trade.base.issuer}', '${trade.quote.currency}', '${trade.quote.issuer}', '${trade.price}', '${trade.volume}', '${unix_time}', '${index}');`
					const rows = await db.query(queryString)
					if (rows == undefined) {
						log('SQL Error')
						log(queryString)
						retry.push(queryString)
					}
				}
			
				return exchanges
			},
			fromLedgerAmount(amount){
				if(typeof amount === 'string')
					return {
						currency: 'XRP',
						value: decimal.div(amount, '1000000')
					}
				
				return {
					currency: amount.currency,
					issuer: amount.issuer,
					value: new decimal(amount.value)
				}
			},
			currencyHexToUTF8(code) {
				if (code.length === 3)
					return code

				let decoded = new TextDecoder()
					.decode(this.hexToBytes(code))
				let padNull = decoded.length

				while (decoded.charAt(padNull - 1) === '\0')
					padNull--

				return decoded.slice(0, padNull)
			},
			hexToBytes(hex) {
				let bytes = new Uint8Array(hex.length / 2)

				for (let i = 0; i !== bytes.length; i++) {
					bytes[i] = parseInt(hex.substr(i * 2, 2), 16)
				}

				return bytes
			}
		})
	}
}

const main = new test()
dotenv.config()
//console.log(process.env.BACKFILL )

if (process.env.MISSING == 'true' && process.env.BACKFILL == 'true') {
	log('Filling missing ledgers and backfilling!')
	main.findMissingLedgers()
	main.backFill()
} else if (process.env.MISSING == 'true') {
	log('Filling missing ledgers')
	main.findMissingLedgers()
} else if (process.env.BACKFILL == 'true') {
	log('Backfilling ledgers')
	main.backFill()
} else {
	log('Fetching new ledgers')
	main.run()
}

main.reTry()
main.checkState()
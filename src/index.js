'use strict'

const { XrplClient } = require('xrpl-client')
const debug = require('debug')
const decimal = require('decimal.js')
const log = debug('main:test')

const db = require('./persist/db')

class test {
	constructor() {
		const client = new XrplClient(['ws://192.168.0.19:6005'])
		
		Object.assign(this, {
			async run() {
				log('runnig')

				const self = this
				client.on('ledger', async (event) => {
					self.getLedger(event)
				})
			},
			async getLedger(event) {
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
				//log(ledger_result.ledger.transactions)
				this.logTransactions(ledger_result.ledger.transactions)
			},
			logTransactions(transactions) {
				// https://xrpl.org/transaction-types.html#transaction-types
				for (let i = 0; i < transactions.length; i++) {
					const tx = transactions[i]
					this.transactionTypes(tx)
				}
			},
			transactionTypes(transaction) {
				switch (transaction.TransactionType) {
					case 'AccountSet':
						// log('AccountSet')
						this.logAccountSet(transaction)
						break;
					case 'AccountDelete':
						// log('AccountDelete')
						this.logAccountDelete(transaction)
						break;
					case 'CheckCancel':
						log('CheckCancel')
						log(transaction)
						this.logCheckCancel(transaction)
						break;
					case 'CheckCash':
						log('CheckCash')
						log(transaction)
						this.logCheckCash(transaction)
						break;
					case 'CheckCreate':
						log('CheckCreate')
						log(transaction)
						this.logCheckCreate(transaction)
						break;
					case 'DepositPreauth':
						log('DepositPreauth')
						log(transaction)
						this.logDepositPreauth(transaction)
						break;
					case 'EscrowCancel':
						log('EscrowCancel')
						log(transaction)
						this.logEscrowCancel(transaction)
						break;
					case 'EscrowCreate':
						log('EscrowCreate')
						log(transaction)
						this.logEscrowCreate(transaction)
						break;
					case 'EscrowFinish':
						log('EscrowFinish')
						log(transaction)
						this.logEscrowFinish(transaction)
						break;
					case 'OfferCancel':
						this.logOfferCancel(transaction)
						break;
					case 'OfferCreate':
						this.logOfferCreate(transaction)
						break;
					case 'Payment':
						this.logPayment(transaction)
						break;
					case 'PaymentChannelClaim':
						this.logPaymentChannelClaim(transaction)
						break;
					case 'PaymentChannelCreate':
						log('PaymentChannelCreate')
						log(transaction)
						this.logPaymentChannelCreate(transaction)
						break;
					case 'PaymentChannelFund':
						log('PaymentChannelFund')
						log(transaction)
						this.logPaymentChannelFund(transaction)
						break;
					case 'SetRegularKey':
						log('SetRegularKey')
						this.logSetRegularKey(transaction)
						break;
					case 'SignerListSet':
						log('SignerListSet')
						log(transaction)
						this.logSignerListSet(transaction)
						break;
					case 'TicketCreate':
						log('TicketCreate')
						log(transaction)
						this.logTicketCreate(transaction)
						break;
					case 'TrustSet':
						// log('TrustSet')
						this.logTrustSet(transaction)
						break;
					case 'NFTokenMint':
						log('NFTokenMint')
						log(transaction)
						this.logNFTokenMint(transaction)
						break;
					case 'NFTokenCreateOffer':
						log('NFTokenCreateOffer')
						log(transaction)
						this.logNFTokenCreateOffer(transaction)
						break;
					case 'NFTokenCancelOffer':
						log('NFTokenCancelOffer')
						log(transaction)
						this.logNFTokenCancelOffer(transaction)
						break;
					case 'NFTokenBurn':
						log('NFTokenBurn')
						log(transaction)
						this.logNFTokenBurn(transaction)
						break;
					case 'NFTokenAcceptOffer':
						log('NFTokenAcceptOffer')
						log(transaction)
						this.logNFTokenAcceptOffer(transaction)
						break;
					default:
						log('Unknown payment type: ' + transaction.TransactionType)
						break;
				}
			},
			async logNFTokenMint(transaction) {
				const logTx = debug('main:NFTokenMint')
				logTx('NFTokenMint')

				if (transaction == null) { return }
				const unix_time = new Date().toISOString().slice(0, 19).replace('T', ' ')

				const queryString = `INSERT INTO NFTokenMint (account, hash, transaction_result, fee, created) 
					VALUES('${transaction.Account}', '${transaction.hash}', '${transaction.metaData.TransactionResult}', '${transaction.Fee}', '${unix_time}');`
				//log(queryString)

				const rows = await db.query(queryString)
				if (rows == undefined) {
					log('SQL Error')
					log(queryString)
				}
			},
			async logNFTokenCreateOffer(transaction) {
				const logTx = debug('main:NFTokenCreateOffer')
				logTx('NFTokenCreateOffer')

				if (transaction == null) { return }
				const unix_time = new Date().toISOString().slice(0, 19).replace('T', ' ')

				const queryString = `INSERT INTO NFTokenCreateOffer (account, hash, transaction_result, fee, created) 
					VALUES('${transaction.Account}', '${transaction.hash}', '${transaction.metaData.TransactionResult}', '${transaction.Fee}', '${unix_time}');`
				//log(queryString)

				const rows = await db.query(queryString)
				if (rows == undefined) {
					log('SQL Error')
					log(queryString)
				}
			},
			async logNFTokenCancelOffer(transaction) {
				const logTx = debug('main:NFTokenCancelOffer')
				logTx('NFTokenCancelOffer')

				if (transaction == null) { return }
				const unix_time = new Date().toISOString().slice(0, 19).replace('T', ' ')

				const queryString = `INSERT INTO NFTokenCancelOffer (account, hash, transaction_result, fee, created) 
					VALUES('${transaction.Account}', '${transaction.hash}', '${transaction.metaData.TransactionResult}', '${transaction.Fee}', '${unix_time}');`
				//log(queryString)

				const rows = await db.query(queryString)
				if (rows == undefined) {
					log('SQL Error')
					log(queryString)
				}
			},
			async logNFTokenBurn(transaction) {
				const logTx = debug('main:NFTokenBurn')
				logTx('NFTokenBurn')

				if (transaction == null) { return }
				const unix_time = new Date().toISOString().slice(0, 19).replace('T', ' ')

				const queryString = `INSERT INTO NFTokenBurn (account, hash, transaction_result, fee, created) 
					VALUES('${transaction.Account}', '${transaction.hash}', '${transaction.metaData.TransactionResult}', '${transaction.Fee}', '${unix_time}');`
				//log(queryString)

				const rows = await db.query(queryString)
				if (rows == undefined) {
					log('SQL Error')
					log(queryString)
				}
			},
			async logNFTokenAcceptOffer(transaction) {
				const logTx = debug('main:NFTokenAcceptOffer')
				logTx('NFTokenAcceptOffer')

				if (transaction == null) { return }
				const unix_time = new Date().toISOString().slice(0, 19).replace('T', ' ')

				const queryString = `INSERT INTO NFTokenAcceptOffer (account, hash, transaction_result, fee, created) 
					VALUES('${transaction.Account}', '${transaction.hash}', '${transaction.metaData.TransactionResult}', '${transaction.Fee}', '${unix_time}');`
				//log(queryString)

				const rows = await db.query(queryString)
				if (rows == undefined) {
					log('SQL Error')
					log(queryString)
				}
			},
			async logTicketCreate(transaction) {
				const logTx = debug('main:TicketCreate')
				logTx('TicketCreate')

				if (transaction == null) { return }
				const unix_time = new Date().toISOString().slice(0, 19).replace('T', ' ')

				const queryString = `INSERT INTO TicketCreate (account, hash, transaction_result, fee, created) 
					VALUES('${transaction.Account}', '${transaction.hash}', '${transaction.metaData.TransactionResult}', '${transaction.Fee}', '${unix_time}');`
				//log(queryString)

				const rows = await db.query(queryString)
				if (rows == undefined) {
					log('SQL Error')
					log(queryString)
				}
			},
			async logSignerListSet(transaction) {
				const logTx = debug('main:SignerListSet')
				logTx('SignerListSet')

				if (transaction == null) { return }
				const unix_time = new Date().toISOString().slice(0, 19).replace('T', ' ')

				const queryString = `INSERT INTO SignerListSet (account, hash, transaction_result, fee, created) 
					VALUES('${transaction.Account}', '${transaction.hash}', '${transaction.metaData.TransactionResult}', '${transaction.Fee}', '${unix_time}');`
				//log(queryString)

				const rows = await db.query(queryString)
				if (rows == undefined) {
					log('SQL Error')
					log(queryString)
				}
			},
			async logPaymentChannelFund(transaction) {
				const logTx = debug('main:PaymentChannelFund')
				logTx('PaymentChannelFund')

				if (transaction == null) { return }
				const unix_time = new Date().toISOString().slice(0, 19).replace('T', ' ')

				const queryString = `INSERT INTO PaymentChannelFund (account, hash, transaction_result, fee, created) 
					VALUES('${transaction.Account}', '${transaction.hash}', '${transaction.metaData.TransactionResult}', '${transaction.Fee}', '${unix_time}');`
				//log(queryString)

				const rows = await db.query(queryString)
				if (rows == undefined) {
					log('SQL Error')
					log(queryString)
				}
			},
			async logPaymentChannelCreate(transaction) {
				const logTx = debug('main:PaymentChannelCreate')
				logTx('PaymentChannelCreate')

				if (transaction == null) { return }
				const unix_time = new Date().toISOString().slice(0, 19).replace('T', ' ')

				const queryString = `INSERT INTO PaymentChannelCreate (account, hash, transaction_result, fee, created) 
					VALUES('${transaction.Account}', '${transaction.hash}', '${transaction.metaData.TransactionResult}', '${transaction.Fee}', '${unix_time}');`
				//log(queryString)

				const rows = await db.query(queryString)
				if (rows == undefined) {
					log('SQL Error')
					log(queryString)
				}
			},
			async logEscrowFinish(transaction) {
				const logTx = debug('main:EscrowFinish')
				logTx('EscrowFinish')

				if (transaction == null) { return }
				const unix_time = new Date().toISOString().slice(0, 19).replace('T', ' ')

				const queryString = `INSERT INTO EscrowFinish (account, hash, transaction_result, fee, created) 
					VALUES('${transaction.Account}', '${transaction.hash}', '${transaction.metaData.TransactionResult}', '${transaction.Fee}', '${unix_time}');`
				//log(queryString)

				const rows = await db.query(queryString)
				if (rows == undefined) {
					log('SQL Error')
					log(queryString)
				}
			},
			async logEscrowCreate(transaction) {
				const logTx = debug('main:EscrowCreate')
				logTx('EscrowCreate')

				if (transaction == null) { return }
				const unix_time = new Date().toISOString().slice(0, 19).replace('T', ' ')
				const amount = transaction.Amount / 1_000_000
				const queryString = `INSERT INTO EscrowCreate (account, hash, amount, destination, finish_after, transaction_result, fee, created) 
					VALUES('${transaction.Account}', '${transaction.hash}', '${amount}', '${transaction.Destination}', '${transaction.FinishAfter}', '${transaction.metaData.TransactionResult}',' ${transaction.Fee}', '${unix_time}');`
				//log(queryString)

				const rows = await db.query(queryString)
				if (rows == undefined) {
					log('SQL Error')
					log(queryString)
				}
			},
			async logEscrowCancel(transaction) {
				const logTx = debug('main:EscrowCancel')
				logTx('EscrowCancel')

				if (transaction == null) { return }
				const unix_time = new Date().toISOString().slice(0, 19).replace('T', ' ')

				const queryString = `INSERT INTO EscrowCancel (account, hash, transaction_result, fee, created) 
					VALUES('${transaction.Account}', '${transaction.hash}', '${transaction.metaData.TransactionResult}', '${transaction.Fee}', '${unix_time}');`
				//log(queryString)

				const rows = await db.query(queryString)
				if (rows == undefined) {
					log('SQL Error')
					log(queryString)
				}
			},
			async logDepositPreauth(transaction) {
				const logTx = debug('main:DepositPreauth')
				logTx('DepositPreauth')

				if (transaction == null) { return }
				const unix_time = new Date().toISOString().slice(0, 19).replace('T', ' ')

				const queryString = `INSERT INTO DepositPreauth (account, hash, transaction_result, fee, created) 
					VALUES('${transaction.Account}', '${transaction.hash}', '${transaction.metaData.TransactionResult}', '${transaction.Fee}', '${unix_time}');`
				//log(queryString)

				const rows = await db.query(queryString)
				if (rows == undefined) {
					log('SQL Error')
					log(queryString)
				}
			},
			async logCheckCreate(transaction) {
				const logTx = debug('main:CheckCreate')
				logTx('CheckCreate')

				if (transaction == null) { return }
				const unix_time = new Date().toISOString().slice(0, 19).replace('T', ' ')

				const queryString = `INSERT INTO CheckCreate (account, hash, transaction_result, fee, created) 
					VALUES('${transaction.Account}', '${transaction.hash}', '${transaction.metaData.TransactionResult}', '${transaction.Fee}', '${unix_time}');`
				//log(queryString)

				const rows = await db.query(queryString)
				if (rows == undefined) {
					log('SQL Error')
					log(queryString)
				}
			},
			async logCheckCash(transaction) {
				const logTx = debug('main:CheckCash')
				logTx('CheckCash')

				if (transaction == null) { return }
				const unix_time = new Date().toISOString().slice(0, 19).replace('T', ' ')

				const queryString = `INSERT INTO CheckCash (account, hash, transaction_result, fee, created) 
					VALUES('${transaction.Account}', '${transaction.hash}', '${transaction.metaData.TransactionResult}', '${transaction.Fee}', '${unix_time}');`
				//log(queryString)

				const rows = await db.query(queryString)
				if (rows == undefined) {
					log('SQL Error')
					log(queryString)
				}
			},
			async logCheckCancel(transaction) {
				const logTx = debug('main:CheckCancel')
				logTx('CheckCancel')

				if (transaction == null) { return }
				const unix_time = new Date().toISOString().slice(0, 19).replace('T', ' ')

				const queryString = `INSERT INTO CheckCancel (account, hash, transaction_result, fee, created) 
					VALUES('${transaction.Account}', '${transaction.hash}', '${transaction.metaData.TransactionResult}', '${transaction.Fee}', '${unix_time}');`
				//log(queryString)

				const rows = await db.query(queryString)
				if (rows == undefined) {
					log('SQL Error')
					log(queryString)
				}
			},
			async logSetRegularKey(transaction) {
				const logTx = debug('main:SetRegularKey')
				// logTx('SetRegularKey')

				if (transaction == null) { return }
				const unix_time = new Date().toISOString().slice(0, 19).replace('T', ' ')

				const queryString = `INSERT INTO SetRegularKey (account, hash, transaction_result, fee, created) 
					VALUES('${transaction.Account}', '${transaction.hash}', '${transaction.metaData.TransactionResult}', '${transaction.Fee}', '${unix_time}');`
				//log(queryString)

				const rows = await db.query(queryString)
				if (rows == undefined) {
					log('SQL Error')
					log(queryString)
				}
			},
			async logAccountSet(transaction) {
				const logTx = debug('main:accountset')
				// logTx('AccountSet')

				if (transaction == null) { return }
				const unix_time = new Date().toISOString().slice(0, 19).replace('T', ' ')

				const queryString = `INSERT INTO AccountSet (account, hash, transaction_result, fee, created) 
					VALUES('${transaction.Account}', '${transaction.hash}', '${transaction.metaData.TransactionResult}', '${transaction.Fee}', '${unix_time}');`
				//log(queryString)

				const rows = await db.query(queryString)
				if (rows == undefined) {
					log('SQL Error')
					log(queryString)
				}
			},
			async logAccountDelete(transaction) {
				const logTx = debug('main:AccountDelete')
				// logTx('AccountDelete')

				if (transaction == null) { return }
				const unix_time = new Date().toISOString().slice(0, 19).replace('T', ' ')

				const queryString = `INSERT INTO AccountDelete (account, hash, transaction_result, fee, created) 
					VALUES('${transaction.Account}', '${transaction.hash}', '${transaction.metaData.TransactionResult}', '${transaction.Fee}', '${unix_time}');`
				//log(queryString)

				const rows = await db.query(queryString)
				if (rows == undefined) {
					log('SQL Error')
					log(queryString)
				}
			},
			async logTrustSet(transaction) {
				const logTx = debug('main:TrustSet')
				// logTx('TrustSet')

				if (transaction == null) { return }
				const unix_time = new Date().toISOString().slice(0, 19).replace('T', ' ')
				const currency = this.currencyHexToUTF8(transaction.LimitAmount.currency)

				const queryString = `INSERT INTO TrustSet (account, hash, currency, currency_hex, issuer, transaction_result, fee, created) 
					VALUES('${transaction.Account}', '${transaction.hash}', '${currency}', '${transaction.LimitAmount.currency}', '${transaction.LimitAmount.issuer}', '${transaction.metaData.TransactionResult}', '${transaction.Fee}', '${unix_time}');`
				//log(queryString)

				const rows = await db.query(queryString)
				if (rows == undefined) {
					log('SQL Error')
					log(queryString)
				}
			},
			async logPayment(transaction) {
				const logTx = debug('main:Payment')
				// logTx('Payment')
				// logTx(transaction)

				if (transaction == null) { return }
				const unix_time = new Date().toISOString().slice(0, 19).replace('T', ' ')
				
				let amount = 0
				let currency = 'XRP'
				let currency_hex = currency
				let issuer = undefined

				if (typeof transaction.Amount == 'object') {
					amount = transaction.Amount.value * 1
					currency = this.currencyHexToUTF8(transaction.Amount.currency)
					currency_hex = transaction.Amount.currency
					issuer = transaction.Amount.issuer
				}
				else {
					amount = transaction.Amount / 1_000_000
				}
				
				let destination_tag = ('DestinationTag' in transaction) ? transaction.DestinationTag : null
				let source_tag = ('SourceTag' in transaction) ? transaction.SourceTag : null
				
				const queryString = `INSERT INTO Payment (account, destination, amount, currency, currency_hex, hash, destination_tag, source_tag, transaction_result, fee, issuer, created)
					VALUES('${transaction.Account}', '${transaction.Destination}', '${amount * 1}', '${currency}', '${currency_hex}', '${transaction.hash}', '${destination_tag}', '${source_tag}', '${transaction.metaData.TransactionResult}', '${transaction.Fee}', '${transaction.Fee}', ' ${issuer}', '${unix_time}');`
				//log(queryString)

				const rows = await db.query(queryString)
				if (rows == undefined) {
					log('SQL Error')
					log(queryString)
				}

				// pull out the path transactions 
				if (transaction.metaData.TransactionResult == 'tesSUCCESS') {
					this.deriveExchanges(transaction)
				}
			},
			async logPaymentChannelClaim(transaction) {
				const logTx = debug('main:paymentchannelclaim')
				logTx('PaymentChannelClaim')

				if (transaction == null) { return }
				const unix_time = new Date().toISOString().slice(0, 19).replace('T', ' ')
				const currency = this.currencyHexToUTF8(transaction.LimitAmount.currency)

				const queryString = `INSERT INTO PaymentChannelClaim (account, hash, currency, currency_hex, issuer, transaction_result, fee, created) 
					VALUES('${transaction.Account}', '${transaction.hash}', '${currency}', '${transaction.LimitAmount.currency}', '${transaction.LimitAmount.issuer}', '${transaction.metaData.TransactionResult}', '${transaction.Fee}', '${unix_time}');`
				//log(queryString)

				const rows = await db.query(queryString)
				if (rows == undefined) {
					log('SQL Error')
					log(queryString)
				}
			},
			async logOfferCancel(transaction) {
				if (transaction == null) { return }
				const unix_time = new Date().toISOString().slice(0, 19).replace('T', ' ')

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

				const queryString = `INSERT INTO OfferCancel (account, hash, taker_gets_currency, taker_gets_currency_hex, taker_gets_issuer, taker_gets_amount, taker_pays_currency, taker_pays_currency_hex, taker_pays_issuer, taker_pays_amount, transaction_result, fee, created) 
					VALUES('${transaction.Account}', '${transaction.hash}', '${taker_gets.currency}', '${taker_gets.currency_hex}', '${taker_gets.issuer}', '${taker_gets.amount}', '${taker_pays.currency}', '${taker_pays.currency_hex}', '${taker_pays.issuer}', '${taker_pays.amount}', '${transaction.metaData.TransactionResult}', '${transaction.Fee}', '${unix_time}');`
				const rows = await db.query(queryString)

				//COME BACK TO THIS ONE
				// if (rows == undefined) {
				// 	log('SQL Error')
				// 	log(queryString)
				// 	log(transaction.metaData.AffectedNodes)
				// }
			},
			async logOfferCreate(transaction) {
				if (transaction == null) { return }
				const unix_time = new Date().toISOString().slice(0, 19).replace('T', ' ')

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
				const queryString = `INSERT INTO OfferCreate (account, hash, taker_gets_currency, taker_gets_currency_hex, taker_gets_issuer, taker_gets_amount, taker_pays_currency, taker_pays_currency_hex, taker_pays_issuer, taker_pays_amount, flags, transaction_result, fee, created) 
					VALUES('${transaction.Account}', '${transaction.hash}', '${taker_gets.currency}', '${taker_gets.currency_hex}', '${taker_gets.issuer}', '${taker_gets.amount}', '${taker_pays.currency}', '${taker_pays.currency_hex}', '${taker_pays.issuer}', '${taker_pays.amount}', '${flags}', '${transaction.metaData.TransactionResult}', '${transaction.Fee}', '${unix_time}');`
				const rows = await db.query(queryString)
				if (rows == undefined) {
					log('SQL Error')
					log(queryString)
				}

				// pull out the trades
				if (transaction.metaData.TransactionResult == 'tesSUCCESS') {
					this.deriveExchanges(transaction)
				}
			},
			async deriveExchanges(tx){
				let hash = tx.hash || tx.transaction.hash
				let maker = tx.Account || tx.transaction.Account
				let exchanges = []
				const unix_time = new Date().toISOString().slice(0, 19).replace('T', ' ')


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
						price: takerGot.value.div(takerPaid.value),
						volume: takerPaid.value
					}
					exchanges.push(trade)

					let query = `INSERT INTO DEXTrades (hash, maker, taker, sequence, base_currency, base_issuer, quote_currency, quote_issuer, price, volume, created) 
						VALUES ('${trade.hash}', '${trade.maker}', '${trade.taker}', '${trade.sequence}', '${trade.base.currency}', '${trade.base.issuer}', '${trade.quote.currency}', '${trade.quote.issuer}', '${trade.price}', '${trade.volume}', '${unix_time}');`
					const rows = await db.query(query)
					if (rows == undefined) {
						log('SQL Error')
						log(query)
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
main.run()
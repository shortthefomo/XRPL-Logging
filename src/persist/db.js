'use strict'

const mysql = require('mysql2/promise')
const dotenv = require('dotenv')
const debug = require('debug')
const log = debug('db:connection')

dotenv.config()

const pool = mysql.createPool({
    host: process.env.HOSTNAME,
    user: process.env.USERNAME,
    password: process.env.PASSWORD,
    database: process.env.DATABASE,
    port: process.env.PORT,
    waitForConnections: true,
    connectionLimit: 10,
    queueLimit: 0
})

async function query(sql, params) {
    try {
        const [results] = await pool.query(sql, params)
        return results

    } catch (exception) {
        log(exception) 
    }
}

module.exports = {
    query
}
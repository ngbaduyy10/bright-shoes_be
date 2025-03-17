const mysql = require('mysql2');

const pool = mysql.createPool({
    host: process.env.DB_HOST,
    port: process.env.DB_PORT,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_DATABASE,
});

pool.getConnection((err, connection) => {
    if (err) {
        console.log('Error connecting to database: ' + err);
    } else {
        console.log('Connected to database');
    }
});

module.exports = pool.promise();
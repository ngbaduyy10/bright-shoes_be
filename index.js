const express = require('express');
const app = express();

const dotenv = require('dotenv');
dotenv.config();
const port = process.env.PORT;

const db = require('./config/database');

const bodyParser = require('body-parser');
app.use(bodyParser.json());

const cookieParser = require('cookie-parser');
app.use(cookieParser());

const cors = require('cors');
app.use(
    cors({
        origin: process.env.FRONTEND_URL,
        methods: ["GET", "POST", "DELETE", "PATCH"],
        allowedHeaders: [
            "Content-Type",
            "Authorization",
            "Cache-Control",
            "Expires",
            "Pragma",
        ],
        credentials: true,
    })
);

const routes = require('./api/routes/index.route');
routes(app);

app.listen(port, () => {
    console.log(`Example app listening on port ${port}`)
})
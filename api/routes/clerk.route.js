const express = require('express');
const router = express.Router();
const clerkController = require('../controllers/clerk.controller');

router.post('/webhook', clerkController.webhook);

module.exports = router;
const express = require('express');
const router = express.Router();
const discountController = require('../controllers/discount.controller');

router.get('/', discountController.getDiscounts);

module.exports = router;
const express = require('express');
const router = express.Router();
const discountController = require('../controllers/discount.controller');

router.get('/', discountController.getDiscounts);

router.post('/value', discountController.getDiscountByOrderValue);

module.exports = router;
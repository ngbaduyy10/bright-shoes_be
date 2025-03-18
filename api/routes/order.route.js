const express = require('express');
const router = express.Router();
const orderController = require('../controllers/order.controller');

router.post('/create', orderController.createOrder);

router.get('/get/:id', orderController.getOrders);

module.exports = router;
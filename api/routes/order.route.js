const express = require('express');
const router = express.Router();
const orderController = require('../controllers/order.controller');

router.post('/create', orderController.createOrder);

router.get('/:id', orderController.getOrdersByUserId);

module.exports = router;
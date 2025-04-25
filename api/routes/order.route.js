const express = require('express');
const router = express.Router();
const orderController = require('../controllers/order.controller');

router.post('/create', orderController.createOrder);

router.get('/:id', orderController.getOrdersByUserId);

router.get('/check/:userId/:shoesId', orderController.checkOrder);

router.get('/', orderController.getAllOrders);

router.patch('/status/:orderId', orderController.updateOrderStatus);

router.get('/revenue/weekly', orderController.getWeeklyRevenue);

router.get('/status/data', orderController.getStatusData);

module.exports = router;
const express = require('express');
const router = express.Router();
const cartController = require('../controllers/cart.controller');

router.post('/add', cartController.addToCart);

router.get('/:id', cartController.getCartItems);

router.patch('/update', cartController.updateCartItem);

router.patch('/delete', cartController.deleteCartItem);

router.delete('/clear', cartController.clearCart);

module.exports = router;
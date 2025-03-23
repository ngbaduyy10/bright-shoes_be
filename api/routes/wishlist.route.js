const express = require('express');
const router = express.Router();
const wishlistController = require('../controllers/wishlist.controller');

router.post('/add', wishlistController.addToWishlist);

router.patch('/remove', wishlistController.removeFromWishlist);

router.get('/:id', wishlistController.getWishlistItems);

router.post('/check', wishlistController.wishlistCheck);

module.exports = router;
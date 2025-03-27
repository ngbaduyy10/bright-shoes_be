const express = require('express');
const router = express.Router();
const reviewController = require('../controllers/review.controller');

router.get('/:shoesId', reviewController.getReviews);

router.post('/add', reviewController.addReview);

module.exports = router;
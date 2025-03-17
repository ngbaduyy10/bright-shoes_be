const express = require('express');
const router = express.Router();
const shoesController = require('../controllers/shoes.controller');

router.get('/', shoesController.getShoes);

router.get('/:id', shoesController.getShoesById);

module.exports = router;
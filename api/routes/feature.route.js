const express = require('express');
const router = express.Router();
const featureController = require('../controllers/feature.controller');

router.get('/', featureController.getFeatures);

module.exports = router;
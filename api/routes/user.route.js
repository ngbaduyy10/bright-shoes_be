const express = require('express');
const router = express.Router();
const userController = require('../controllers/user.controller');

router.get('/admin', userController.getAdmins);

router.get('/customer', userController.getCustomers);

module.exports = router;
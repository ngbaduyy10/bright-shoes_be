const express = require('express');
const router = express.Router();
const authController = require('../controllers/auth.controller');

router.post('/admin/create', authController.createAdmin);

router.post('/admin/login', authController.adminLogin);

router.get('/admin/logout', authController.adminLogout);

router.get('/auth-check', authController.authCheck);

module.exports = router;
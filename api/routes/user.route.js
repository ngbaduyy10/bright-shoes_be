const express = require('express');
const router = express.Router();
const userController = require('../controllers/user.controller');
const uploadFileMiddleware = require('../middlewares/uploadFile.middleware');
const multer  = require('multer');
const upload = multer();

router.get('/admin', userController.getAdmins);

router.post(
    '/admin',
    upload.single('image_url'),
    uploadFileMiddleware.uploadFile,
    userController.createAdmin
);

router.patch(
    '/admin/:id',
    upload.single('image_url'),
    uploadFileMiddleware.uploadFile,
    userController.editAdmin
);

router.get('/customer', userController.getCustomers);

module.exports = router;
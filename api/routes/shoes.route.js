const express = require('express');
const router = express.Router();
const shoesController = require('../controllers/shoes.controller');
const uploadFileMiddleware = require('../middlewares/uploadFile.middleware');
const multer  = require('multer');
const upload = multer();

router.post('/', shoesController.getShoes);

router.get('/:id', shoesController.getShoesById);

router.post(
    '/create',
    upload.single('image_url'),
    uploadFileMiddleware.uploadFile,
    shoesController.createShoes
);

router.patch(
    '/update/:id',
    upload.single('image_url'),
    uploadFileMiddleware.uploadFile,
    shoesController.updateShoes
);

router.delete('/delete/:id', shoesController.deleteShoes);

module.exports = router;
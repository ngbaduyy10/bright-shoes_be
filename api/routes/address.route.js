const express = require('express');
const router = express.Router();
const addressController = require('../controllers/address.controller');

router.get('/:userId', addressController.getAddresses);

router.post('/add', addressController.addAddress);

router.patch('/edit/:addressId', addressController.editAddress);

router.delete('/delete/:addressId', addressController.deleteAddress);

module.exports = router;
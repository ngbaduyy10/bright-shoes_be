const db = require('../../config/database');

module.exports.getAddresses = async (req, res) => {
    try {
        const { userId } = req.params;

        const sql = `
            SELECT * FROM address WHERE user_id = ?
        `;

        const [addresses] = await db.query(sql, [userId]);
        return res.status(200).json({
            success: true,
            data: addresses,
        });
    } catch (error) {
        return res.status(500).json({ message: error.message });
    }
}

module.exports.addAddress = async (req, res) => {
    try {
        const { userId, street, ward, district, city, country, phone } = req.body;

        if (!street || !city || !ward || !district || !country || !phone) {
            return res.json({
                success: false,
                message: "Please fill in all fields"
            });
        }

        const sql = `
            INSERT INTO address (user_id, street, ward, district, city, country, phone)
            VALUES (?, ?, ?, ?, ?, ?, ?)
        `;

        await db.query(sql, [userId, street, ward, district, city, country, phone]);
        return res.status(201).json({
            success: true,
            message: "Address created successfully",
        });
    } catch (error) {
        return res.status(500).json({ message: error.message });
    }
}

module.exports.editAddress = async (req, res) => {
    try {
        const { addressId } = req.params;
        const { street, ward, district, city, country, phone } = req.body;

        if (!street || !city || !ward || !district || !country || !phone) {
            return res.json({
                success: false,
                message: "Please fill in all fields"
            });
        }

        const sql = `
            UPDATE address SET street = ?, ward = ?, district = ?, city = ?, country = ?, phone = ?
            WHERE id = ?
        `;

        await db.query(sql, [street, ward, district, city, country, phone, addressId]);
        return res.status(200).json({
            success: true,
            message: "Address updated successfully",
        });
    } catch (error) {
        return res.status(500).json({ message: error.message });
    }
}

module.exports.deleteAddress = async (req, res) => {
    try {
        const { addressId } = req.params;

        const sql = `
            DELETE FROM address WHERE id = ?
        `;

        await db.query(sql, [addressId]);
        return res.status(200).json({
            success: true,
            message: "Address deleted successfully",
        });
    } catch (error) {
        return res.status(500).json({ message: error.message });
    }
}
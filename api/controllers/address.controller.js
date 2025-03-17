const db = require('../../config/database');

module.exports.getAddresses = async (req, res) => {
    try {
        const { userId } = req.params;

        const sql = `
            SELECT id, street, city, state, zip_code, country, phone_number  FROM address WHERE user_id = ?
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
        const { userId, street, city, state, zip_code, country, phone_number } = req.body;

        if (!street || !city || !state || !zip_code || !country || !phone_number) {
            return res.json({
                success: false,
                message: "Please fill in all fields"
            });
        }

        const sql = `
            INSERT INTO address (user_id, street, city, state, zip_code, country, phone_number)
            VALUES (?, ?, ?, ?, ?, ?, ?)
        `;

        await db.query(sql, [userId, street, city, state, zip_code, country, phone_number]);
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
        const { street, city, state, zip_code, country, phone_number } = req.body;

        if (!street || !city || !state || !zip_code || !country || !phone_number) {
            return res.json({
                success: false,
                message: "Please fill in all fields"
            });
        }

        const sql = `
            UPDATE address SET street = ?, city = ?, state = ?, zip_code = ?, country = ?, phone_number = ?
            WHERE id = ?
        `;

        await db.query(sql, [street, city, state, zip_code, country, phone_number, addressId]);
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
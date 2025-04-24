const db = require('../../config/database');

module.exports.getAdmins = async (req, res) => {
    try {
        const sql = 'SELECT * FROM admin JOIN user ON admin.user_id = user.id';
        const [rows] = await db.query(sql);
        return res.status(200).json({
            success: true,
            data: rows,
        });
    } catch (err) {
        res.status(500).json({ message: err.message });
    }
}

module.exports.getCustomers = async (req, res) => {
    try {
        const sql = 'SELECT * FROM customer JOIN user ON customer.user_id = user.id';
        const [rows] = await db.query(sql);
        return res.status(200).json({
            success: true,
            data: rows,
        });
    } catch (err) {
        res.status(500).json({ message: err.message });
    }
}
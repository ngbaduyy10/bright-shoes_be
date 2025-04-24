const db = require('../../config/database');

module.exports.getDiscounts = async (req, res) => {
    try {
        const sql = `
            SELECT * FROM discount
        `;

        const [discounts] = await db.query(sql);
        return res.status(200).json({
            success: true,
            data: discounts,
        });
    } catch (error) {
        return res.status(500).json({ message: error.message });
    }
}
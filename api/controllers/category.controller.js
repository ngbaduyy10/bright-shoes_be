const db = require('../../config/database');

module.exports.getCategories = async (req, res) => {
    try {
        const [categories] = await db.query("SELECT * FROM category");
        return res.status(200).json({
            success: true,
            data: categories,
        });
    } catch (error) {
        return res.status(500).json({ message: error.message });
    }
}
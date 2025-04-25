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

module.exports.getCategoriesData = async (req, res) => {
    //get number of shoes in each category, if category has no shoes, return 0
    try {
        const sql = `
            SELECT c.name, COUNT(s.id) AS count
            FROM category c
            LEFT JOIN shoes s ON c.id = s.category_id
            GROUP BY c.id
        `;
        const [categories] = await db.query(sql);
        return res.status(200).json({
            success: true,
            data: categories,
        });
    } catch (error) {
        return res.status(500).json({ message: error.message });
    }
}
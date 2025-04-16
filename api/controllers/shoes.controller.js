const db = require("../../config/database");

module.exports.getShoes = async (req, res) => {
    try {
        const sql = `
            SELECT * FROM shoes
        `;

        const [shoes] = await db.query(sql);
        shoes.forEach((item) => {
            item.size = JSON.parse(item.size);
        });
        return res.status(200).json({
            success: true,
            data: shoes,
        });
    } catch (error) {
        return res.status(500).json({ message: error.message });
    }
};

module.exports.getShoesById = async (req, res) => {
    try {
        const { id } = req.params;

        const sql = `
            SELECT * FROM shoes WHERE id = ?
        `;

        const [shoes] = await db.query(sql, [id]);
        if (shoes.length === 0) {
            return res.status(404).json({ message: "Shoes not found" });
        }
        shoes[0].size = JSON.parse(shoes[0].size);

        return res.status(200).json({
            success: true,
            data: shoes[0],
        });
    } catch (error) {
        return res.status(500).json({ message: error.message });
    }
};

module.exports.getShoesByCategories = async (req, res) => {
    try {
        const { categoryId } = req.params;
        const sql = `
            SELECT * FROM shoes WHERE category_id = ?
        `;

        const [shoes] = await db.query(sql, [categoryId]);
        if (shoes.length === 0) {
            return res.status(404).json({ message: "Shoes not found" });
        }
        shoes[0].size = JSON.parse(shoes[0].size);

        return res.status(200).json({
            success: true,
            data: shoes,
        });
    } catch (error) {
        return res.status(500).json({ message: error.message });
    }
};


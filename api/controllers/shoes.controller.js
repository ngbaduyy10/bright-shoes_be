const db = require('../../config/database');

module.exports.getShoes = async (req, res) => {
    try {
        const { categories, sort, keyword } = req.body;

        let sql = `SELECT * FROM shoes`;
        let queryParams = [];
        let whereConditions = [];

        if (categories && categories.length > 0) {
            const categoryArray = Array.isArray(categories) ? categories : categories.split(',');

            if (categoryArray.length > 0) {
                whereConditions.push(`category_id IN (${categoryArray.map(() => '?').join(',')})`);
                queryParams = [...queryParams, ...categoryArray];
            }
        }

        if (keyword && keyword.trim()) {
            whereConditions.push(`(name LIKE ? OR description LIKE ?)`);
            const searchTerm = `%${keyword.trim()}%`;
            queryParams.push(searchTerm, searchTerm);
        }

        if (whereConditions.length > 0) {
            sql += ` WHERE ${whereConditions.join(' AND ')}`;
        }

        if (sort && sort !== 'default') {
            const [field, order] = sort.split('-');
            const allowedFields = ['price'];
            const allowedOrders = ['asc', 'desc'];

            if (allowedFields.includes(field) && allowedOrders.includes(order.toLowerCase())) {
                sql += ` ORDER BY ${field} ${order.toUpperCase()}`;
            }
        } else {
            sql += ` ORDER BY created_at DESC`;
        }

        const [shoes] = await db.query(sql, queryParams);
        shoes.forEach(item => {
            item.size = JSON.parse(item.size);
        });
        return res.status(200).json({
            success: true,
            data: shoes,
        });
    } catch (error) {
        return res.status(500).json({ message: error.message });
    }
}

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
}

module.exports.createShoes = async (req, res) => {
    try {
        const { name, description, price, quantity, category_id, image_url } = req.body;

        if (!name || !description || !price || !quantity || !category_id || !image_url) {
            return res.json({ message: "All fields are required" });
        }

        const sizes = ["6", "6.5", "7", "7.5", "8", "8.5", "9", "9.5", "10", "10.5", "11"];
        const sizeString = JSON.stringify(sizes);

        const sql = `
            INSERT INTO shoes (name, description, price, quantity, category_id, image_url, size)
            VALUES (?, ?, ?, ?, ?, ?, ?)
        `;

        const [result] = await db.query(sql, [name, description, price, quantity, category_id, image_url, sizeString]);
        return res.status(201).json({
            success: true,
            message: "Shoes created successfully",
            data: {
                id: result.insertId,
                name,
                description,
                price,
                quantity,
                category_id,
                image_url,
            },
        });

    } catch (error) {
        return res.status(500).json({ message: error.message });
    }
}

module.exports.updateShoes = async (req, res) => {
    try {
        const { id } = req.params;
        const { name, description, price, quantity, category_id, image_url } = req.body;

        if (!name || !description || !price || !quantity || !category_id || !image_url) {
            return res.json({ message: "All fields are required" });
        }

        const sql = `
            UPDATE shoes
            SET name = ?, description = ?, price = ?, quantity = ?, category_id = ?, image_url = ?
            WHERE id = ?
        `;

        await db.query(sql, [name, description, price, quantity, category_id, image_url, id]);
        return res.status(200).json({
            success: true,
            message: "Shoes updated successfully",
        });

    } catch (error) {
        return res.status(500).json({ message: error.message });
    }
}

module.exports.deleteShoes = async (req, res) => {
    try {
        const { id } = req.params;

        const sql = `
            DELETE FROM shoes WHERE id = ?
        `;

        await db.query(sql, [id]);
        return res.status(200).json({
            success: true,
            message: "Shoes deleted successfully",
        });

    } catch (error) {
        return res.status(500).json({ message: error.message });
    }
}
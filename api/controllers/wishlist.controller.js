const db = require('../../config/database');

module.exports.addToWishlist = async (req, res) => {
    try {
        const { userId, shoesId } = req.body;

        const [shoes] = await db.query("SELECT id FROM shoes WHERE id = ?", [shoesId]);
        if (shoes.length === 0) {
            return res.status(404).json({ message: "Shoes not found" });
        }

        const [wishlist] = await db.query("SELECT * FROM wishlist WHERE user_id = ? AND shoes_id = ?", [userId, shoesId]);
        if (wishlist.length > 0) {
            return res.status(400).json({ message: "Shoes already in wishlist" });
        }

        await db.query("INSERT INTO wishlist (user_id, shoes_id) VALUES (?, ?)", [userId, shoesId]);
        return res.status(200).json({
            success: true,
            message: "Added to wishlist successfully"
        });
    } catch (error) {
        return res.status(500).json({ message: error.message });
    }
}

module.exports.removeFromWishlist = async (req, res) => {
    try {
        const { userId, shoesId } = req.body;

        const [wishlist] = await db.query("SELECT * FROM wishlist WHERE user_id = ? AND shoes_id = ?", [userId, shoesId]);
        if (wishlist.length === 0) {
            return res.status(404).json({ message: "Shoes not found in wishlist" });
        }

        await db.query("DELETE FROM wishlist WHERE user_id = ? AND shoes_id = ?", [userId, shoesId]);
        return res.status(200).json({
            success: true,
            message: "Removed from wishlist successfully"
        });
    } catch (error) {
        return res.status(500).json({ message: error.message });
    }
}

module.exports.getWishlistItems = async (req, res) => {
    try {
        const userId = req.params.id;

        const sql = `
            SELECT s.id, s.name, s.price, s.image_url
            FROM shoes s
            JOIN wishlist w ON w.shoes_id = s.id
            WHERE w.user_id = ?
        `;
        const [wishlist] = await db.query(sql, [userId]);
        return res.status(200).json({
            success: true,
            data: wishlist
        });
    } catch (error) {
        return res.status(500).json({ message: error.message });
    }
}

module.exports.wishlistCheck = async (req, res) => {
    try {
        const { userId, shoesId } = req.body;

        const [wishlist] = await db.query("SELECT * FROM wishlist WHERE user_id = ? AND shoes_id = ?", [userId, shoesId]);
        return res.status(200).json({
            success: true,
            data: wishlist.length > 0
        });
    } catch (error) {
        return res.status(500).json({ message: error.message });
    }
}
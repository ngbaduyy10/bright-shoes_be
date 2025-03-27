const db = require('../../config/database');

module.exports.getReviews = async (req, res) => {
    try {
        const { shoesId } = req.params;

        const sql = `
            SELECT r.*, u.first_name, u.last_name, u.image_url
            FROM review r
            JOIN user u ON r.user_id = u.id
            WHERE r.shoes_id = ?
            ORDER BY r.created_at DESC
        `;

        const [reviews] = await db.query(sql, [shoesId]);
        const averageRating = reviews.reduce((acc, review) => acc + review.rating, 0) / reviews.length;

        return res.status(200).json({
            success: true,
            data: {
                reviews,
                averageRating
            }
        });
    } catch (error) {
        return res.status(500).json({ message: error.message });
    }
}

module.exports.addReview = async (req, res) => {
    try {
        const { shoesId, userId, rating, comment } = req.body;

        if (!rating || !comment) {
            return res.json({
                success: false,
                message: "Please fill in all fields"
            });
        }

        const sql = `
            INSERT INTO review (shoes_id, user_id, rating, comment)
            VALUES (?, ?, ?, ?)
        `;

        await db.query(sql, [shoesId, userId, rating, comment]);
        return res.status(201).json({
            success: true,
            message: "Review added successfully",
        });
    } catch (error) {
        return res.status(500).json({ message: error.message });
    }
}
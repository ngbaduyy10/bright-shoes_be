const db = require('../../config/database');

module.exports.getFeatures = async (req, res) => {
    try {
        const [features] = await db.query("SELECT * FROM feature");
        return res.status(200).json({
            success: true,
            data: features,
        });
    } catch (error) {
        return res.status(500).json({ message: error.message });
    }
}
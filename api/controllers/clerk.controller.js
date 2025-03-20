const db = require('../../config/database');

module.exports.webhook = async (req, res) => {
    const { data } = req.body;
    const id = data.id;
    const email = data.email_addresses[0].email_address;
    const firstName = data.first_name;
    const lastName = data.last_name;
    const imageUrl = data.image_url;

    const userSql = `
        INSERT INTO user (id, email, first_name, last_name, image_url)
        VALUES (?, ?, ?, ?, ?)
        ON DUPLICATE KEY UPDATE
             email = VALUES(email),
             first_name = VALUES(first_name),
             last_name = VALUES(last_name),
             image_url = VALUES(image_url)
    `;

    const customerSql = `
        INSERT INTO customer (user_id) 
        VALUES (?) 
        ON DUPLICATE KEY UPDATE user_id = VALUES(user_id)
    `;

    try {
        await db.query(userSql, [id, email, firstName, lastName, imageUrl]);
        await db.query(customerSql, [id]);
        return res.status(200).json({
            success: true,
            message: "User webhook received"
        });
    } catch (error) {
        return res.status(500).json({ message: error.message });
    }
}
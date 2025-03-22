const db = require('../../config/database');

module.exports.createOrder = async (req, res) => {
    try {
        const { userId, address, items, paymentMethod, totalBill } = req.body;

        const sql = `
            INSERT INTO \`order\` (user_id, payment_method, total_bill, street, ward, district, city, country, phone)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
        `;

        const [order] = await db.query(
            sql,
            [userId, paymentMethod, totalBill, address.street, address.ward, address.district, address.city, address.country, address.phone]
        );
        const orderId = order.insertId;

        for (const item of items) {
            await db.query("INSERT INTO order_item (order_id, shoes_id, quantity, price) VALUES (?, ?, ?, ?)", [orderId, item.shoes_id, item.quantity, item.price]);
        }

        return res.status(201).json({
            success: true,
            message: "Place order successfully"
        });
    } catch (error) {
        return res.status(500).json({ message: error.message });
    }
}

module.exports.getOrdersByUserId = async (req, res) => {
    try {
        const userId = req.params.id;

        const orderItemSql = `
            SELECT * FROM \`order\`
            WHERE user_id = ?
            ORDER BY created_at DESC
        `;

        const [orders] = await db.query(orderItemSql, [userId]);

        return res.status(200).json({
            success: true,
            data: orders
        });
    } catch (error) {
        return res.status(500).json({ message: error.message });
    }
}
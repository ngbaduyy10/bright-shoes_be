const db = require('../../config/database');

module.exports.createOrder = async (req, res) => {
    try {
        const { userId, addressId, items, paymentMethod, totalPrice } = req.body;

        const [address] = await db.query("SELECT id FROM address WHERE id = ?", [addressId]);
        if (address.length === 0) {
            return res.status(404).json({ message: "Address not found" });
        }

        const [order] = await db.query("INSERT INTO `order` (user_id, payment_method, total_price, address_id) VALUES (?, ?, ?, ?)", [userId, paymentMethod, totalPrice, addressId]);
        const orderId = order.insertId;

        for (const item of items) {
            await db.query("INSERT INTO order_item (order_id, shoes_id, quantity, price) VALUES (?, ?, ?, ?)", [orderId, item.shoes_id, item.quantity, item.price]);
        }

        return res.status(201).json({
            success: true,
            message: "Order created successfully"
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
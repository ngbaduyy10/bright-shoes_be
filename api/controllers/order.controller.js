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

        for (const order of orders) {
            const orderItemsSql = `
                SELECT oi.*, s.name, s.image_url
                FROM order_item oi
                JOIN shoes s ON oi.shoes_id = s.id
                WHERE oi.order_id = ?
            `;

            const [orderItems] = await db.query(orderItemsSql, [order.id]);
            order.items = orderItems;
        }

        return res.status(200).json({
            success: true,
            data: orders
        });
    } catch (error) {
        return res.status(500).json({ message: error.message });
    }
}

module.exports.checkOrder = async (req, res) => {
    try {
        const { userId, shoesId } = req.params;

        const sql = `
            SELECT o.id
            FROM order_item oi
            JOIN \`order\` o ON oi.order_id = o.id
            WHERE o.user_id = ? AND oi.shoes_id = ?
        `;

        const [orders] = await db.query(sql, [userId, shoesId]);

        return res.status(200).json({
            success: true,
            data: orders,
        });
    } catch (error) {
        return res.status(500).json({ message: error.message });
    }
}

module.exports.getAllOrders = async (req, res) => {
    try {
        const { keyword, status } = req.query;

        let conditions = [];
        let params = [];

        if (keyword) {
            conditions.push(`(
                o.id LIKE ? OR 
                u.first_name LIKE ? OR 
                u.last_name LIKE ? OR 
                u.email LIKE ?
            )`);
            const keywordPattern = `%${keyword}%`;
            params.push(keywordPattern, keywordPattern, keywordPattern, keywordPattern);
        }

        if (status && status !== 'all') {
            conditions.push(`o.status = ?`);
            params.push(status);
        }

        const whereClause = conditions.length ? `WHERE ${conditions.join(' AND ')}` : '';

        const sql = `
            SELECT o.*, u.first_name, u.last_name, u.email
            FROM \`order\` o
            JOIN user u ON o.user_id = u.id
            ${whereClause}
            ORDER BY o.created_at DESC
        `;

        const [orders] = await db.query(sql, params);

        for (const order of orders) {
            const orderItemsSql = `
                SELECT oi.price, oi.quantity, s.name, s.image_url
                FROM order_item oi
                JOIN shoes s ON oi.shoes_id = s.id
                WHERE oi.order_id = ?
            `;
            const [orderItems] = await db.query(orderItemsSql, [order.id]);
            order.items = orderItems;
        }

        return res.status(200).json({
            success: true,
            data: orders,
        });
    } catch (error) {
        return res.status(500).json({ message: error.message });
    }
}

module.exports.updateOrderStatus = async (req, res) => {
    try {
        const { orderId } = req.params;
        const { status } = req.body;

        const sql = `
            UPDATE \`order\`
            SET status = ?
            WHERE id = ?
        `;

        await db.query(sql, [status, orderId]);

        return res.status(200).json({
            success: true,
            message: "Update order status successfully"
        });
    } catch (error) {
        return res.status(500).json({ message: error.message });
    }
}

module.exports.getWeeklyRevenue = async (req, res) => {
    try {
        const sql = `
            SELECT YEARWEEK(created_at, 1)                  AS year_week,
                   MIN(DATE_FORMAT(created_at, '%Y-%m-%d')) AS week_start_date,
                   SUM(total_bill)                          AS total
            FROM \`order\`
            WHERE created_at >= DATE (NOW()) - INTERVAL 8 WEEK
            GROUP BY YEARWEEK(created_at, 1)
            ORDER BY year_week DESC
        `;

        const [revenue] = await db.query(sql);

        return res.status(200).json({
            success: true,
            data: revenue,
        });
    } catch (error) {
        return res.status(500).json({ message: error.message });
    }
}

module.exports.getStatusData = async (req, res) => {
    //get number of orders in each status, if status has no orders, still get and return 0
    try {
        const sql = `
            SELECT status, COUNT(*) AS count
            FROM \`order\`
            GROUP BY status
        `;

        const [statusData] = await db.query(sql);

        const statusMap = {
            "pending": 0,
            "processing": 0,
            "shipping": 0,
            "delivered": 0,
            "cancelled": 0
        };

        for (const status of statusData) {
            statusMap[status.status] = status.count;
        }

        return res.status(200).json({
            success: true,
            data: statusMap,
        });
    } catch (error) {
        return res.status(500).json({ message: error.message });
    }
}
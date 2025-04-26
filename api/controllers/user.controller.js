const db = require('../../config/database');
const generate = require("../../helpers/generate");
const bcrypt = require("bcryptjs");

module.exports.getAdmins = async (req, res) => {
    try {
        const { keyword } = req.query;
        if (keyword) {
            const sql = `
                SELECT * FROM admin JOIN user ON admin.user_id = user.id
                WHERE user.first_name LIKE ? OR user.last_name LIKE ? OR user.email LIKE ?
            `;
            const [rows] = await db.query(sql, [`%${keyword}%`, `%${keyword}%`, `%${keyword}%`]);
            return res.status(200).json({
                success: true,
                data: rows,
            });
        } else {
            const sql = 'SELECT * FROM admin JOIN user ON admin.user_id = user.id';
            const [rows] = await db.query(sql);
            return res.status(200).json({
                success: true,
                data: rows,
            });
        }
    } catch (err) {
        res.status(500).json({ message: err.message });
    }
}

module.exports.createAdmin = async (req, res) => {
    try {
        const { first_name, last_name, email, image_url, gender, role } = req.body;
        const password = process.env.DEFAULT_PASSWORD;

        if (!first_name || !last_name || !email || !gender || !role || !image_url ) {
            return res.json({
                success: false,
                message: "Please fill in all fields"
            });
        }

        const emailCheck = `
            SELECT u.id FROM user u JOIN admin a ON u.id = a.user_id WHERE u.email = ?
        `;
        const [emailExists] = await db.query(emailCheck, [email]);
        if (emailExists.length > 0) {
            return res.json({
                success: false,
                message: "Email already exists"
            });
        }

        const userId = generate.userId();
        const hashedPassword = await bcrypt.hash(password, 12);

        const userSql = `
            INSERT INTO user (id, email, first_name, last_name, image_url, gender)
            VALUES (?, ?, ?, ?, ?, ?)
        `

        const adminSql = `
            INSERT INTO admin (user_id, role, password)
            VALUES (?, ?, ?)
        `

        await db.query(userSql, [userId, email, first_name, last_name, image_url, gender]);
        await db.query(adminSql, [userId, role, hashedPassword]);
        return res.status(200).json({
            success: true,
            message: "Admin created successfully",
        });

    } catch (error) {
        return res.status(500).json({ message: error.message });
    }
}

module.exports.editAdmin = async (req, res) => {
    try {
        const { id } = req.params;
        const { first_name, last_name, email, image_url, gender, role } = req.body;

        const idCheckSql = 'SELECT * FROM admin JOIN user ON admin.user_id = user.id WHERE admin.user_id = ?';
        const [admin] = await db.query(idCheckSql, [id]);
        if (admin.length === 0) {
            return res.status(404).json({
                success: false,
                message: "Admin not found"
            });
        }

        const [emailExists] = await db.query(
            'SELECT u.id FROM user u JOIN admin a ON u.id = a.user_id WHERE u.email = ? AND u.id != ?',
            [email, id]
        );
        if (emailExists.length > 0) {
            return res.json({
                success: false,
                message: "Email already in use"
            });
        }

        const updateUserSql = `
            UPDATE user 
            SET first_name = ?, last_name = ?, email = ?, image_url = ?, gender = ?
            WHERE id = ?
        `;
        await db.query(updateUserSql, [first_name, last_name, email, image_url, gender, id]);

        const updateAdminSql = `
            UPDATE admin 
            SET role = ?
            WHERE user_id = ?
        `;
        await db.query(updateAdminSql, [role, id]);

        return res.status(200).json({
            success: true,
            message: "Admin updated successfully"
        });


    } catch (error) {
        return res.status(500).json({ message: error.message });
    }
}

module.exports.getCustomers = async (req, res) => {
    try {
        const sql = 'SELECT * FROM customer JOIN user ON customer.user_id = user.id';
        const [rows] = await db.query(sql);
        return res.status(200).json({
            success: true,
            data: rows,
        });
    } catch (err) {
        res.status(500).json({ message: err.message });
    }
}
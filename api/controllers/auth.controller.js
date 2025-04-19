const db = require('../../config/database');
const generate = require('../../helpers/generate');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');

module.exports.createAdmin = async (req, res) => {
    try {
        const { firstName, lastName, email, imageUrl, gender, role, password } = req.body;

        if (!firstName || !lastName || !email || !gender || !role || !password) {
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

        await db.query(userSql, [userId, email, firstName, lastName, imageUrl, gender]);

        await db.query(adminSql, [userId, role, hashedPassword]);
        return res.status(200).json({
            success: true,
            message: "Admin created successfully",
        });

    } catch (error) {
        return res.status(500).json({ message: error.message });
    }
}

module.exports.adminLogin = async (req, res) => {
    try {
        const { email, password } = req.body;

        const userSql = `
            SELECT u.*, a.* FROM user u JOIN admin a ON u.id = a.user_id WHERE u.email = ?
        `;

        const [user] = await db.query(userSql, [email]);
        if (user.length === 0) {
            return res.json({
                success: false,
                message: "Wrong email or password"
            });
        }

        const passwordMatch = await bcrypt.compare(password, user[0].password);
        if (!passwordMatch) {
            return res.json({
                success: false,
                message: "Wrong email or password"
            });
        }

        const token = generate.jwtToken(user[0]);

        return res.cookie("token", token, {
            httpOnly: true,
            secure: true,
            sameSite: "none",
            path: "/",
            domain: process.env.DOMAIN,
        }).status(200).json({
            success: true,
            message: "Login successful",
        });

    } catch (error) {
        return res.status(500).json({ message: error.message });
    }
}

module.exports.adminLogout = async (req, res) => {
    res.cookie("token", "", {
        httpOnly: true,
        secure: true,
        sameSite: "none",
        path: "/",
        domain: process.env.DOMAIN,
        expires: new Date(0),
    }).status(200).json({
        success: true,
        message: "Logout successful"
    });
}

module.exports.authCheck = async (req, res) => {
    try {
        const token = req.cookies.token;
        if (!token) {
            return res.json({
                success: false,
                message: "Unauthorized"
            });
        }

        const decoded = jwt.verify(token, process.env.SECRET_JWT);

        return res.status(200).json({
            success: true,
            user: decoded,
        });

    } catch (error) {
        return res.status(500).json({ message: error.message });
    }
}
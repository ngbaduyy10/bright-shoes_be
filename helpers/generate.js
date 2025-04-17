const jwt = require("jsonwebtoken");

module.exports.jwtToken = (user) => {
    return jwt.sign(
        {
            id: user.id,
            email: user.email,
            first_name: user.first_name,
            last_name: user.last_name,
            role: user.role,
        },
        process.env.SECRET_JWT,
        {
            expiresIn: '1d'
        }
    );
};


module.exports.userId = () => {
    const prefix = 'user_';
    const length = 27;
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    let randomStr = '';

    for (let i = 0; i < length; i++) {
        randomStr += chars.charAt(Math.floor(Math.random() * chars.length));
    }

    return prefix + randomStr;
}
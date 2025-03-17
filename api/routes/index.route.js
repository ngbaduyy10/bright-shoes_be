const clerkRoutes = require('./clerk.route');
const shoesRoutes = require('./shoes.route');
const cartRoutes = require('./cart.route');
const addressRoutes = require('./address.route');
const orderRoutes = require('./order.route');

module.exports = (app) => {
    app.use('/api/clerk', clerkRoutes);

    app.use('/api/shoes', shoesRoutes);

    app.use('/api/cart', cartRoutes);

    app.use('/api/address', addressRoutes);

    app.use('/api/order', orderRoutes);
}
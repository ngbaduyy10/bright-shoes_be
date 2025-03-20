const db = require('../../config/database');

const getUpdatedCart = async (userId) => {
    const [cart] = await db.query(
        "SELECT c.id, s.id AS shoes_id, s.name, s.price, s.image_url, ci.quantity FROM cart c " +
        "JOIN cart_item ci ON c.id = ci.cart_id " +
        "JOIN shoes s ON ci.shoes_id = s.id " +
        "WHERE c.user_id = ?",
        [userId]
    );

    return cart;
}

module.exports.addToCart = async (req, res) => {
    try {
        const { userId, shoesId } = req.body;

        const [shoes] = await db.query("SELECT id FROM shoes WHERE id = ?", [shoesId]);
        if (shoes.length === 0) {
            return res.status(404).json({ message: "Shoes not found" });
        }

        let [cart] = await db.query("SELECT id FROM cart WHERE user_id = ?", [userId]);
        if (cart.length === 0) {
            const [result] = await db.query("INSERT INTO cart (user_id) VALUES (?)", [userId]);
            cart = [{ id: result.insertId }];
        }

        const cartId = cart[0].id;

        let [cartItem] = await db.query(
            "SELECT * FROM cart_item WHERE cart_id = ? AND shoes_id = ?",
            [cartId, shoesId]
        );

        if (cartItem.length > 0) {
            await db.query("UPDATE cart_item SET quantity = quantity + 1 WHERE cart_id = ? AND shoes_id = ?", [cartId, shoesId]);
        } else {
            await db.query("INSERT INTO cart_item (cart_id, shoes_id, quantity) VALUES (?, ?, ?)", [cartId,  shoesId,  1]);
        }

        const updatedCart = await getUpdatedCart(userId);
        const totalPrice = updatedCart.reduce((total, item) => total + item.price * item.quantity, 0);
        await db.query("UPDATE cart SET total_price = ? WHERE id = ?", [totalPrice, cartId]);

        return res.status(200).json({
            success: true,
            message: "Added to cart successfully",
            cartItems: updatedCart,
            totalPrice
        });
    } catch (error) {
        return res.status(500).json({ message: error.message });
    }
}

module.exports.getCartItems = async (req, res) => {
    try {
        const userId = req.params.id;

        const cart = await getUpdatedCart(userId);
        if (cart.length === 0) {
            return res.status(404).json({ message: "Cart not found" });
        }

        const totalPrice = cart.reduce((total, item) => total + item.price * item.quantity, 0);

        return res.status(200).json({
            success: true,
            cartId: cart[0].id,
            cartItems: cart,
            totalPrice
        });
    } catch (error) {
        return res.status(500).json({ message: error.message });
    }
}

module.exports.updateCartItem = async (req, res) => {
    try {
        const { userId, shoesId, quantity } = req.body;

        const [cart] = await db.query("SELECT id FROM cart WHERE user_id = ?", [userId]);
        if (cart.length === 0) {
            return res.status(404).json({ message: "Cart not found" });
        }

        const [cartItem] = await db.query(
            "SELECT * FROM cart_item WHERE cart_id = ? AND shoes_id = ?",
            [cart[0].id, shoesId]
        );
        if (cartItem.length === 0) {
            return res.status(404).json({ message: "Item not found in cart" });
        }

        await db.query("UPDATE cart_item SET quantity = ? WHERE cart_id = ? AND shoes_id = ?", [quantity, cart[0].id, shoesId]);

        const updatedCart = await getUpdatedCart(userId);
        const totalPrice = updatedCart.reduce((total, item) => total + item.price * item.quantity, 0);
        await db.query("UPDATE cart SET total_price = ? WHERE id = ?", [totalPrice, cart[0].id]);

        return res.status(200).json({
            success: true,
            message: "Cart item updated successfully",
            cartItems: updatedCart,
            totalPrice
        });
    } catch (error) {
        return res.status(500).json({ message: error.message });
    }
}

module.exports.deleteCartItem = async (req, res) => {
    try {
        const { userId, shoesId } = req.body;

        const [cart] = await db.query("SELECT id FROM cart WHERE user_id = ?", [userId]);
        if (cart.length === 0) {
            return res.status(404).json({ message: "Cart not found" });
        }

        const [cartItem] = await db.query(
            "SELECT * FROM cart_item WHERE cart_id = ? AND shoes_id = ?",
            [cart[0].id, shoesId]
        );
        if (cartItem.length === 0) {
            return res.status(404).json({ message: "Item not found in cart" });
        }

        await db.query("DELETE FROM cart_item WHERE cart_id = ? AND shoes_id = ?", [cart[0].id, shoesId]);

        const updatedCart = await getUpdatedCart(userId);
        const totalPrice = updatedCart.reduce((total, item) => total + item.price * item.quantity, 0);
        await db.query("UPDATE cart SET total_price = ? WHERE id = ?", [totalPrice, cart[0].id]);

        return res.status(200).json({
            success: true,
            message: "Cart item deleted successfully",
            cartItems: updatedCart,
            totalPrice
        });
    } catch (error) {
        return res.status(500).json({ message: error.message });
    }
}

module.exports.clearCart = async (req, res) => {
    try {
        const userId = req.params.id;

        const [cart] = await db.query("SELECT id FROM cart WHERE user_id = ?", [userId]);
        if (cart.length === 0) {
            return res.status(404).json({ message: "Cart not found" });
        }

        await db.query("DELETE FROM cart_item WHERE cart_id = ?", [cart[0].id]);
        await db.query("UPDATE cart SET total_price = 0 WHERE id = ?", [cart[0].id]);

        return res.status(200).json({
            success: true,
            message: "Cart cleared successfully"
        });
    } catch (error) {
        return res.status(500).json({ message: error.message });
    }
}
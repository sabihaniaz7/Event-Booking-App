// middleware/auth.js
//
// Middleware = a function that runs BEFORE your route handler. Express
// calls it with (req, res, next) — you either call next() to let the
// request continue, or send a response yourself to stop it there.
// This is what "one auth check, reused on every protected route" means.

const jwt = require('jsonwebtoken');
const User = require('../models/User');

async function protect(req, res, next) {

    const authHeader = req.headers.authorization; // expects "Bearer <token>"
    if (!authHeader || !authHeader.startsWith('Bearer ')) {
        return res.status(401).json({ message: 'Not authorized, no token' });
    }

    const token = authHeader.split(' ')[1];
    try {
        // jwt.verify throws if the token is invalid or expired.
        const decoded = jwt.verify(token, process.env.JWT_SECRET);
        // Attach the user to `req` so every route after this can use req.user.
        req.user = await User.findById(decoded.id);
        if (!req.user) return res.status(401).json({ message: 'User no longer exists' });
        next();
    } catch (error) {
        return res.status(401).json({ message: 'Not authorized, token invalid' });
    }
}

// A second, smaller middleware — used AFTER `protect` on admin-only routes.
// Example: router.get('/admin/stats', protect, adminOnly, controllerFn)

function adminOnly(req, res, next) {
    if (req.user?.role !== 'admin') {
        return res.status(403).json({ message: 'Admin access required' });
    }
    next();
}

module.exports = { protect, adminOnly };
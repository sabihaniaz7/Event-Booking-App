// controllers/authController.js
//
// Controllers hold the actual logic. Routes just say "when this URL is
// hit, call this function" — keeping routes/authRoutes.js short and readable.

const User = require('../models/User');
const jwt = require('jsonwebtoken');

// Helper: builds a signed token containing the user's Mongo _id.
// The frontend stores this and sends it back on every request
// (see Dio's Authorization header interceptor in Flutter).

function generateToken(id) {
    return jwt.sign({ id }, process.env.JWT_SECRET, { expiresIn: '30d' });
}

// Shapes a User document into exactly what the Flutter UserModel expects.

function toUserJson(user) {
    return { _id: user._id, name: user.name, email: user.email, role: user.role, avatarUrl: user.avatarUrl };
}

// POST /api/auth/signup

exports.signup = async (req, res) => {

    try {
        const { name, email, password } = req.body;
        if (!name || !email || !password) {
            return res.status(400).json({ message: 'Name, email and password are required' });
        }
        const existing = await User.findOne({ email });
        if (existing) return res.status(409).json({ message: 'Email already registered' });

        // Password gets hashed automatically by the pre('save') hook in User.js.
        const user = await User.create({ name, email, password });

        res.status(201).json({ token: generateToken(user._id), user: toUserJson(user) });
    } catch (err) {
        res.status(500).json({ message: err.message });
    }
};

// POST /api/auth/login
exports.login = async (req, res) => {
    try {
        const { email, password } = req.body;
        // .select('+password') is needed because the schema hides password by default.
        const user = await User.findOne({ email }).select('+password');

        if (!user || !(await user.comparePassword(password))) {
            // Same message for "no such user" and "wrong password" —
            // don't reveal which one it was, that's a login-security basic.
            return res.status(401).json({ message: 'Invalid email or password' });
        }

        res.json({ token: generateToken(user._id), user: toUserJson(user) });
    } catch (err) {
        res.status(500).json({ message: err.message });
    }
};

// GET /api/auth/me  (protected — req.user set by the `protect` middleware)
exports.getMe = async (req, res) => {
    res.json(toUserJson(req.user));
};

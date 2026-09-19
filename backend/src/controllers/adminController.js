// controllers/adminController.js
//
// Separate from bookingController/eventController because this is about
// aggregating data ACROSS models for a dashboard, not managing one
// resource. Keeps each controller focused on a single responsibility.

const User = require('../models/User');
const Event = require('../models/Event');
const Booking = require('../models/Booking');

// GET /api/admin/stats
exports.getDashboardStats = async (req, res) => {
    try {
        const [totalUsers, totalEvents, totalBookings, bookings] = await Promise.all([
            User.countDocuments({ role: 'user' }),
            Event.countDocuments(),
            Booking.countDocuments({ status: { $ne: 'cancelled' } }),
            Booking.find({ status: { $ne: 'cancelled' } }),
        ]);

        // Sum revenue in JS rather than a Mongo aggregation pipeline —
        // simpler to read while your dataset is small; swap to $group +
        // $sum later if bookings grow into the tens of thousands.
        const totalRevenue = bookings.reduce((sum, b) => sum + b.totalPrice, 0);

        res.json({ totalUsers, totalEvents, totalBookings, totalRevenue });
    } catch (err) {
        res.status(500).json({ message: err.message });
    }
};

// GET /api/admin/users — registered users list (never returns password, schema already hides it)
exports.getAllUsers = async (req, res) => {
    try {
        const users = await User.find({ role: 'user' }).sort({ createdAt: -1 });
        res.json(users);
    } catch (err) {
        res.status(500).json({ message: err.message });
    }
};
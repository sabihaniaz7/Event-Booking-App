// routes/bookingRoutes.js

const express = require('express');
const router = express.Router();
const { createBooking, getMyBookings, getAllBookings, updateBookingStatus, } = require('../controllers/bookingController');
const { protect, adminOnly } = require('../middleware/auth');

// Order matters here: '/mine' must come before '/:id'-style routes in
// other files, but since none exist here it's just kept for clarity.
router.post('/', protect, createBooking);
router.get('/mine', protect, getMyBookings);
router.get('/', protect, adminOnly, getAllBookings);
router.patch('/:id/status', protect, adminOnly, updateBookingStatus);

module.exports = router;
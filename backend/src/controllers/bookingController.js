// controllers/bookingController.js

const mongoose = require('mongoose');
const Booking = require('../models/Booking');
const Event = require('../models/Event');

// POST /api/bookings   body: { eventId, quantity }
// The most important safety logic in this whole app lives here:
// preventing overbooking when two people book the last seats at once.
exports.createBooking = async (req, res) => {
    const session = await mongoose.startSession();
    try {
        session.startTransaction();

        const { eventId, quantity } = req.body;
        const qty = Number(quantity) || 1;

        const event = await Event.findById(eventId).session(session);
        if (!event) throw new Error('Event not found');

        if (event.bookedSeats + qty > event.totalSeats) {
            throw new Error('Not enough seats available');
        }

        // Increment atomically inside the same transaction as creating the
        // booking — if either step fails, both roll back, so seat counts
        // never drift out of sync with actual bookings.
        event.bookedSeats += qty;
        await event.save({ session });

        const [booking] = await Booking.create(
            [
                {
                    user: req.user._id,
                    event: event._id,
                    quantity: qty,
                    totalPrice: event.ticketPrice * qty,
                    bookingCode: Booking.generateCode(),
                },
            ],
            { session }
        );

        await session.commitTransaction();
        // Populate the event before returning so the Flutter app can render
        // the confirmation screen without a second request.
        await booking.populate('event');
        res.status(201).json(booking);
    } catch (err) {
        await session.abortTransaction();
        res.status(400).json({ message: err.message });
    } finally {
        session.endSession();
    }
};

// GET /api/bookings/mine — the logged-in user's own bookings
exports.getMyBookings = async (req, res) => {
    try {
        const bookings = await Booking.find({ user: req.user._id })
            .populate('event') // pulls in full event details, not just the ID
            .sort({ createdAt: -1 });
        res.json(bookings);
    } catch (err) {
        res.status(500).json({ message: err.message });
    }
};

// GET /api/bookings — ALL bookings (admin only)
exports.getAllBookings = async (req, res) => {
    try {
        const bookings = await Booking.find()
            .populate('event')
            .populate('user', 'name email') // only pull safe fields, never password
            .sort({ createdAt: -1 });
        res.json(bookings);
    } catch (err) {
        res.status(500).json({ message: err.message });
    }
};

// PATCH /api/bookings/:id/status   body: { status }  (admin only)
exports.updateBookingStatus = async (req, res) => {
    try {
        const { status } = req.body;
        if (!['confirmed', 'cancelled', 'checked_in'].includes(status)) {
            return res.status(400).json({ message: 'Invalid status' });
        }

        const booking = await Booking.findByIdAndUpdate(req.params.id, { status }, { new: true })
            .populate('event')
            .populate('user', 'name email');
        if (!booking) return res.status(404).json({ message: 'Booking not found' });
        res.json(booking);
    } catch (err) {
        res.status(500).json({ message: err.message });
    }
};
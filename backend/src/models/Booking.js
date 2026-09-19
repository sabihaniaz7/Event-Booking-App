// models/Booking.js
//
// Each booking links a User to an Event plus how many tickets and a
// unique bookingCode — that code is what gets turned into a QR image
// on the Flutter side and scanned at the door.

const mongoose = require('mongoose');
const crypto = require('crypto');

const bookingSchema = new mongoose.Schema(
    {
        user: { type: mongoose.Schema.Types.ObjectId, ref: 'User', required: true },
        event: { type: mongoose.Schema.Types.ObjectId, ref: 'Event', required: true },
        quantity: { type: Number, required: true, min: 1 },
        totalPrice: { type: Number, required: true },
        bookingCode: { type: String, required: true, unique: true },
        status: {
            type: String,
            enum: ['confirmed', 'cancelled', 'checked_in'],
            default: 'confirmed',
        },
    },
    { timestamps: true }
);

// Generates something like "EVB-9F3A1C7B" — short, unique, easy to
// display under a QR code as a human-readable fallback.
bookingSchema.statics.generateCode = function () {
    return `EVB-${crypto.randomBytes(4).toString('hex').toUpperCase()}`;
};

module.exports = mongoose.model('Booking', bookingSchema);
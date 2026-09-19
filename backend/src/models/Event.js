// models/Event.js
//
// Note the `text` index below on title/description/location — that's
// what makes MongoDB's full-text $text search work for the search bar,
// without writing any regex matching yourself.

const mongoose = require('mongoose');
const eventSchema = new mongoose.Schema(
    {
        title: { type: String, required: true, trim: true },
        description: { type: String, required: true },
        category: {
            type: String,
            required: true,
            enum: ['Music', 'Sports', 'Arts', 'Business', 'Food', 'Tech', 'Community'],
        },
        imageUrl: { type: String, required: true },
        location: { type: String, required: true },
        date: { type: Date, required: true }, // event start date/time
        ticketPrice: { type: Number, required: true, min: 0 },
        totalSeats: { type: Number, required: true, min: 1 },
        bookedSeats: { type: Number, default: 0 },
        isFeatured: { type: Boolean, default: false },
        createdBy: { type: mongoose.Schema.Types.ObjectId, ref: 'User', required: true },
    },
    { timestamps: true }
);


eventSchema.index({ title: 'text', description: 'text', location: 'text' });

// Virtual field — not stored in DB, computed on the fly whenever an
// event is read. Keeps "seats left" logic in one place.
eventSchema.virtual('seatsAvailable').get(function () {
    return this.totalSeats - this.bookedSeats;
});
eventSchema.set('toJSON', { virtuals: true });

module.exports = mongoose.model('Event', eventSchema);
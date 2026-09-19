const Event = require('../models/Event');

// GET /api/events?search=&category=&sort=upcoming
// One endpoint handles home feed, category browse, AND search — the
// Flutter side just changes which query params it sends.
exports.getEvents = async (req, res) => {
    try {
        const { search, category, featured } = req.query;
        const query = {};

        if (search) query.$text = { $search: search };
        if (category) query.category = category;
        if (featured === 'true') query.isFeatured = true;

        const events = await Event.find(query).sort({ date: 1 }); // soonest first
        res.json(events);
    } catch (err) {
        res.status(500).json({ message: err.message });
    }
};

// GET /api/events/:id
exports.getEventById = async (req, res) => {
    try {
        const event = await Event.findById(req.params.id);
        if (!event) return res.status(404).json({ message: 'Event not found' });
        res.json(event);
    } catch (err) {
        res.status(500).json({ message: err.message });
    }
};

// POST /api/events  (admin only — see routes/eventRoutes.js)
// Expects multipart/form-data: fields + a single `image` file.
exports.createEvent = async (req, res) => {
    try {
        if (!req.file) return res.status(400).json({ message: 'Event image is required' });

        const event = await Event.create({
            ...req.body,
            imageUrl: `/uploads/${req.file.filename}`,
            createdBy: req.user._id,
        });
        res.status(201).json(event);
    } catch (err) {
        res.status(500).json({ message: err.message });
    }
};

// PUT /api/events/:id  (admin only)
exports.updateEvent = async (req, res) => {
    try {
        const updates = { ...req.body };
        if (req.file) updates.imageUrl = `/uploads/${req.file.filename}`;

        const event = await Event.findByIdAndUpdate(req.params.id, updates, { new: true });
        if (!event) return res.status(404).json({ message: 'Event not found' });
        res.json(event);
    } catch (err) {
        res.status(500).json({ message: err.message });
    }
};

// DELETE /api/events/:id  (admin only)
exports.deleteEvent = async (req, res) => {
    try {
        const event = await Event.findByIdAndDelete(req.params.id);
        if (!event) return res.status(404).json({ message: 'Event not found' });
        res.json({ message: 'Event deleted' });
    } catch (err) {
        res.status(500).json({ message: err.message });
    }
};
// routes/eventRoutes.js

const express = require('express');
const router = express.Router();

const {
    getEvents,
    getEventById,
    createEvent,
    updateEvent,
    deleteEvent,
} = require('../controllers/eventController');
const { protect, adminOnly } = require('../middleware/auth');
const upload = require('../middleware/upload');


// Public — anyone can browse events, even before logging in.
router.get('/', getEvents);
router.get('/:id', getEventById);

// Admin only — `protect` confirms it's a valid logged-in user,
// `adminOnly` then confirms that user's role. `upload.single('image')`
// runs before the controller so req.file is ready by the time it's called.
router.post('/', protect, adminOnly, upload.single('image'), createEvent);
router.put('/:id', protect, adminOnly, upload.single('image'), updateEvent);
router.delete('/:id', protect, adminOnly, deleteEvent);

module.exports = router;
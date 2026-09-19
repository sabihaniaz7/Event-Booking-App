// routes/authRoutes.js
//
// `router` is a mini Express app just for auth. server.js will mount it
// at /api/auth, so these become: POST /api/auth/signup, etc.
const express = require('express');
const router = express.Router();
const { signup, login, getMe } = require('../controllers/authController');
const { protect } = require('../middleware/auth');


router.post('/signup', signup);
router.post('/login', login);
router.get('/me', protect, getMe); // `protect` runs first, then getMe

module.exports = router;

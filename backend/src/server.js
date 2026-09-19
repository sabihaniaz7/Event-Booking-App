// server.js — the entry point. Run with: node src/server.js
// (or add "dev": "nodemon src/server.js" to package.json scripts)

require('dotenv').config();
const path = require('path');
const express = require('express');
const cors = require('cors');
const connectDB = require('./config/db');
const authRoutes = require('./routes/authRoutes');
const eventRoutes = require('./routes/eventRoutes');
const bookingRoutes = require('./routes/bookingRoutes');
const adminRoutes = require('./routes/adminRoutes');

const app = express();

connectDB();

app.use(cors()); // allows your Flutter app (different origin) to call this API
app.use(express.json()); // parses incoming JSON bodies into req.body — replaces manual stream parsing

// Makes uploaded event images reachable at http://<host>:5000/uploads/<filename>
// — this is what Event.imageUrl paths resolve against on the Flutter side.
app.use('/uploads', express.static(path.join(__dirname, 'uploads')));

app.use('/api/auth', authRoutes);
app.use('/api/events', eventRoutes);
app.use('/api/bookings', bookingRoutes);
app.use('/api/admin', adminRoutes);

app.get('/', (req, res) => res.json({ status: 'Event Booking API running' }));

const PORT = process.env.PORT || 5000;
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
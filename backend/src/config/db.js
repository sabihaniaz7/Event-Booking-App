// config/db.js
//
// This file's only job: connect to MongoDB Atlas cluster once when
// the server starts. `mongoose` is a library that turns MongoDB's raw
// documents into JS objects with schemas/validation — without it you'd
// be hand-writing validation for every field yourself.

const mongoose = require('mongoose');

async function connectDB() {
    try {
        // process.env.MONGO_URI comes from .env file — never hardcode
        // the real connection string in code (it contains DB password).
        await mongoose.connect(process.env.MONGO_URI);
        console.log('MongoDB connected successfully!');
    }
    catch (error) {
        console.error('mongoDb connection failed', error.message);
        process.exit(1);// stop the server — nothing works without a DB anyway
    }
}

module.exports = connectDB;
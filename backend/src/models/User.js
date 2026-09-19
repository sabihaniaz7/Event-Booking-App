// models/User.js
//
// A Mongoose "schema" defines the shape of a document + validation rules.
// `mongoose.model('User', userSchema)` turns that into a class you can
// call User.find(), User.create(), etc. on — MongoDB does the storage,
// Mongoose gives the safety net.

const mongoose = require('mongoose');
const bcrypt = require('bcryptjs');

const userSchema = new mongoose.Schema(
    {
        name: { type: String, required: true, trim: true },
        email: { type: String, required: true, unique: true, lowercase: true, trim: true },
        password: { type: String, required: true, select: false }, // select:false = never returned by default queries
        role: { type: String, enum: ['user', 'admin'], default: 'user' },
        avatarUrl: { type: String, default: null },
    },
    { timestamps: true } // adds createdAt/updatedAt automatically
);

// Runs automatically right before a User document is saved.
// This is WHY you never see plain-text passwords in the database.
userSchema.pre('save', async function () {
    if (!this.isModified('password')) return; // skip re-hashing on unrelated updates
    const salt = await bcrypt.genSalt(10);
    this.password = await bcrypt.hash(this.password, salt);
});

// Instance method: call `user.comparePassword('typed123')` during login
// instead of writing bcrypt.compare() everywhere.
userSchema.methods.comparePassword = function (candidatePassword) {
    return bcrypt.compare(candidatePassword, this.password);
};

module.exports = mongoose.model('User', userSchema);
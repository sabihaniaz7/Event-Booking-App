// middleware/upload.js
//
// `multer` handles multipart/form-data (file uploads) — Express's built-in
// express.json() only understands JSON, not files, so this is a separate
// piece. Files get saved to backend/src/uploads/ and served as static
// files (see the app.use('/uploads', ...) line in server.js).

const multer = require('multer');
const path = require('path');
const fs = require('fs');

const uploadDir = path.join(__dirname, '../uploads');
if (!fs.existsSync(uploadDir)) {
    fs.mkdirSync(uploadDir, { recursive: true });
}

const storage = multer.diskStorage({
    destination: (req, file, cb) => cb(null, uploadDir),
    filename: (req, file, cb) => {
        // Prefix with a timestamp so two uploads never overwrite each other.
        cb(null, `${Date.now()}-${file.originalname}`);
    },
});
const fileFilter = (req, file, cb) => {
    const allowed = ['image/jpeg', 'image/png', 'image/webp'];
    if (allowed.includes(file.mimetype)) cb(null, true);
    else cb(new Error('Only JPG, PNG or WEBP images are allowed'), false);
};

module.exports = multer({ storage, fileFilter, limits: { fileSize: 5 * 1024 * 1024 } });
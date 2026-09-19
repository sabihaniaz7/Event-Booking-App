#  Event Booking App

A full-stack mobile app for discovering events and booking tickets — built with **Flutter** (clean architecture + Riverpod + go_router) and a **Node.js / Express / MongoDB** REST API.

Users can browse events, filter by category, book tickets, and get a QR-coded ticket. Admins get a full dashboard to manage events, bookings, and users.

---

## Features

### User
- Sign up / Login (JWT-based auth)
- Home screen with featured & upcoming events
- Browse by category, live search & filter
- Event details — image, date, time, location, description, price
- Book tickets with a quantity selector and live seat availability
- Booking confirmation with a unique code + QR ticket
- My Bookings screen
- Light & dark mode, system-aware

### Admin
- Admin dashboard — users / events / bookings / revenue stats
- Create, edit, delete events (with image upload)
- Set ticket price & seat count per event
- View all bookings, mark checked-in / cancel
- View all registered users
- Role-gated routes — regular users can never reach admin screens

---

## Tech Stack

| Layer | Tech |
|---|---|
| Mobile | Flutter, Riverpod, go_router |
| Backend | Node.js, Express |
| Database | MongoDB (Atlas) via Mongoose |
| Auth | JWT + bcrypt password hashing |
| Image upload | Multer |
| Networking | Dio |

---

## Project Structure

```
event_booking_app/
├── lib/                          # Flutter app
│   ├── core/
│   │   ├── theme/                # Colors, sizes, text styles, light/dark ThemeData
│   │   ├── router/                # go_router config + auth/admin guards
│   │   └── network/                # Dio client, token storage, error handling
│   ├── features/
│   │   ├── auth/                  # Login, signup, session state
│   │   ├── home/                  # Home feed
│   │   ├── events/                # Browse, search, filter, event details
│   │   ├── booking/                # Book ticket, my bookings, QR ticket
│   │   └── admin/                  # Dashboard, event/booking/user management
│   │   (each feature: data/ domain/ presentation/)
│   ├── app.dart
│   └── main.dart
│
└── backend/                      # Node.js API
    └── src/
        ├── config/                # MongoDB connection
        ├── models/                # User, Event, Booking (Mongoose schemas)
        ├── middleware/             # JWT auth, admin guard, image upload
        ├── controllers/            # Business logic
        ├── routes/                 # Express routers
        └── server.js
```

Each Flutter feature follows clean architecture:
- **domain/** — entities & repository interfaces (no Flutter or network imports)
- **data/** — models, remote data sources, repository implementations
- **presentation/** — Riverpod controllers, screens, widgets

---

## Getting Started

### Prerequisites
- Flutter SDK ≥ 3.47
- Node.js ≥ 26
- A free [MongoDB Atlas](https://www.mongodb.com/cloud/atlas) cluster

### 1. Backend setup

```bash
cd backend
npm install
cp .env.example .env
```

Fill in `.env`:
```env
MONGO_URI=mongodb+srv://<user>:<password>@cluster0.xxxxx.mongodb.net/eventBookingDB
JWT_SECRET=<a long random string>
PORT=5000
```

Run it:
```bash
npm run dev
```
The API is now live at `http://localhost:5000/api`.

### 2. Flutter setup

```bash
flutter pub get
dart run build_runner build -d   # generates Riverpod codegen files
```

If running on an **Android emulator**, the app is preconfigured to reach the backend at `10.0.2.2:5000` (emulator's alias for your machine's localhost). Update `kBaseUrl` in `lib/core/network/dio_client.dart` if you're using a physical device or iOS simulator — use your machine's LAN IP instead.

```bash
flutter run
```

### 3. Create an admin account

Sign up normally through the app, then in MongoDB Atlas open the `users` collection and change that document's `role` field from `"user"` to `"admin"`. Log back in — you'll land on the admin dashboard automatically.

---

## API Reference

| Method | Endpoint | Auth | Description |
|---|---|---|---|
| POST | `/api/auth/signup` | — | Create account |
| POST | `/api/auth/login` | — | Log in, returns JWT |
| GET | `/api/auth/me` | User | Current user profile |
| GET | `/api/events` | — | List events (`?search=&category=&featured=`) |
| GET | `/api/events/:id` | — | Event details |
| POST | `/api/events` | Admin | Create event (multipart, field `image`) |
| PUT | `/api/events/:id` | Admin | Update event |
| DELETE | `/api/events/:id` | Admin | Delete event |
| POST | `/api/bookings` | User | Book tickets `{ eventId, quantity }` |
| GET | `/api/bookings/mine` | User | My bookings |
| GET | `/api/bookings` | Admin | All bookings |
| PATCH | `/api/bookings/:id/status` | Admin | Update booking status |
| GET | `/api/admin/stats` | Admin | Dashboard totals |
| GET | `/api/admin/users` | Admin | All registered users |

---

## Design System

- **Colors** (`core/theme/app_colors.dart`) — a `ThemeExtension` with full light & dark palettes, accessed via `context.colors.primary` etc.
- **Sizes** (`core/theme/app_sizes.dart`) — named-by-value spacing scale (`xs4`, `s8`, `m12`, `m16`, `l24`, `l32`...) so a size's name always tells you its pixel value.
- **Typography** — Plus Jakarta Sans via `google_fonts`, defined in `app_text_styles.dart`.

---
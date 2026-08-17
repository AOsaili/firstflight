# AI Travel App

An AI-powered travel companion for exploring Jordan. The app suggests nearby places and events, builds personalized recommendations based on user interests, and can chat with users to answer travel questions or generate trip plans using Google's Gemini AI.

The project has two parts:

- **[ai-travel-frontend-main/](ai-travel-frontend-main/ai-travel-frontend-main)** — Flutter mobile app (map view, chat, recommendations UI).
- **[AI_Travel_Backend-main/](AI_Travel_Backend-main/AI_Travel_Backend-main)** — FastAPI backend (Firestore data, Gemini-powered chat and trip planning).

## Tech Stack

- **Frontend:** Flutter (Dart), `flutter_map` for maps, `geolocator` for location
- **Backend:** FastAPI (Python), Firebase Admin SDK (Firestore), Google Gemini (`google-genai`)

## Getting Started

### Backend

```bash
cd AI_Travel_Backend-main/AI_Travel_Backend-main
python -m venv .venv
.venv\Scripts\activate        # Windows
pip install -r requirements.txt
```

Create a `.env` file with your Gemini API key:

```
GEMINI_API_KEY=your_key_here
```

You'll also need a `firebase_key.json` service account file in this folder (Firebase Console → Project Settings → Service Accounts). Both `.env` and `firebase_key.json` are gitignored and must be provided locally.

Run the server:

```bash
uvicorn main:app --reload
```

The API will be available at `http://localhost:8000`.

### Frontend

```bash
cd ai-travel-frontend-main/ai-travel-frontend-main
flutter pub get
flutter run
```

## Backend API Overview

| Endpoint | Method | Description |
|---|---|---|
| `/places` | GET/POST | List or add places |
| `/events` | GET/POST | List or add events |
| `/places/nearby` | GET | Places within a radius of a location |
| `/recommendations` | GET | Places filtered by category and distance |
| `/multi-recommendations` | GET | Places and events across multiple categories |
| `/user-preferences` | POST | Save a user's interests |
| `/personalized-recommendations` | GET | Recommendations based on saved interests |
| `/smart-recommendations` / `/ranked-recommendations` | GET | Ranked recommendations for a user |
| `/chat` | POST | General chat with the AI assistant |
| `/smart-chat` | POST | Chat combined with location-based recommendations |
| `/trip-planner` | POST | AI-generated trip plan from preferences |

from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from models.schemas import (
    Place,
    Event,
    UserPreferences,
    ChatRequest,
    SmartChatRequest,
    TripPlannerRequest
)
from services.firebase_service import db
from utils.helpers import calculate_distance
from services.gemini_service import gemini_client
from services.recommendation_service import get_smart_recommendations
from services.chat_service import (
    generate_chat_reply,
    generate_smart_chat_reply,
    generate_trip_plan
)
app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)
@app.get("/")
def home():
    return {"message": "AI Travel Backend is working!"}


@app.get("/firebase-test")
def firebase_test():
    return {"message": "Firebase connected successfully!"}
@app.get("/firestore-write-test")
def firestore_write_test():
    doc_ref = db.collection("test").document("first_document")

    doc_ref.set({
        "message": "Hello from FastAPI",
        "status": "working"
    })

    return {"message": "Data written to Firestore successfully!"}
@app.post("/places")
def add_place(place: Place):
    doc_ref = db.collection("places").document()

    doc_ref.set({
        "name": place.name,
        "category": place.category,
        "description": place.description,
        "latitude": place.latitude,
        "longitude": place.longitude,
        "rating": place.rating
    })

    return {
        "message": "Place added successfully!",
        "id": doc_ref.id
    }
@app.get("/places")
def get_places():
    docs = db.collection("places").stream()

    places = []

    for doc in docs:
        place_data = doc.to_dict()
        place_data["id"] = doc.id
        places.append(place_data)

    return places
@app.get("/places/nearby")
def get_nearby_places(latitude: float, longitude: float, radius: float = 1):
    docs = db.collection("places").stream()

    nearby_places = []

    for doc in docs:
        place = doc.to_dict()

        distance = calculate_distance(
            latitude,
            longitude,
            place["latitude"],
            place["longitude"]
        )

        if distance <= radius:
            place["id"] = doc.id
            place["distance_km"] = round(distance, 2)
            nearby_places.append(place)

    return nearby_places
@app.post("/events")
def add_event(event: Event):
    doc_ref = db.collection("events").document()

    doc_ref.set({
        "name": event.name,
        "category": event.category,
        "description": event.description,
        "latitude": event.latitude,
        "longitude": event.longitude,
        "date": event.date,
        "price": event.price,
        "rating": event.rating
    })

    return {
        "message": "Event added successfully!",
        "id": doc_ref.id
    }


@app.get("/events")
def get_events():
    docs = db.collection("events").stream()

    events = []

    for doc in docs:
        event_data = doc.to_dict()
        event_data["id"] = doc.id
        events.append(event_data)

    return events
@app.get("/recommendations")
def get_recommendations_by_category(
    latitude: float,
    longitude: float,
    category: str,
    radius: float = 5
):
    docs = db.collection("places").stream()

    recommendations = []

    for doc in docs:
        place = doc.to_dict()

        if place["category"].lower() != category.lower():
            continue

        distance = calculate_distance(
            latitude,
            longitude,
            place["latitude"],
            place["longitude"]
        )

        if distance <= radius:
            place["id"] = doc.id
            place["distance_km"] = round(distance, 2)
            recommendations.append(place)

    recommendations.sort(key=lambda x: x["distance_km"])

    return recommendations
@app.get("/smart-recommendations")
def smart_recommendations_endpoint(
    user_id: str,
    latitude: float,
    longitude: float,
    radius: float = 5
):
    results = get_smart_recommendations(
        user_id,
        latitude,
        longitude,
        radius
    )

    if results is None:
        return {"message": "User preferences not found"}

    return results
@app.get("/multi-recommendations")
def get_multi_recommendations(
    latitude: float,
    longitude: float,
    categories: str,
    radius: float = 5
):
    category_list = [c.strip().lower() for c in categories.split(",")]

    results = []

    # Places
    place_docs = db.collection("places").stream()

    for doc in place_docs:
        place = doc.to_dict()

        if place["category"].lower() not in category_list:
            continue

        distance = calculate_distance(
            latitude,
            longitude,
            place["latitude"],
            place["longitude"]
        )

        if distance <= radius:
            place["id"] = doc.id
            place["distance_km"] = round(distance, 2)
            place["type"] = "place"
            results.append(place)

    # Events
    event_docs = db.collection("events").stream()

    for doc in event_docs:
        event = doc.to_dict()

        if event["category"].lower() not in category_list:
            continue

        distance = calculate_distance(
            latitude,
            longitude,
            event["latitude"],
            event["longitude"]
        )

        if distance <= radius:
            event["id"] = doc.id
            event["distance_km"] = round(distance, 2)
            event["type"] = "event"
            results.append(event)

    results.sort(key=lambda x: x["distance_km"])

    return results
@app.post("/user-preferences")
def save_user_preferences(preferences: UserPreferences):
    db.collection("user_preferences").document(preferences.user_id).set({
        "interests": preferences.interests
    })

    return {
        "message": "User preferences saved successfully!",
        "user_id": preferences.user_id,
        "interests": preferences.interests
    }
@app.get("/personalized-recommendations")
def personalized_recommendations(
    user_id: str,
    latitude: float,
    longitude: float,
    radius: float = 5
):
    user_doc = db.collection("user_preferences").document(user_id).get()

    if not user_doc.exists:
        return {"message": "User preferences not found"}

    user_data = user_doc.to_dict()
    interests = [item.lower() for item in user_data.get("interests", [])]

    results = []

    place_docs = db.collection("places").stream()

    for doc in place_docs:
        place = doc.to_dict()

        if place["category"].lower() not in interests:
            continue

        distance = calculate_distance(
            latitude,
            longitude,
            place["latitude"],
            place["longitude"]
        )

        if distance <= radius:
            place["id"] = doc.id
            place["distance_km"] = round(distance, 2)
            place["type"] = "place"
            results.append(place)

    event_docs = db.collection("events").stream()

    for doc in event_docs:
        event = doc.to_dict()

        if event["category"].lower() not in interests:
            continue

        distance = calculate_distance(
            latitude,
            longitude,
            event["latitude"],
            event["longitude"]
        )

        if distance <= radius:
            event["id"] = doc.id
            event["distance_km"] = round(distance, 2)
            event["type"] = "event"
            results.append(event)

    results.sort(key=lambda x: x["distance_km"])

    return {
        "user_id": user_id,
        "interests": interests,
        "recommendations": results
    }
@app.get("/ranked-recommendations")
def ranked_recommendations(
    user_id: str,
    latitude: float,
    longitude: float,
    radius: float = 5
):
    results = get_smart_recommendations(
        user_id,
        latitude,
        longitude,
        radius
    )

    if results is None:
        return {"message": "User preferences not found"}

    return {
        "user_id": user_id,
        "recommendations": results
    }
@app.get("/ai-test")
def ai_test():
    response = gemini_client.models.generate_content(
        model="gemini-3.6-flash",
        contents="Say: AI Travel Assistant is working!"
    )

    return {
        "message": response.text
    }
@app.post("/chat")
def chat(request: ChatRequest):
    return {
        "response": generate_chat_reply(request.message)
    }
@app.post("/smart-chat")
def smart_chat(request: SmartChatRequest):
    recommendations, reply = generate_smart_chat_reply(
        request.user_id,
        request.message,
        request.latitude,
        request.longitude,
        request.radius
    )

    if recommendations is None:
        return {
            "message": "User preferences not found"
        }

    return {
        "recommendations": recommendations,
        "response": reply
    }
@app.post("/trip-planner")
def trip_planner(request: TripPlannerRequest):

    recommendations, trip_plan = generate_trip_plan(
        request.user_id,
        request.latitude,
        request.longitude,
        request.radius,
        request.duration,
        request.preferences
    )

    if recommendations is None:
        return {"message": "User preferences not found"}

    if not recommendations:
        return {"message": "No suitable places or events found"}

    return {
        "user_id": request.user_id,
        "duration": request.duration,
        "recommendations": recommendations,
        "trip_plan": trip_plan
    }



from services.firebase_service import db
from utils.helpers import calculate_distance


# إنشاء توصيات ذكية حسب اهتمامات المستخدم والموقع والتقييم
def get_smart_recommendations(
    user_id: str,
    latitude: float,
    longitude: float,
    radius: float = 5
):
    user_doc = db.collection("user_preferences").document(user_id).get()

    if not user_doc.exists:
        return None

    user_data = user_doc.to_dict()
    interests = [
        item.strip().lower()
        for item in user_data.get("interests", [])
    ]

    results = []

    # الأماكن
    for doc in db.collection("places").stream():
        place = doc.to_dict()
        category = place.get("category", "").strip().lower()

        if category not in interests:
            continue

        distance = calculate_distance(
            latitude,
            longitude,
            place["latitude"],
            place["longitude"]
        )

        if distance <= radius:
            rating = place.get("rating", 3.0)

            distance_score = max(0, 100 - (distance * 20))
            rating_score = rating * 20
            score = (distance_score * 0.6) + (rating_score * 0.4)

            place["id"] = doc.id
            place["distance_km"] = round(distance, 2)
            place["score"] = round(score, 2)
            place["type"] = "place"

            results.append(place)

    # الفعاليات
    for doc in db.collection("events").stream():
        event = doc.to_dict()
        category = event.get("category", "").strip().lower()

        if category not in interests:
            continue

        distance = calculate_distance(
            latitude,
            longitude,
            event["latitude"],
            event["longitude"]
        )

        if distance <= radius:
            rating = event.get("rating", 3.0)

            distance_score = max(0, 100 - (distance * 20))
            rating_score = rating * 20
            score = (distance_score * 0.6) + (rating_score * 0.4)

            event["id"] = doc.id
            event["distance_km"] = round(distance, 2)
            event["score"] = round(score, 2)
            event["type"] = "event"

            results.append(event)

    results.sort(key=lambda item: item["score"], reverse=True)

    return results
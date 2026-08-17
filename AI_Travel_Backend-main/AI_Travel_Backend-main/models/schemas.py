from pydantic import BaseModel


class Place(BaseModel):
    name: str
    category: str
    description: str
    latitude: float
    longitude: float
    rating: float = 0


class Event(BaseModel):
    name: str
    category: str
    description: str
    latitude: float
    longitude: float
    date: str
    price: float
    rating: float = 0


class UserPreferences(BaseModel):
    user_id: str
    interests: list[str]


class ChatRequest(BaseModel):
    message: str


class SmartChatRequest(BaseModel):
    user_id: str
    message: str
    latitude: float
    longitude: float
    radius: float = 5


class TripPlannerRequest(BaseModel):
    user_id: str
    latitude: float
    longitude: float
    radius: float = 5
    duration: str
    preferences: str | None = None
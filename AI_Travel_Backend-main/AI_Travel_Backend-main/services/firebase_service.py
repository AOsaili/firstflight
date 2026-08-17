import os
import firebase_admin
from firebase_admin import credentials, firestore

_KEY_PATH = os.path.join(
    os.path.dirname(os.path.dirname(os.path.abspath(__file__))),
    "firebase_key.json",
)


# الاتصال مع Firebase
def initialize_firebase():
    if not firebase_admin._apps:
        cred = credentials.Certificate(_KEY_PATH)
        firebase_admin.initialize_app(cred)

    return firestore.client()


# الاتصال مع Firestore Database
db = initialize_firebase()
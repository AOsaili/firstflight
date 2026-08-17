from services.firebase_service import db
from services.gemini_service import gemini_client
from services.recommendation_service import get_smart_recommendations


# إنشاء رد عادي من Gemini باستخدام بيانات الأماكن والفعاليات
def generate_chat_reply(message: str):
    places = []
    events = []

    # جلب الأماكن
    for doc in db.collection("places").stream():
        places.append(doc.to_dict())

    # جلب الفعاليات
    for doc in db.collection("events").stream():
        events.append(doc.to_dict())

    prompt = f"""
You are an AI travel assistant for our travel application.

Use ONLY the places and events provided below when recommending something.
Do not invent places or events that are not in the data.

PLACES:
{places}

EVENTS:
{events}

User message:
{message}

Answer in Arabic if the user speaks Arabic.
Be concise and helpful.
"""

    response = gemini_client.models.generate_content(
        model="gemini-3.6-flash",
        contents=prompt
    )

    return response.text


# إنشاء رد ذكي حسب اهتمامات المستخدم وموقعه
def generate_smart_chat_reply(
    user_id: str,
    message: str,
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
        return None, None

    top_results = results[:5]

    prompt = f"""
أنت مساعد سفر ذكي.

رسالة المستخدم:
{message}

الأماكن والفعاليات المناسبة:
{top_results}

أجب باللغة العربية.
استخدم فقط الأماكن والفعاليات الموجودة في القائمة.
لا تخترع أماكن جديدة.
اجعل الإجابة واضحة ومفيدة.
"""

    response = gemini_client.models.generate_content(
        model="gemini-3.6-flash",
        contents=prompt
    )

    return top_results, response.text
# إنشاء خطة رحلة ذكية حسب اهتمامات المستخدم والموقع
def generate_trip_plan(
    user_id: str,
    latitude: float,
    longitude: float,
    radius: float,
    duration: str,
    preferences: str | None = None
):
    results = get_smart_recommendations(
        user_id,
        latitude,
        longitude,
        radius
    )

    if results is None:
        return None, None

    top_results = results[:6]

    if not top_results:
        return [], None

    prompt = f"""
أنت مساعد ذكي متخصص في تخطيط الرحلات.

أنشئ خطة رحلة مرتبة زمنيًا باللغة العربية.

مدة الرحلة:
{duration}

التفضيلات الإضافية:
{preferences or "لا توجد تفضيلات إضافية"}

الأماكن والفعاليات المتاحة:
{top_results}

التعليمات:
- استخدم فقط الأماكن والفعاليات الموجودة في القائمة.
- لا تخترع أي مكان أو فعالية جديدة.
- رتب الخطة زمنيًا.
- اذكر وقتًا مقترحًا لكل نشاط.
- اذكر اسم المكان أو الفعالية.
- أضف سببًا قصيرًا لاختيار كل نشاط.
- راعِ المسافة والتقييم.
- اجعل الخطة واضحة وسهلة القراءة.
"""

    response = gemini_client.models.generate_content(
        model="gemini-3.6-flash",
        contents=prompt
    )

    return top_results, response.text
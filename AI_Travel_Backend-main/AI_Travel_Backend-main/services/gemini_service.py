import os
from dotenv import load_dotenv
from google import genai

# تحميل متغيرات البيئة
load_dotenv()

# الاتصال مع Gemini
gemini_client = genai.Client(
    api_key=os.getenv("GEMINI_API_KEY")
)
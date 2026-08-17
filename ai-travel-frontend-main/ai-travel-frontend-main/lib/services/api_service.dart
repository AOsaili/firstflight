import 'dart:convert';
import 'package:http/http.dart' as http;

const String _prodBaseUrl = "https://ai-travel-backend-dpgw.onrender.com";
const String _localBaseUrl = "http://localhost:8000";

class ApiService {
  static Future<Map<String, dynamic>> planTrip({
    required String userId,
    required double latitude,
    required double longitude,
    required String duration,
    String? preferences,
    double radius = 50,
  }) async {
    final body = jsonEncode({
      "user_id": userId,
      "latitude": latitude,
      "longitude": longitude,
      "radius": radius,
      "duration": duration,
      "preferences": preferences,
    });

    try {
      return await _post(_prodBaseUrl, body);
    } catch (_) {
      return await _post(_localBaseUrl, body);
    }
  }

  static Future<List<dynamic>> getPlaces() async {
    try {
      return await _get(_prodBaseUrl, "/places");
    } catch (_) {
      return await _get(_localBaseUrl, "/places");
    }
  }

  static Future<List<dynamic>> getEvents() async {
    try {
      return await _get(_prodBaseUrl, "/events");
    } catch (_) {
      return await _get(_localBaseUrl, "/events");
    }
  }

  static Future<Map<String, dynamic>> _post(
    String baseUrl,
    String body,
  ) async {
    final response = await http
        .post(
          Uri.parse("$baseUrl/trip-planner"),
          headers: {"Content-Type": "application/json"},
          body: body,
        )
        .timeout(const Duration(seconds: 10));

    if (response.statusCode != 200) {
      throw Exception("Trip planner request failed: ${response.statusCode}");
    }

    return jsonDecode(response.body) as Map<String, dynamic>;
  }

  static Future<List<dynamic>> _get(String baseUrl, String path) async {
    final response = await http
        .get(Uri.parse("$baseUrl$path"))
        .timeout(const Duration(seconds: 10));

    if (response.statusCode != 200) {
      throw Exception("$path request failed: ${response.statusCode}");
    }

    return jsonDecode(response.body) as List<dynamic>;
  }
}

import 'dart:convert';

import 'package:http/http.dart' as http;

import 'surah.dart';

class SurahService {
  // Use local network IP for both emulator and physical devices
  static const String baseUrl = 'http://192.168.52.125:5000/api';

  // Alternative URL for localhost (emulator only)
  // static const String baseUrl = 'http://127.0.0.1:5000/api';

  Future<List<Surah>> getSurahs() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/surahs'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['status'] == 'success') {
          final List<dynamic> surahsJson = data['data'];
          return surahsJson.map((json) => Surah.fromJson(json)).toList();
        } else {
          throw Exception(data['message'] ?? 'Failed to load surahs');
        }
      } else {
        throw Exception('Failed to load surahs');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}

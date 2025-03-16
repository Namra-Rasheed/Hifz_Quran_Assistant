import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map<String, dynamic>> fetchPrayerTimes(String city) async {
  final response = await http.get(Uri.parse('http://api.aladhan.com/v1/timingsByCity?city=Lahore&country=Pakistan&method=2'));

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    if (data['data'] != null && data['data']['timings'] != null) {
      return data['data']['timings'];
    } else {
      throw Exception('Unexpected data format');
    }
  } else {
    throw Exception('Failed to load prayer times');
  }
}

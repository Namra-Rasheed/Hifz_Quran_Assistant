import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'recitation_model.dart';

class ApiService {
  static Future<Recitation?> uploadAudio(String surahId, File audioFile) async {
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('http://192.168.52.125:5000/api/check-recitation'),
    );
    request.fields['surah_id'] = surahId;
    request.files.add(
      await http.MultipartFile.fromPath('audio', audioFile.path), // Change field name to 'audio'
    );

    try {
      final response = await request.send();
      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        final decodedData = json.decode(responseData);
        return Recitation.fromJson(decodedData);
      } else {
        print('Failed Response Status Code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error while uploading audio: $e');
      return null;
    }
  }
}

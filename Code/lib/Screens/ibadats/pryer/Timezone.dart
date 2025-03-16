import 'package:flutter_timezone/flutter_timezone.dart';

class TimezoneSetup {
  static Future<String> getCurrentTimezone() async {
    try {
      return await FlutterTimezone.getLocalTimezone();
    } catch (e) {
      return 'Failed to get timezone.';
    }
  }
}

import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

void initializeNotifications() {
  final InitializationSettings initializationSettings = InitializationSettings(
    android: AndroidInitializationSettings('@mipmap/ic_launcher'),
  );
  flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

void playAlarm(DateTime scheduledTime, String key, Map<String, bool> alarmStatus) async {
  DateTime now = DateTime.now();
  Duration difference = scheduledTime.difference(now);

  if (difference.isNegative) {
    // Time is in the past, do not set the alarm
    return;
  }

  await Future.delayed(difference, () {
    FlutterRingtonePlayer().play(
      android: AndroidSounds.alarm,
      ios: IosSounds.alarm,
      looping: true,
      volume: 1.0,
      asAlarm: true,
    );

    // Display a persistent notification
    flutterLocalNotificationsPlugin.show(
      key.hashCode,
      'Namaz Reminder',
      'It\'s time for $key prayer',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'your channel id',
          'your channel name',

          importance: Importance.max,
          priority: Priority.high,
          ongoing: true,
        ),
      ),
    );

    // Continuously check if the alarm status is still active
    if (alarmStatus[key]!) {
      // Re-schedule the alarm for the next day
      DateTime nextDaySameTime = scheduledTime.add(Duration(days: 1));
      playAlarm(nextDaySameTime, key, alarmStatus);
    }
  });
}

void stopAlarm() {
  FlutterRingtonePlayer().stop();
  flutterLocalNotificationsPlugin.cancelAll();
}

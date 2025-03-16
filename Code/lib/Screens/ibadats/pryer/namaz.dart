import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import the intl package
import 'prayer_times_api.dart'; // Import API functions
import 'notification_helper.dart'; // Import alarm functions
import 'Timezone.dart'; // Import timezone setup

class PrayerTimesScreen extends StatefulWidget {
  @override
  _PrayerTimesScreenState createState() => _PrayerTimesScreenState();
}

class _PrayerTimesScreenState extends State<PrayerTimesScreen> {
  String _timezone = 'Fetching...';
  Map<String, String>? _prayerTimings; // Make nullable
  bool _isLoading = true;
  Map<String, bool>? _alarmStatus; // Make nullable

  @override
  void initState() {
    super.initState();
    _getTimeZone();
    _fetchPrayerTimes();
  }

  Future<void> _getTimeZone() async {
    String timezone = await TimezoneSetup.getCurrentTimezone();
    setState(() {
      _timezone = timezone;
    });
  }

  Future<void> _fetchPrayerTimes() async {
    var timings = await fetchPrayerTimes('Lahore'); // Ensure the city is specified here
    setState(() {
      // Convert Map<String, dynamic> to Map<String, String>
      _prayerTimings = Map<String, String>.from(timings.map((key, value) => MapEntry(key, value.toString())));
      // Initialize alarm status for each prayer time
      _alarmStatus = Map<String, bool>.fromEntries(timings.keys.map((key) => MapEntry(key, false)));
      _isLoading = false;
    });
  }

  void _toggleAlarm(String key) {
    setState(() {
      _alarmStatus![key] = !_alarmStatus![key]!;
    });

    String statusMessage;
    if (_alarmStatus![key]!) {
      DateTime now = DateTime.now();
      String dateString = DateFormat('yyyy-MM-dd').format(now); // Get the current date
      String timeString = _prayerTimings![key]!;
      String dateTimeString = '$dateString $timeString';

      try {
        DateTime scheduledTime = DateFormat('yyyy-MM-dd HH:mm').parse(dateTimeString);
        playAlarm(scheduledTime, key, _alarmStatus!); // Pass the alarm status map
        statusMessage = 'Alarm set for $key at $timeString';
      } catch (e) {
        print('Error parsing date: $e');
        statusMessage = 'Failed to set alarm for $key';
      }
    } else {
      stopAlarm();
      statusMessage = 'Alarm turned off for $key';
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.green[100],
          title: Text('Alarm Status'),
          content: Text(statusMessage),
          actions: <Widget>[
            TextButton(
              child: Text('OK', style: TextStyle(color: Colors.black)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Namaz Notification App'),
        centerTitle: true,
        backgroundColor: Colors.lightGreen,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Container(
        color: Colors.green[50], // Set background color to green
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 20),
              Expanded(
                child: ListView(
                  children: _prayerTimings!.entries.map((entry) {
                    return Card(
                      color: Colors.lightGreen[200],
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: ListTile(
                        title: Text(
                          entry.key,
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        subtitle: Text(
                          entry.value,
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                        trailing: Icon(
                          Icons.notifications_active,
                          color: _alarmStatus![entry.key]! ? Colors.green : Colors.white,
                        ),
                        onTap: () {
                          _toggleAlarm(entry.key);
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

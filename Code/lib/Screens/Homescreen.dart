import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';
import '../models/ayaoftheday.dart';
import '../qibladirection/mainqibla.dart';
import '../services/apiServices.dart';
import 'Allahnames/Allahnamess.dart';
import 'ibadats/prayertime.dart';
import 'login_page.dart';
import 'mainscreen.dart';

class homescreen extends StatefulWidget {
  const homescreen({super.key});

  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {
  final ApiServices _apiServices = ApiServices();
  late Timer _timer;
  Future<Ayatofday>? _currentAya;

  @override
  void initState() {
    super.initState();
    _fetchAya();
    _startAutoUpdate();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _fetchAya() {
    setState(() {
      _currentAya = _apiServices.getAyaOfTheDay();
    });
  }

  void _startAutoUpdate() {
    _timer = Timer.periodic(Duration(seconds: 10), (timer) {
      _fetchAya();
    });
  }

  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    HijriCalendar.setLocal('ar');
    var _hijri = HijriCalendar.now();
    var day = DateTime.now();
    var format = DateFormat('EEE, d MMM yyy');
    var formatted = format.format(day);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightGreen,
          centerTitle: true,
          title: Text(
            'القرآن الكريم',
            style: TextStyle(color: Colors.white,fontSize: 30),
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.green[100],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('images/prayyer.png'),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Username',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      'user@Gmail.com',
                      style: TextStyle(
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Home'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => mainscreen()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('Account Setting'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.history),
                title: Text('Check History'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.support),
                title: Text('Support'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text('Logout'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
              ),
            ],
          ),
        ),
        body: Container(
          color: Colors.lime[50],
          child: ListView(
            children: [
              // Header Section with Hijri and Gregorian Date
              Container(
                height: 250,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.lightGreen,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('images/imog.png'),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      formatted,
                      style: TextStyle(color: Colors.black87, fontSize: 30),
                    ),
                    RichText(
                      text: TextSpan(
                        children: <InlineSpan>[
                          WidgetSpan(
                            child: Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Text(
                                _hijri.hDay.toString(),
                                style: TextStyle(fontSize: 25, color: Colors.black54),
                              ),
                            ),
                          ),
                          WidgetSpan(
                            child: Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Text(
                                _hijri.longMonthName,
                                style: TextStyle(fontSize: 28, color: Colors.black54, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          WidgetSpan(
                            child: Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Text(
                                '${_hijri.hYear} AH',
                                style: TextStyle(fontSize: 25, color: Colors.black54),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Aya of the Day section
              FutureBuilder<Ayatofday>(
                future: _currentAya,
                builder: (context, snapshot) {
                  return AnimatedSwitcher(
                    duration: Duration(seconds: 1),
                    transitionBuilder: (child, animation) {
                      return SlideTransition(
                        position: Tween<Offset>(
                          begin: Offset(1.0, 0.0),
                          end: Offset(0.0, 0.0),
                        ).animate(animation),
                        child: child,
                      );
                    },
                    child: snapshot.connectionState == ConnectionState.done
                        ? snapshot.hasData
                        ? _buildAyaCard(snapshot.data!)
                        : Text("Error loading Ayat")
                        : CircularProgressIndicator(),
                  );
                },
              ),

              // Cards Section
              Container(
                padding: EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly, // To space the cards evenly across the row
                  children: [
                    // First Card
                    Container(
                      width: 100,
                      height: 120,
                      child: Card(
                        color: Colors.lightGreen[200],
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => NamesOfAllah()),
                            );
                            print('First card tapped');
                          },
                          child: Container(
                            height: 130,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'images/Allah.png', // Replace with correct image path
                                    height: 40,
                                    width: 40,
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    'Allah Names',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Second Card
                    Container(
                      width: 100,
                      height: 120,
                      child: Card(
                        color: Colors.green[100],
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MainQiblaApp()),
                            );
                          },
                          child: Container(
                            height: 130,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.explore, color: Colors.black, size: 40), // Qibla Direction Icon
                                  SizedBox(height: 10),
                                  Text(
                                    'Qibla Direction',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Third Card
                    Container(
                      width: 100,
                      height: 120,
                      child: Card(
                        color: Colors.lightGreen[200],
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => PrayerTimesPage()),
                            );
                            print('Second card tapped');
                          },
                          child: Container(
                            height: 130,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.access_time, color: Colors.black, size: 40), // Prayer Times Icon
                                  SizedBox(height: 10),
                                  Text(
                                    'Ibadaat',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

      ),
    );
  }

  Widget _buildAyaCard(Ayatofday aya) {
    return Container(
      key: ValueKey(aya.arText),
      margin: EdgeInsetsDirectional.all(16),
      padding: EdgeInsetsDirectional.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.green[50],
        boxShadow: [
          BoxShadow(
            blurRadius: 3,
            spreadRadius: 1,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            "Quran Aya of the Day",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Divider(
            color: Colors.black,
            thickness: 0.8,
          ),
          Text(
            aya.arText!,
            style: TextStyle(color: Colors.black54, fontSize: 16),
            textAlign: TextAlign.center,
          ),
          Text(
            aya.enTran!,
            style: TextStyle(color: Colors.black54, fontSize: 14),
            textAlign: TextAlign.center,
          ),
          RichText(
            text: TextSpan(
              children: <InlineSpan>[
                WidgetSpan(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      aya.surNumber!.toString(),
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ),
                WidgetSpan(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      aya.surEnName!.toString(),
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

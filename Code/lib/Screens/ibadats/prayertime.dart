import 'package:flutter/material.dart';

import 'Hajj.dart';
import 'Namaze.dart';
import 'fasting.dart';
import 'pryer/namaz.dart';
import 'umrah.dart';
class PrayerTimesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ibadaat',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.lightGreen,
        centerTitle: true,
      ),
      body: Container(
      color: Colors.lime[50],
        child: Column(
          children: [
            // Image at the top
            Image.asset(
              'images/home1.jpg', // Replace with your image path
              width: double.infinity,
              fit: BoxFit.cover,
              height: 200,
            ),
            SizedBox(height: 15),
            Flexible(
              child: Row(
                children: [
                  Expanded(
                    child: Card(
                      color: Colors.green[200],
                      child: InkWell(
                        onTap: () {

                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => PrayerTimesScreen()),
                          );
                          print('Prayer card tapped');
                        },
                        child: Container(
                          height: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              // Text on the right
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  'Prayer',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Image.asset(
                                  'images/Namaz.png',
                                  width: 40.0,
                                  height: 40.0,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            Flexible(
              child: Row(
                children: [
                  Expanded(
                    child: Card(
                      color: Colors.lightGreen[200],
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Fasting()),
                          );
                          print('Fasting card tapped');
                        },
                        child: Container(
                          height: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  'Fasting',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Image.asset(
                                  'images/Fasting.png',
                                  width: 40.0,
                                  height: 40.0,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 18),
            Flexible(
              child: Row(
                children: [
                  Expanded(
                    child: Card(
                      color: Colors.green[200],
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HajjScreen()),
                          );
                          print('Videos card tapped');
                        },
                        child: Container(
                          height: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  'Hajj',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Image.asset(
                                  'images/Umrah.png',
                                  width: 40.0,
                                  height: 40.0,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            Flexible(
              child: Row(
                children: [
                  Expanded(
                    child: Card(
                      color: Colors.lightGreen[200],
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => UmrahScreen()),
                          );
                          print('Umrah card tapped');
                        },
                        child: Container(
                          height: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  'Ummrah',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Image.asset(
                                  'images/Umrah.png',
                                  width: 40.0,
                                  height: 40.0,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            Flexible(
              child: Row(
                children: [
                  Expanded(
                    child: Card(
                      color: Colors.green[200],
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => NamaazScreen()),
                          );

                          print('Videos card tapped');
                        },
                        child: Container(
                          height: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  'Namaz-e-Janaza',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Image.asset(
                                  'images/namjan.png',
                                  width: 40.0,
                                  height: 40.0,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ],
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
    );
  }
}






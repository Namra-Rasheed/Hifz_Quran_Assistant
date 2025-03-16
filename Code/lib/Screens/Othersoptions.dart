import 'package:flutter/material.dart';
import '../qibladirection/mainqibla.dart';
import 'Allahnames/Allahnamess.dart';
import 'Azkar/azkar_screen.dart';
import 'Videos/video_list_screen.dart';
import 'duaz/duapage.dart';
import 'exercises/Exercisepase.dart';
import 'ibadats/prayertime.dart';
import 'kalma/kalmas.dart';
import 'tasbhe/tasbi_counter.dart';
class Others extends StatefulWidget {
  @override
  State<Others> createState() => _OthersState();
}
class _OthersState extends State<Others> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'القرآن الكريم',
            style: TextStyle(color: Colors.white),

          ),
          backgroundColor: Colors.lightGreen,
          centerTitle: true,
        ),
        body: Container(
          color: Colors.green[50],
        child: Column(
          children: [
            SizedBox(height: 10),
            // Container(
            //   height: 200,
            //   decoration: BoxDecoration(
            //     image: DecorationImage(
            //       image: AssetImage('images/homescreen.jpg'),
            //       fit: BoxFit.cover,
            //     ),
            //   ),
            // ),
            SizedBox(height: 20),
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
                  Expanded(
                    child: Card(
                      color: Colors.green[100],
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
                            MaterialPageRoute(builder: (context) => HomeScreen()),
                          );
                          print('Third card tapped');
                        },
                        child: Container(
                          height: 130,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.book, color: Colors.black, size: 40), // Icon for Lesson
                                SizedBox(height: 10),
                                Text(
                                  'Lesson',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      color: Colors.green[100],
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => DuasScreen()),
                          );
                          print('Fourth card tapped');
                        },
                        child: Container(
                          height: 130,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.volunteer_activism, color: Colors.black, size: 40), // Icon for Dua
                                SizedBox(height: 10),
                                Text(
                                  'Dua',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      color: Colors.lightGreen[200],
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AzkarScreen()),
                          );
                          print('Fifth card tapped');
                        },
                        child: Container(
                          height: 130,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.sell, color: Colors.black, size: 40), // Icon for Azkar
                                SizedBox(height: 10),
                                Text(
                                  'Azkar',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
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

            Flexible(
              child: Row(
                children: [
                  Expanded(
                    child: Card(
                      color: Colors.green[100],
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => KalmasScreen()),
                          );
                          print('Sixth card tapped');
                        },
                        child: Container(
                          height: 130,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.menu_book, color: Colors.black, size: 40), // Icon for Kalma
                                SizedBox(height: 10),
                                Text(
                                  'Kalma',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      color: Colors.lightGreen[200],
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => TasbeehApp()),
                          );
                          print('Tasbih Counter card tapped');
                        },
                        child: Container(
                          height: 130,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.circle_outlined, color: Colors.black, size: 40), // Icon for Tasbih Counter
                                SizedBox(height: 10),
                                Text(
                                  'Tasbhee',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
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
                            MaterialPageRoute(builder: (context) => NamesOfAllah()),
                          );
                          print('Seventh card tapped');
                        },
                        child: Container(
                          height: 130,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'images/Allah.png', // Apne image ka sahi path yahan replace karein
                                  height: 40,
                                  width: 40,
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Allah Names',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
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
            Flexible(
              child: Row(
                children: [
                  Expanded(
                    child: Card(
                      color: Colors.green[100],
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => VideoListScreen()),
                          );
                          print('Seventh card tapped');
                        },
                        child: Container(
                          height: 130,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.video_library, color: Colors.black, size: 40), // Icon for Videos
                                SizedBox(height: 10),
                                Text(
                                  'Videos',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
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
}

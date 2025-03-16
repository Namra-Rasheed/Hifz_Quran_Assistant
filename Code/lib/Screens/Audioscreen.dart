import 'package:flutter/material.dart';

import '../services/apiServices.dart';
import '../voiceintegration/surahlist.dart';
import 'audio_player/qari_screen.dart';

class AudioScreen extends StatefulWidget {
  const AudioScreen({Key? key}) : super(key: key);

  @override
  _AudioScreenState createState() => _AudioScreenState();
}

class _AudioScreenState extends State<AudioScreen> {
  ApiServices apiServices = ApiServices();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Added
      initialIndex: 0,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.lightGreen,
            leading: Container(), // Removed arrow
            title: Text(
              'القرآن الكريم',
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center, // Correct styling
            ),
            centerTitle: true,
            bottom: TabBar(
              tabs: [
                Text(
                  'Voice Recitation',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 20),
                ),
                Text(
                  'Qaris',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 20),
                ),
                // index - 2
              ],
            ),
          ),
          body: TabBarView(
            children: [
              SurahListScreen(),
              QariListScreen(),

            ],
          ),
        ),
      ),
    );
  }
}

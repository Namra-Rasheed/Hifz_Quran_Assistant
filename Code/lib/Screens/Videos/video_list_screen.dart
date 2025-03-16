import 'package:flutter/material.dart';
import 'chewie_video_player.dart';

class VideoListScreen extends StatelessWidget {
  // List of video titles and file paths
  final List<Map<String, String>> videos = [
    {"title": "Noorani Qaida Lesson 1", "path": "assets/vedio/lesson1.mp4"},
    {"title": "Noorani Qaida Lesson 2", "path": "assets/vedio/lesson2.mp4"},
    {"title": "Noorani Qaida Lesson 3", "path": "assets/vedio/lesson3.mp4"},
    {"title": "Noorani Qaida Lesson 4", "path": "assets/vedio/lesson4.mp4"},
    {"title": "Noorani Qaida Lesson 5", "path": "assets/vedio/lesson5.mp4"},
    {"title": "Noorani Qaida Lesson 6", "path": "assets/vedio/lesson6.mp4"},
    {"title": "Noorani Qaida Lesson 7", "path": "assets/vedio/lesson7.mp4"},
    {"title": "Noorani Qaida Lesson 8", "path": "assets/vedio/lesson8.mp4"},
    {"title": "Noorani Qaida Lesson 9", "path": "assets/vedio/lesson9.mp4"},
    {"title": "Noorani Qaida Lesson 10", "path": "assets/vedio/lesson10.mp4"},
    {"title": "Noorani Qaida Lesson 11", "path": "assets/vedio/lesson11.mp4"},
    {"title": "Noorani Qaida Lesson 12", "path": "assets/vedio/lesson12.mp4"},
    {"title": "Noorani Qaida Lesson 13", "path": "assets/vedio/lesson13.mp4"},
    {"title": "Noorani Qaida Lesson 14", "path": "assets/vedio/lesson14.mp4"},
    {"title": "Noorani Qaida Lesson 15", "path": "assets/vedio/lesson15.mp4"},
    {"title": "Noorani Qaida Lesson 16", "path": "assets/vedio/lesson16.mp4"},
    {"title": "Noorani Qaida Lesson 17", "path": "assets/vedio/lesson17.mp4"},
    {"title": "Noorani Qaida Lesson 18", "path": "assets/vedio/lesson18.mp4"},
    {"title": "Noorani Qaida Lesson 19", "path": "assets/vedio/lesson19.mp4"},
    {"title": "Noorani Qaida Lesson 20", "path": "assets/vedio/lesson20.mp4"},
    {"title": "Noorani Qaida Lesson 21", "path": "assets/vedio/lesson21.mp4"},
    {"title": "Noorani Qaida Lesson 22", "path": "assets/vedio/lesson22.mp4"},
    {"title": "Noorani Qaida Lesson 23", "path": "assets/vedio/lesson23.mp4"},
    {"title": "Noorani Qaida Lesson 24", "path": "assets/vedio/lesson24.mp4"},
    {"title": "Noorani Qaida Lesson 25", "path": "assets/vedio/lesson25.mp4"},
    {"title": "Noorani Qaida Lesson 26", "path": "assets/vedio/lesson26.mp4"},
    {"title": "Noorani Qaida Lesson 27", "path": "assets/vedio/lesson27.mp4"},
    {"title": "Noorani Qaida Lesson 28", "path": "assets/vedio/lesson28.mp4"},
    {"title": "Noorani Qaida Lesson 29", "path": "assets/vedio/lesson29.mp4"},
    {"title": "Noorani Qaida Lesson 30", "path": "assets/vedio/lesson30.mp4"},
    {"title": "Noorani Qaida Lesson 31", "path": "assets/vedio/lesson31.mp4"},
    {"title": "Noorani Qaida Lesson 32", "path": "assets/vedio/lesson32.mp4"},
    {"title": "Noorani Qaida Lesson 33", "path": "assets/vedio/lesson33.mp4"},
    {"title": "Noorani Qaida Lesson 34", "path": "assets/vedio/lesson34.mp4"},
    {"title": "Noorani Qaida Lesson 35", "path": "assets/vedio/lesson35.mp4"},
    {"title": "Noorani Qaida Lesson 36", "path": "assets/vedio/lesson36.mp4"},
    {"title": "Noorani Qaida Lesson 37", "path": "assets/vedio/lesson37.mp4"},

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Noorani Qaida for kids",style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.lightGreen,
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: videos.length,
        itemBuilder: (context, index) {
          final video = videos[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(
                video['title']!,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: Icon(Icons.play_circle_fill, color: Colors.green, size: 40),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChewieVideoPlayerScreen(videoPath: video['path']!),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

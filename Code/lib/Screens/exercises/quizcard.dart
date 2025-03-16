import 'package:flutter/material.dart';
import 'quizpage.dart';

class QuizCard extends StatelessWidget {
  // Add your quiz card logic and UI here
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quizzes',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.lightGreen,
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: 30, // Number of lessons or quizzes
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(10),
            elevation: 5,
            child: ListTile(
              title: Text(
                'Lesson ${index + 1}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.lightGreen,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuizPage(quizId: index + 1),
                  ),
                );// Add your navigation logic for each specific quiz here
              },
            ),
          );
        },
      ),
    );
  }
}
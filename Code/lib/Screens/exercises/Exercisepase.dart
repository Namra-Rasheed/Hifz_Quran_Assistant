import 'package:flutter/material.dart';
import 'quizcard.dart'; // Import the new file with the quiz logic

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz App',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.lightGreen,
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: EdgeInsets.all(20),
          elevation: 5,
          child: ListTile(
            title: Text(
              'All Quizzes',
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
                  builder: (context) => QuizCard(), // Navigate to the QuizCard page
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
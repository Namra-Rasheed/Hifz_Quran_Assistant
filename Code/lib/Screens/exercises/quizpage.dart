import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class QuizPage extends StatefulWidget {
  final int quizId;
  QuizPage({required this.quizId});

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<dynamic> questions = [];
  Map<int, int> selectedOptions = {}; // Track selected options
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchQuestions();
  }

  Future<void> fetchQuestions() async {
    try {
      final response = await http.get(Uri.parse(
          'http://192.168.100.59/quiz_app/fetch_questions.php?quiz_id=${widget.quizId}'));
      if (response.statusCode == 200) {
        setState(() {
          questions = json.decode(response.body);
          isLoading = false;
        });
      } else {
        print("Failed to load questions: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching questions: $e");
    }
  }

  void selectOption(int questionIndex, int optionIndex) {
    setState(() {
      selectedOptions[questionIndex] = optionIndex;
    });
  }

  void submitQuiz() async {
    final submission = {
      "responses": questions.map((question) {
        final questionIndex = questions.indexOf(question);
        return {
          "question_id": question["id"],
          "selected_option": selectedOptions[questionIndex] ?? -1
        };
      }).toList(),
      "user_id": 1,
    };

    try {
      final response = await http.post(
        Uri.parse('http://192.168.100.59/quiz_app/submit_answers.php'),
        headers: {"Content-Type": "application/json"},
        body: json.encode(submission),
      );

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        if (result['status'] == 'success') {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text("Quiz Submitted"),
              content: Text("Your quiz has been successfully submitted.\nScore: ${result['score']}"),
              actions: [
                TextButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        } else {
          print("Failed to submit quiz: ${result['message']}");
        }
      } else {
        print("Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Error submitting quiz: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Quiz ${widget.quizId}"),
          backgroundColor: Colors.lightGreen,
        ),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz ${widget.quizId}"),
        backgroundColor: Colors.lightGreen,
      ),
      body: ListView.builder(
        itemCount: questions.length,
        itemBuilder: (context, index) {
          final question = questions[index];
          return Card(
            margin: EdgeInsets.all(10),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end, // Align content to the right
                children: [
                  Text(
                    question['question_text'], // Display question text in Urdu
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.right, // Align the question text to the right
                  ),
                  SizedBox(height: 10),
                  for (int i = 1; i <= 4; i++) // Display 4 options
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end, // Align radio button and text to the right
                      children: [
                        Text(
                          question['option$i'], // Display option text in Urdu
                          textAlign: TextAlign.right, // Align the options text to the right
                        ),
                        Radio<int>(
                          value: i,
                          groupValue: selectedOptions[index],
                          onChanged: (value) {
                            selectOption(index, value!);
                          },
                        ),
                      ],
                    ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightGreen,
        child: Icon(Icons.check),
        onPressed: submitQuiz, // Submit quiz
      ),
    );
  }
}
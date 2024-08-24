// quiz_taking_page.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'quiz_storage.dart';  // Import quizStorage

class QuizTakingPage extends StatefulWidget {
  final String quizCode;

  QuizTakingPage({required this.quizCode});

  @override
  _QuizTakingPageState createState() => _QuizTakingPageState();
}

class _QuizTakingPageState extends State<QuizTakingPage> {
  late Quiz _quiz;
  final Map<int, String> _answers = {};

  @override
  void initState() {
    super.initState();
    _quiz = quizStorage[widget.quizCode]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(
          'Take Quiz',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Quiz Code: ${widget.quizCode}',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _quiz.questions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_quiz.questions[index]),
                    subtitle: TextField(
                      decoration: InputDecoration(
                        labelText: 'Your Answer',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        _answers[index] = value;
                      },
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle quiz submission
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Quiz submitted!'),
                  ),
                );
              },
              child: Text('Submit Answers'),
            ),
          ],
        ),
      ),
    );
  }
}

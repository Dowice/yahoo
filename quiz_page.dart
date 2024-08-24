import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'models.dart';  // Import the models file

class QuizPage extends StatefulWidget {
  final String quizCode;

  QuizPage({required this.quizCode});

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  String _message = '';
  List<QuizQuestion> _questions = [];
  int _currentQuestionIndex = 0;
  bool _quizLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadQuiz();
  }

  void _loadQuiz() {
    final quiz = quizStorage[widget.quizCode];
    if (quiz != null) {
      setState(() {
        _questions = quiz.questions;
        _quizLoaded = true;
      });
    } else {
      setState(() {
        _message = 'Invalid quiz code. No quiz found.';
      });
    }
  }

  void _submitAnswer(int selectedIndex) {
    final currentQuestion = _questions[_currentQuestionIndex];
    if (selectedIndex == currentQuestion.correctOptionIndex) {
      setState(() {
        _message = 'Correct!';
      });
    } else {
      setState(() {
        _message = 'Wrong answer. Try again!';
      });
    }

    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
    } else {
      setState(() {
        _message = 'Quiz Completed!';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(
          'Quiz',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: Icon(
          Icons.quiz_outlined,
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: _quizLoaded
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    _questions[_currentQuestionIndex].question,
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  ..._questions[_currentQuestionIndex]
                      .options
                      .asMap()
                      .entries
                      .map(
                        (entry) => ElevatedButton(
                          onPressed: () => _submitAnswer(entry.key),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                            padding: EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 24.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: Text(
                            entry.value,
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  SizedBox(height: 24.0),
                  if (_message.isNotEmpty)
                    Text(
                      _message,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                ],
              )
            : Center(
                child: Text(
                  'Loading quiz...',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
      ),
    );
  }
}

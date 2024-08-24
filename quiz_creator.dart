import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'quiz_code_page.dart';  // Import QuizCodePage
import 'quiz_storage.dart';  // Import quizStorage and Quiz

class QuizCreatorPage extends StatefulWidget {
  @override
  _QuizCreatorPageState createState() => _QuizCreatorPageState();
}

class _QuizCreatorPageState extends State<QuizCreatorPage> {
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _quizCodeController = TextEditingController();
  final List<String> _questions = [];

  void _addQuestion() {
    if (_questionController.text.isNotEmpty) {
      setState(() {
        _questions.add(_questionController.text);
        _questionController.clear();
      });
    }
  }

  void _createQuiz() {
    final quizCode = _quizCodeController.text;
    if (quizCode.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a quiz code.')),
      );
    } else {
      // Save quiz to storage
      quizStorage[quizCode] = Quiz(code: quizCode, questions: _questions);

      // Navigate to QuizCodePage
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => QuizCodePage(quizCode: quizCode),
        ),
      );
    }
  }

  @override
  void dispose() {
    _questionController.dispose();
    _quizCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create Quiz',
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _questionController,
              decoration: InputDecoration(
                labelText: 'Enter Question',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addQuestion,
              child: Text('Add Question'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _quizCodeController,
              decoration: InputDecoration(
                labelText: 'Quiz Code',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _createQuiz,
              child: Text('Create Quiz'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _questions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_questions[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

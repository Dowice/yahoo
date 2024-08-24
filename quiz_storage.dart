class Quiz {
  final String code;
  final List<String> questions;

  Quiz({required this.code, required this.questions});
}

// In-memory storage for quizzes
final Map<String, Quiz> quizStorage = {};

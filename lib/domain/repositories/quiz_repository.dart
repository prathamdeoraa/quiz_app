/*
      Repository Interface in domain/repositories defines operations such as:
      Future<List<Question>> getQuestions(String quizId).
*/

import 'package:quiz_app/domain/entities/question.dart';

abstract class QuizRepository {
  Future<List<Questions>> getQuestions(String category);
}

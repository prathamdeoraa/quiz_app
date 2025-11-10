import 'package:quiz_app/domain/entities/question.dart';
import 'package:quiz_app/domain/repositories/quiz_repository.dart';

class GetQuestions {
  final QuizRepository repository;

  GetQuestions(this.repository);

  Future<List<Questions>> call(String tag) async {
    return await repository.getQuestions(tag);
  }
}

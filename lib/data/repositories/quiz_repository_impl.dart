import 'package:quiz_app/data/datasource/quiz_remote_datasource.dart';
import 'package:quiz_app/domain/entities/question.dart';
import 'package:quiz_app/domain/repositories/quiz_repository.dart';

class QuizRepositoryImpl implements QuizRepository {
  final QuizRemoteDatasource remote;

  QuizRepositoryImpl({
    required this.remote
  });

  @override
  Future<List<Questions>> getQuestions(String tag) async {
    final models = await remote.fetchQuestion(tag);
    return models.map((m)=>m.toEntity()).toList();
  }
}
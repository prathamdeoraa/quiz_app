/*
    Repository Implementation in data/repositories uses
    RemoteDataSource/LocalDataSource.
*/

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quiz_app/data/models/question_models.dart';

class QuizRemoteDatasource {
  final http.Client client;
  final String apiKey = 'cc2bnRNuf3r7YwQKqzwaR7s0ncBaqMvmFr6PHUZk';

  QuizRemoteDatasource({required this.client});

  Future<List<QuestionModel>> fetchQuestion(
    String? tag, {
    int limit = 10,
  }) async {
    final uri = Uri.https('quizapi.io', '/api/v1/questions', {
      'apiKey': apiKey,
      // 'limit': limit.toString(),
      if (tag != null) 'category': tag,
    });

    final res = await client.get(uri);

    print('Fetching: https://quizapi.io/api/v1/questions?tags=$tag');
    print(res.statusCode);

    if (res.statusCode == 200) {
      final List jsonList = json.decode(res.body) as List;
      return jsonList.map((e) => QuestionModel.fromJson(e)).toList();
    }
    throw Exception('Failed to Load');
  }
}

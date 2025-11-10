import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:quiz_app/data/datasource/quiz_remote_datasource.dart';
import 'package:quiz_app/data/repositories/quiz_repository_impl.dart';
import 'package:quiz_app/domain/usecases/get_questions.dart';
import 'package:quiz_app/presentation/viewmodels/quiz_state.dart';
import 'package:quiz_app/presentation/viewmodels/quiz_viewmodel.dart';

// Step 1: Provide http.Client
final httpClientProvider = Provider((ref) => http.Client());

// Step 2: Provide your QuizRemoteDataSource
final quizRemoteProvider = Provider(
  (ref) => QuizRemoteDatasource(client: ref.watch(httpClientProvider)),
);

// quizRepositoryProvider
final quizRepositoryProvider = Provider<QuizRepositoryImpl>((ref) {
  return QuizRepositoryImpl(remote: ref.watch(quizRemoteProvider));
});

// getQuestionsProvider
final getQuestionProvider = Provider<GetQuestions>((ref) {
  return GetQuestions(ref.watch(quizRepositoryProvider));
});

// quizViewModelProvider
final quizViewModelProvider =
    StateNotifierProvider.family<QuizViewModel, QuizState, String>((
      ref,
      category,
    ) {
      final getQuestions = ref.watch(getQuestionProvider);
      return QuizViewModel(getQuestions: getQuestions)..loadQuiz(category);
    });

/*

UI (QuizPage)
   ↓
QuizViewModel ← quizViewModelProvider
   ↓
GetQuestions ← getQuestionsProvider
   ↓
QuizRepositoryImpl ← quizRepositoryProvider
   ↓
QuizRemoteDataSource ← quizRemoteProvider
   ↓
http.Client ← httpClientProvider
   ↓
QuizAPI.io HTTP Request ✅

*/

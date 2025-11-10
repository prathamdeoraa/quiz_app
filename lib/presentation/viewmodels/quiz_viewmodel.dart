import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_app/presentation/viewmodels/quiz_state.dart';
import '../../domain/usecases/get_questions.dart';
import '../../domain/entities/question.dart';

class QuizViewModel extends StateNotifier<QuizState> {
  final GetQuestions getQuestions;

  String? _lastCategory;
  int? selectedIndex; // currently selected option index

  QuizViewModel({required this.getQuestions})
    : super(const QuizState.initial());

  /// 🔹 Fetch quiz data from API
  Future<void> loadQuiz(String tag) async {
    _lastCategory = tag;
    selectedIndex = null;
    state = const QuizState.loading();

    try {
      final List<Questions> questions = await getQuestions(tag);
      state = QuizState.loaded(questions: questions, score: 0, currentIndex: 0);
    } catch (e) {
      state = QuizState.error(e.toString());
    }
  }

  /// 🔹 Store selected option when user taps a radio button
  void selectOption(int index) {
    selectedIndex = index;

    // Re-emit same state to trigger UI rebuild
    state.maybeWhen(
      loaded: (questions, score, currentIndex) {
        state = QuizState.loaded(
          questions: questions,
          score: score,
          currentIndex: currentIndex,
        );
      },
      orElse: () {},
    );
  }

  /// 🔹 Submit selected answer and move to next question
  void submitAns() {
    state.maybeWhen(
      loaded: (questions, score, currentIndex) {
        if (currentIndex >= questions.length) return;
        if (selectedIndex == null) return; // no option selected

        final q = questions[currentIndex];
        final bool isCorrect = selectedIndex == q.correctIndex;
        final int newScore = isCorrect ? score + 1 : score;
        final int nextIndex = currentIndex + 1;

        // Reset selection for next question
        selectedIndex = null;

        // Move to next question or finish
        state = QuizState.loaded(
          questions: questions,
          score: newScore,
          currentIndex: nextIndex,
        );
      },
      orElse: () {},
    );
  }

  /// 🔹 Restart current quiz
  void restartSameQuiz() {
    // ✅ Simply resets score and current index
    state.maybeWhen(
      loaded: (questions, score, currentIndex) {
        selectedIndex = null;
        state = QuizState.loaded(
          questions: questions,
          score: 0,
          currentIndex: 0,
        );
      },
      orElse: () {},
    );
  }

  void restartNewQuiz() {
    // 🔁 Reloads quiz from API (same category)
    selectedIndex = null;
    if (_lastCategory != null) {
      loadQuiz(_lastCategory!);
    } else {
      state = const QuizState.initial();
    }
  }
}

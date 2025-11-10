import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quiz_app/domain/entities/question.dart';

part 'quiz_state.freezed.dart';

@freezed
class QuizState with _$QuizState {
  const factory QuizState.initial() = _Initial;
  const factory QuizState.loading() = _Loading;
  const factory QuizState.loaded({
    required List<Questions> questions,
    required int score,
    required int currentIndex,
  }) = _Loaded;
  const factory QuizState.error(String message) = _Error;
}

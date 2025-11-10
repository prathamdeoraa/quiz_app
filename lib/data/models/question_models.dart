import 'package:quiz_app/domain/entities/question.dart';

class QuestionModel {
  final int id;
  final String question;
  final String? description;
  final Map<String, String?> answers;
  final Map<String, String?> correctAnswers;
  final List<Map>? tags;
  final String difficulty;

  QuestionModel({
    required this.id,
    required this.question,
    this.description,
    required this.answers,
    required this.correctAnswers,
    this.tags,
    required this.difficulty,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    final rawAnswers = Map<String, String?>.from(json['answers']);
    final filteredAnswers = rawAnswers
      ..removeWhere((key, value) => value == null);

    return QuestionModel(
      id: json['id'],
      question: json['question'] ?? '',
      description: json['description'] ?? '',
      answers: filteredAnswers,
      correctAnswers: Map<String, String?>.from(json['correct_answers']),
      tags: json['tags'] != null ? List<Map>.from(json['tags']) : [],
      difficulty: json['difficulty'] ?? 'Easy',
    );
  }

  Questions toEntity() {
    // Collect all non-null answer options
    final options = answers.values.whereType<String>().toList();

    // Find the correct answer key (like 'answer_a_correct')
    final correctEntry = correctAnswers.entries.firstWhere(
      (e) => e.value == 'true',
      orElse: () => const MapEntry('none', 'false'),
    );

    int correctIndex = 0;

    if (correctEntry.key != 'none') {
      final keyLetter = correctEntry.key.replaceAll(
        RegExp(r'answer_|_correct'),
        '',
      ); // e.g., 'a'
      final correctKey = 'answer_$keyLetter'; // e.g., 'answer_a'
      correctIndex = answers.keys.toList().indexOf(correctKey);
    }

    return Questions(
      id: id.toString(),
      question: question,
      options: options,
      correctIndex: correctIndex,
    );
  }
}

// Entities: Question, Quiz, Answer live in domain/entities and are pure Dart classes with no serialization concerns.

class Questions {
  final String id;
  final String question;
  final List<String> options;
  final int correctIndex;

  Questions({
    required this.id,
    required this.question,
    required this.options,
    required this.correctIndex,
  });
}

class Question {
  final String id;
  final String title;
  final String content;
  final List<String> categoryIds;
  final String authorId;
  final DateTime timestamp;
  final List<String> answerIds;

  Question({
    required this.id,
    required this.title,
    required this.content,
    required this.categoryIds,
    required this.authorId,
    required this.timestamp,
    required this.answerIds,
  });
}

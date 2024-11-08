class Answer {
  final String id;
  final String content;
  final String questionId;
  final String? parentCode;  // Nullable to indicate it might not be a reply
  final String authorId;
  final DateTime timestamp;

  Answer({
    required this.id,
    required this.content,
    required this.questionId,
    this.parentCode,
    required this.authorId,
    required this.timestamp,
  });
}

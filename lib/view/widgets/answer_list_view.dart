import 'package:flutter/material.dart';
import '../../models/answer.dart';

class AnswerListView extends StatelessWidget {
  final List<Answer> answers;
  final String questionId;

  const AnswerListView({
    super.key,
    required this.answers,
    required this.questionId,
  });

  @override
  Widget build(BuildContext context) {
    // Filter answers for the specific question and sort them by timestamp
    final filteredAnswers = answers
        .where((answer) => answer.questionId == questionId)
        .toList()
      ..sort((a, b) => a.timestamp.compareTo(b.timestamp));

    return ListView.builder(
      itemCount: filteredAnswers.length,
      itemBuilder: (context, index) {
        final answer = filteredAnswers[index];
        return _buildAnswerTile(answer);
      },
    );
  }
  String formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays >= 365) {
      final years = (difference.inDays / 365).floor();
      return years == 1 ? '1 year ago' : '$years years ago';
    } else if (difference.inDays >= 30) {
      final months = (difference.inDays / 30).floor();
      return months == 1 ? '1 month ago' : '$months months ago';
    } else if (difference.inDays >= 7) {
      final weeks = (difference.inDays / 7).floor();
      return weeks == 1 ? '1 week ago' : '$weeks weeks ago';
    } else if (difference.inDays >= 1) {
      return difference.inDays == 1 ? 'Yesterday' : '${difference.inDays} days ago';
    } else if (difference.inHours >= 1) {
      return '${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}';
    } else if (difference.inMinutes >= 1) {
      return difference.inMinutes == 1 ? '1 minute ago' : '${difference.inMinutes} minutes ago';
    } else {
      return 'Just now';
    }
  }

  Widget _buildAnswerTile(Answer answer) {
    final timeString = formatTimestamp(answer.timestamp);

    return ListTile(
      title: Text(answer.content),
      subtitle: Text('Reply to: ${answer.parentCode ?? "Original Post"}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.reply),
          ),
          const SizedBox(width: 4),
          Text(
            timeString,
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

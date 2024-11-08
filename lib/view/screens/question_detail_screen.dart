import 'package:flutter/material.dart';
import 'package:project_qa/models/answer.dart';
import 'package:project_qa/view/widgets/answer_list_view.dart';
import 'package:provider/provider.dart';
import 'package:project_qa/viewmodels/answer_viewmodel.dart';
import 'package:project_qa/models/question.dart';

class QuestionDetailScreen extends StatelessWidget {
  final Question question;

  const QuestionDetailScreen({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    final answerViewModel = Provider.of<AnswerViewModel>(context);

    onAddAnswer(String text) {
      // Add answer logic here (create a new Answer and add it to the viewmodel)
      final newAnswer = Answer(
        id: DateTime.now().toString(),
        content: text,
        questionId: question.id,
        parentCode: null,
        // Set to a specific answer's ID if this is a reply
        authorId: 'user1',
        // Example user ID
        timestamp: DateTime.now(),
      );
      answerViewModel.addAnswer(newAnswer);
    }

    return Scaffold(
      appBar: AppBar(title: Text(question.title)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(question.content, style: const TextStyle(fontSize: 18)),
          ),
          Expanded(
            child: AnswerListView(
              answers: answerViewModel.answers,
              questionId: question.id,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(hintText: 'Add your answer...'),
              onSubmitted: (text) => onAddAnswer(text),
            ),
          ),
        ],
      ),
    );
  }
}

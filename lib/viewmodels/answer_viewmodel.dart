import 'package:flutter/material.dart';
import 'package:project_qa/extensions/duration_extension.dart';
import 'package:project_qa/models/answer.dart';

class AnswerViewModel extends ChangeNotifier {
  List<Answer> _answers = [];

  List<Answer> get answers => _answers;

  void fetchAnswers() {
    // Mock data to simulate fetching answers
    _answers = [
      Answer(
        id: 'answer1',
        content: 'Flutter is a UI toolkit for building natively compiled applications.',
        questionId: '1',
        parentCode: null,
        authorId: 'user1',
        timestamp: DateTime.now().subtract(2.h),
      ),
      Answer(
        id: 'answer2',
        content: 'You can use Dart programming language with Flutter.',
        questionId: '1',
        parentCode: 'answer1',
        authorId: 'user2',
        timestamp: DateTime.now().subtract(1.h),
      ),
    ];
    notifyListeners();
  }

  void addAnswer(Answer answer) {
    _answers.add(answer);
    notifyListeners();
  }
}

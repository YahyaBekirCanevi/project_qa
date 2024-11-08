import 'package:flutter/material.dart';
import 'package:project_qa/extensions/duration_extension.dart';
import 'package:project_qa/models/question.dart';

class QuestionViewModel extends ChangeNotifier {
  List<Question> _questions = [];

  List<Question> get questions => _questions;

  void fetchQuestions() {
    // Simulate fetching questions from a backend
    _questions = [
      Question(
        id: '1',
        title: 'What is Flutter?',
        content: 'Can someone explain the basics of Flutter?',
        categoryIds: ['tech', 'flutter'],
        authorId: 'user1',
        timestamp: DateTime.now().subtract(5.h),
        answerIds: ['answer1', 'answer2'],
      ),
    ];
    notifyListeners();
  }

  void addQuestion(Question question) {
    _questions.add(question);
    notifyListeners();
  }
}
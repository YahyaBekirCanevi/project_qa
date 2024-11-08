import 'package:flutter/material.dart';
import 'package:project_qa/models/question.dart';
import 'package:project_qa/models/category.dart';
import 'package:project_qa/view/screens/question_detail_screen.dart';
import 'package:provider/provider.dart';
import 'package:project_qa/viewmodels/category_viewmodel.dart';

class QuestionListView extends StatelessWidget {
  final List<Question> questions;

  const QuestionListView({super.key, required this.questions});

  @override
  Widget build(BuildContext context) {
    final categoryViewModel = Provider.of<CategoryViewModel>(context);

    List<Question> getQuestions() {
      if (categoryViewModel.currentCategory == categoryViewModel.allCategory) {
        return questions;
      }
      return questions
          .where((question) => question.categoryIds
              .contains(categoryViewModel.currentCategory!.id))
          .toList();
    }

    return ListView.builder(
      itemCount: getQuestions().length,
      itemBuilder: (context, index) {
        final question = getQuestions()[index];
        final categories = question.categoryIds
            .map((id) => categoryViewModel.getCategoryById(id))
            .whereType<Category>()
            .toList();

        return ListTile(
          title: Text(question.title),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(question.content),
              const SizedBox(height: 8),
              Wrap(
                spacing: 4.0,
                children: categories.map((category) {
                  return DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text(category.name),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => QuestionDetailScreen(question: question),
              ),
            );
          },
        );
      },
    );
  }
}

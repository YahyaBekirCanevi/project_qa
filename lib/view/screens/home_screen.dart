import 'package:flutter/material.dart';
import 'package:project_qa/view/widgets/filter_section.dart';
import 'package:project_qa/view/widgets/question_list_view.dart';
import 'package:project_qa/viewmodels/question_viewmodel.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forum Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.category),
            onPressed: () {
              Navigator.pushNamed(context, '/categories');
            },
          ),
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter Section
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: FilterSection(),
          ),
          Expanded(
            child: Consumer<QuestionViewModel>(
              builder: (_, vm, __) => QuestionListView(questions: vm.questions),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/postQuestion');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

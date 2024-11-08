import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project_qa/view/screens/home_screen.dart';
import 'package:project_qa/view/screens/category_screen.dart';
import 'package:project_qa/view/screens/profile_screen.dart';
import 'package:project_qa/view/screens/post_question_screen.dart';
import 'package:project_qa/viewmodels/question_viewmodel.dart';
import 'package:project_qa/viewmodels/answer_viewmodel.dart';
import 'package:project_qa/viewmodels/category_viewmodel.dart';
import 'package:project_qa/viewmodels/user_viewmodel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => QuestionViewModel()..fetchQuestions()),
        ChangeNotifierProvider(create: (_) => AnswerViewModel()..fetchAnswers()),
        ChangeNotifierProvider(create: (_) => CategoryViewModel()..fetchCategories()),
        ChangeNotifierProvider(create: (_) => UserViewModel()..fetchUser()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Forum App',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const HomeScreen(),
        routes: {
          '/categories': (_) => const CategoryScreen(),
          '/profile': (_) => const ProfileScreen(),
          '/postQuestion': (_) => const PostQuestionScreen(),
        },
      ),
    );
  }
}

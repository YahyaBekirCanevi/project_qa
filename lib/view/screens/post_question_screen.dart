import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:project_qa/models/category.dart';
import 'package:project_qa/viewmodels/category_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:project_qa/models/question.dart';
import 'package:project_qa/viewmodels/question_viewmodel.dart';

class PostQuestionScreen extends HookWidget {
  const PostQuestionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CategoryViewModel>(context);

    final titleController = useTextEditingController();
    final contentController = useTextEditingController();
    final categoryController = useTextEditingController();

    final selectedCategories = useState(List<Category>.empty());
    final categorySuggestions = useState(List<Category>.empty());

    void onCategoryInputChanged() {
      final input = categoryController.text.trim();
      if (input.isNotEmpty) {
        categorySuggestions.value =
            Provider.of<CategoryViewModel>(context, listen: false)
                .categories
                .where((category) =>
                    category.name.toLowerCase().contains(input.toLowerCase()))
                .toList();
      } else {
        categorySuggestions.value = [];
      }
    }

    useEffect(() {
      categoryController.addListener(onCategoryInputChanged);
      return () {};
    }, []);

    void addCategory(Category category) {
      if (!selectedCategories.value.contains(category)) {
        selectedCategories.value = [category, ...selectedCategories.value];
      }
      categoryController.clear();
      categorySuggestions.value = [];
    }

    void submitQuestion() {
      if (titleController.text.isNotEmpty &&
          contentController.text.isNotEmpty &&
          selectedCategories.value.isNotEmpty) {
        final question = Question(
          id: DateTime.now().toString(),
          title: titleController.text,
          content: contentController.text,
          categoryIds:
              selectedCategories.value.map((category) => category.id).toList(),
          authorId: 'user1',
          timestamp: DateTime.now(),
          answerIds: [],
        );
        Provider.of<QuestionViewModel>(context, listen: false)
            .addQuestion(question);
        Navigator.pop(context); // Navigate back to HomeScreen after submission
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Post a Question')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: contentController,
              decoration: const InputDecoration(labelText: 'Content'),
              maxLines: 4,
            ),
            const SizedBox(height: 20),
            // Category input field
            TextField(
              controller: categoryController,
              decoration: const InputDecoration(labelText: 'Add a Category'),
            ),
            const SizedBox(height: 10),
            // Display suggestions
            if (categorySuggestions.value.isNotEmpty)
              ...categorySuggestions.value.map((category) {
                return ListTile(
                  title: Text(category.name),
                  onTap: () => addCategory(category),
                );
              }),
            if (categoryController.text.isNotEmpty &&
                categorySuggestions.value.isEmpty)
              ListTile(
                title: Text('Create "${categoryController.text}"'),
                onTap: () {
                  final newCategory = Category(
                    id: DateTime.now().toString(),
                    name: categoryController.text,
                  );
                  provider.addCategory(newCategory);
                  addCategory(newCategory);
                },
              ),
            const SizedBox(height: 10),
            // Display selected categories
            Wrap(
              spacing: 8.0,
              children: selectedCategories.value.map((category) {
                return Chip(
                  label: Text(category.name),
                  onDeleted: () {
                    final index = selectedCategories.value.indexOf(category);
                    selectedCategories.value.removeAt(index);
                    selectedCategories.value = [...selectedCategories.value];
                  },
                );
              }).toList(),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: submitQuestion,
              child: const Text('Submit Question'),
            ),
          ],
        ),
      ),
    );
  }
}

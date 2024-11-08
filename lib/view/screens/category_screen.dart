import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project_qa/viewmodels/category_viewmodel.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CategoryViewModel>(context);
    final categories = provider.categories;

    return Scaffold(
      appBar: AppBar(title: const Text('Categories')),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return ListTile(
            title: Text(category.name),
            onTap: () {
              provider.selectCategory(category);
              Navigator.of(context).pop();
            },
          );
        },
      ),
    );
  }
}

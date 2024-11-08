import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project_qa/viewmodels/category_viewmodel.dart';

class FilterSection extends StatelessWidget {
  const FilterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CategoryViewModel>(context);
    final categories = provider.categories;

    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        spacing: 8.0,
        children: categories.map((category) {
          return ChoiceChip(
            label: Text(category.name),
            selected: provider.currentCategory == category,
            onSelected: (selected) {
              provider.selectCategory(selected ? category : provider.allCategory);
            },
          );
        }).toList(),
      ),
    );
  }
}

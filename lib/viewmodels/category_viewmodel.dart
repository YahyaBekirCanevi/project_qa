import 'package:flutter/material.dart';
import '../models/category.dart';

class CategoryViewModel extends ChangeNotifier {
  final allCategory = Category(id: '', name: 'All');

  List<Category> _categories = [];
  late Category _selectedCategory = allCategory;

  List<Category> get categories => _categories;

  Category? get currentCategory => _selectedCategory;

  void fetchCategories() {
    _categories = [
      allCategory,
      Category(id: 'tech', name: 'Technology'),
      Category(id: 'flutter', name: 'Flutter'),
      Category(id: 'general', name: 'General'),
    ];
    notifyListeners();
  }

  void addCategory(Category newCategory) {
    _categories.add(newCategory);
    notifyListeners();
  }

  void selectCategory(Category category) {
    _selectedCategory = category;
    notifyListeners();
  }

  Category getCategoryById(String id) {
    return _categories.where((category) => category.id == id).first;
  }
}

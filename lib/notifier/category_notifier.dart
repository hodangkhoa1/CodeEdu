import 'dart:collection';

import 'package:code_edu/data/category.dart';
import 'package:flutter/cupertino.dart';

class CategoryNotifier with ChangeNotifier {
  List<Category> _categoryList = [];
  Category _currentCategory;

  UnmodifiableListView<Category> get categoryList => UnmodifiableListView(_categoryList);
  Category get currentCategory => _currentCategory;

  set categoryList(List<Category> categoryList) {
    _categoryList = categoryList;
    notifyListeners();
  }

  set currentCategory(Category category) {
    _currentCategory = category;
    notifyListeners();
  }
}
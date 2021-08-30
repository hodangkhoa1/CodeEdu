import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_edu/data/category.dart';
import 'package:code_edu/notifier/category_notifier.dart';

getCategory(CategoryNotifier categoryNotifier) async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('Courses').get();
  List<Category> _categoryList = [];

  snapshot.docs.forEach((document) {
    Category category = Category.fromMap(document.data());
    _categoryList.add(category);
  });

  categoryNotifier.categoryList = _categoryList;
}
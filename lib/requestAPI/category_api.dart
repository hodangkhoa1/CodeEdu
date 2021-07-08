import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_edu/data/category.dart';
import 'package:code_edu/notifier/category_notifier.dart';

getCategory(CategoryNotifier categoryNotifier) async {
  QuerySnapshot snapshot = await Firestore.instance.collection('Courses').getDocuments();

  List<Category> _categoryList = [];

  snapshot.documents.forEach((document) {
    Category category = Category.fromMap(document.data);
    _categoryList.add(category);
  });

  categoryNotifier.categoryList = _categoryList;
}
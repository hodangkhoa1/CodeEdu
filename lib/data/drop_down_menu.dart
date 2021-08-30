import 'package:code_edu/model/menu_item.dart';
import 'package:flutter/material.dart';

class MenuItems {
  static const List<MenuItem> itemsFirst = [
    itemFeedback,
    itemDelete
  ];

  static const itemFeedback = MenuItem(
    text: 'Feedback',
    icon: Icons.feedback,
    color: Colors.grey

  );

  static const itemDelete = MenuItem(
    text: 'Delete',
    icon: Icons.delete,
    color: Colors.redAccent
  );
}
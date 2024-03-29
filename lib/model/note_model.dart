import 'dart:convert';

import 'package:flutter/cupertino.dart';

class NoteModel {
  final int id;
  final String title;
  final String description;
  final DateTime createdat;
  NoteModel({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.createdat,
  });

  NoteModel copyWith({
    int id,
    String title,
    String description,
    DateTime createdat,
  }) {
    return NoteModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      createdat: createdat ?? this.createdat,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'createdat': createdat.millisecondsSinceEpoch,
    };
  }

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    
    return NoteModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      createdat: DateTime.fromMillisecondsSinceEpoch(map['createdat']),
    );
  }

  String toJson() => json.encode(toMap());

  factory NoteModel.fromJson(String source) => NoteModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'NoteModel(id: $id, title: $title, description: $description, createdat: $createdat)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is NoteModel &&
      other.id == id &&
      other.title == title &&
      other.description == description &&
      other.createdat == createdat;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      title.hashCode ^
      description.hashCode ^
      createdat.hashCode;
  }
}

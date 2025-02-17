import 'package:flutter_ca2/features/todo/domain/entities/todo.dart';

class TodoModel extends Todo {
  TodoModel({
    required super.id,
    required super.title,
    required super.isChecked,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'] as int,
      title: json['title'] as String,
      isChecked: json['is_checked'] as bool,
    );
  }

  static List<TodoModel> fromJsonList(List<Map<String, dynamic>> jsonList) {
    return jsonList.map((json) => TodoModel.fromJson(json)).toList();
  }
}

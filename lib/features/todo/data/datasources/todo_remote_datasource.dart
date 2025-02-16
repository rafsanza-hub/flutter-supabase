
import 'package:flutter_ca2/features/todo/data/models/todo_model.dart';

abstract interface class TodoRemoteDataSource {
  Future<List<TodoModel>> getTodos();
  Future<void> addTodo({required String title});
  Future<void> updateTodo({required int id, String? title, bool? isChecked});
  Future<void> deleteTodo({required int id});
}
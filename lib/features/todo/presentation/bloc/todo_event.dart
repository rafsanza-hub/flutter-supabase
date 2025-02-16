part of 'todo_bloc.dart';

sealed class TodoEvent {}

final class AddTodoEvent extends TodoEvent {
  final String title;

  AddTodoEvent({required this.title});
}

final class UpdateTodoEvent extends TodoEvent {
  final int id;
  final String? title;
  final bool? isChecked;

  UpdateTodoEvent({
    required this.id,
    required this.title,
    required this.isChecked,
  });
}

final class DeleteTodoEvent extends TodoEvent {
  final int id;

  DeleteTodoEvent({required this.id});
}

final class GetTodosEvent extends TodoEvent {}

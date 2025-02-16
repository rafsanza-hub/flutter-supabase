import 'package:flutter_ca2/core/exceptions/server_exception.dart';
import 'package:flutter_ca2/features/todo/domain/entities/todo.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class TodoRepository {
  Future<Either<ServerException, List<Todo>>> getTodos();
  Future<Either<ServerException, bool>> addTodo({
    required String title,
  });
  Future<Either<ServerException, bool>> updateTodo({
    required int id,
    String? title,
    bool? isChecked,
  });
  Future<Either<ServerException, bool>> deleteTodo({required int id});
}

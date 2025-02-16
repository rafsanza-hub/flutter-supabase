import 'package:flutter_ca2/core/exceptions/server_exception.dart';
import 'package:flutter_ca2/features/todo/domain/entities/todo.dart';
import 'package:flutter_ca2/features/todo/domain/repositories/todo_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetTodoUsecase {
  final TodoRepository _repository;

  GetTodoUsecase({required TodoRepository repository})
      : _repository = repository;

  Future<Either<ServerException, List<Todo>>> call({required String title}) async {
     return _repository.getTodos();
  }
}

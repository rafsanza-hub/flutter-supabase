import 'package:flutter_ca2/core/exceptions/server_exception.dart';
import 'package:flutter_ca2/features/todo/domain/repositories/todo_repository.dart';
import 'package:fpdart/fpdart.dart';

class AddTodoUsecase {
  final TodoRepository _repository;

  AddTodoUsecase({required TodoRepository repository})
      : _repository = repository;

  Future<Either<ServerException, bool>> call({required String title}) async {
     return _repository.addTodo(title: title);
  }
}

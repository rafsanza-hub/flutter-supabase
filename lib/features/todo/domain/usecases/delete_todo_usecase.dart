import 'package:flutter_ca2/core/exceptions/server_exception.dart';
import 'package:flutter_ca2/features/todo/domain/repositories/todo_repository.dart';
import 'package:fpdart/fpdart.dart';

class DeleteTodoUsecase {
  final TodoRepository _repository;

  DeleteTodoUsecase({required TodoRepository repository})
      : _repository = repository;

  Future<Either<ServerException, bool>> call({required int id}) async {
     return _repository.deleteTodo(id: id);
  }
}

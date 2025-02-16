import 'package:flutter_ca2/core/exceptions/server_exception.dart';
import 'package:flutter_ca2/features/todo/domain/repositories/todo_repository.dart';
import 'package:fpdart/fpdart.dart';

class UpdateTodoUsecase {
  final TodoRepository _repository;

  UpdateTodoUsecase({required TodoRepository repository})
      : _repository = repository;

  Future<Either<ServerException, bool>> call({
    required int id,
    String? title,
    bool? isChecked,
  }) async {
    return _repository.updateTodo(
        id: id, title: title, isChecked: isChecked);
  }
}

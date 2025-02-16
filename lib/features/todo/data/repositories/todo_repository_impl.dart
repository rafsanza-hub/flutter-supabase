import 'package:flutter_ca2/core/exceptions/server_exception.dart';
import 'package:flutter_ca2/features/todo/data/datasources/todo_remote_datasource.dart';
import 'package:flutter_ca2/features/todo/domain/entities/todo.dart';
import 'package:flutter_ca2/features/todo/domain/repositories/todo_repository.dart';
import 'package:fpdart/fpdart.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoRemoteDataSource _remoteDataSource;

  TodoRepositoryImpl({required TodoRemoteDataSource remoteDataSource})
      : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<ServerException, bool>> addTodo({required String title}) {
    return run(() async {
      await _remoteDataSource.addTodo(title: title);
      return right(true);
    });
  }

  @override
  Future<Either<ServerException, bool>> deleteTodo({required int id}) {
    return run(() async {
      await _remoteDataSource.deleteTodo(id: id);
      return right(true);
    });
  }

  @override
  Future<Either<ServerException, List<Todo>>> getTodos() {
    return run(() async {
      final todos = await _remoteDataSource.getTodos();
      return right(todos);
    });
  }

  @override
  Future<Either<ServerException, bool>> updateTodo(
      {required int id, String? title, bool? isChecked}) {
    return run(() async {
      await _remoteDataSource.updateTodo(
          id: id, title: title, isChecked: isChecked);
      return right(true);
    });
  }

  Future<Either<ServerException, T>> run<T>(
      Future<Either<ServerException, T>> Function() fn) async {
    try {
      return await fn();
    } on ServerException catch (e) {
      return left(e);
    }
  }
}

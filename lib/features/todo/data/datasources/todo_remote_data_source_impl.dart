import 'package:flutter_ca2/core/exceptions/server_exception.dart';
import 'package:flutter_ca2/features/todo/data/datasources/todo_remote_datasource.dart';
import 'package:flutter_ca2/features/todo/data/models/todo_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TodoRemoteDataSourceImpl implements TodoRemoteDataSource {
  final SupabaseClient _supabaseClient;

  TodoRemoteDataSourceImpl({required SupabaseClient supabaseClient})
      : _supabaseClient = supabaseClient;

  @override
  Future<List<TodoModel>> getTodos() async {
    return run(() async {
      final response = await _supabaseClient
          .from('todos')
          .select()
          .order('is_checked', ascending: true)
          .order('created_at', ascending: true);
      return TodoModel.fromJsonList(response);
    });
  }

  @override
  Future<void> addTodo({required String title}) async {
    return run(() {
      return _supabaseClient.from('todos').insert({'title': title});
    });
  }

  @override
  Future<void> updateTodo({required int id, String? title, bool? isChecked}) {
    final data = <String, dynamic>{};
    if (title != null) data['title'] = title;
    if (isChecked != null) data['is_checked'] = isChecked;
    return run(() {
      return _supabaseClient.from('todos').update(data).eq('id', id);
    });
  }

  @override
  Future<void> deleteTodo({
    required int id,
  }) async {
    return run(() {
      return _supabaseClient.from('todos').delete().eq('id', id);
    });
  }

  Future<T> run<T>(Function() fn) async {
    try {
      return await fn();
    } on PostgrestException catch (e) {
      throw ServerException(message: e.message);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}

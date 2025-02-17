// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:flutter_ca2/features/todo/domain/entities/todo.dart';

import 'package:flutter_ca2/features/todo/domain/usecases/add_todo_usecase.dart';
import 'package:flutter_ca2/features/todo/domain/usecases/delete_todo_usecase.dart';
import 'package:flutter_ca2/features/todo/domain/usecases/get_todo_usecase.dart';
import 'package:flutter_ca2/features/todo/domain/usecases/update_todo_usecase.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final AddTodoUsecase _addTodoUsecase;
  final UpdateTodoUsecase _updateTodoUsecase;
  final DeleteTodoUsecase _deleteTodoUsecase;
  final GetTodoUsecase _getTodoUsecase;
  TodoBloc({
    required AddTodoUsecase addTodoUsecase,
    required UpdateTodoUsecase updateTodoUsecase,
    required DeleteTodoUsecase deleteTodoUsecase,
    required GetTodoUsecase getTodoUsecase,
  })  : _addTodoUsecase = addTodoUsecase,
        _updateTodoUsecase = updateTodoUsecase,
        _deleteTodoUsecase = deleteTodoUsecase,
        _getTodoUsecase = getTodoUsecase,
        super(TodoInitial()) {
    on<AddTodoEvent>(_onAddTodoEvent);
    on<UpdateTodoEvent>(_onUpdateTodoEvent);
    on<GetTodosEvent>(_onGetTodosEvent);
    on<DeleteTodoEvent>(_onDeleteTodoEvent);
  }

  _onAddTodoEvent(AddTodoEvent event, Emitter<TodoState> emit) async {
    final result = await _addTodoUsecase(title: event.title);
    result.fold(
      (error) => emit(ErrorState(message: error.message)),
      (onRight) => add(GetTodosEvent()),
    );
  }

  _onUpdateTodoEvent(UpdateTodoEvent event, Emitter<TodoState> emit) async {
    final result = await _updateTodoUsecase(id: event.id, title: event.title, isChecked: event.isChecked);
    result.fold(
      (error) => emit(ErrorState(message: error.message)),
      (onRight) => add(GetTodosEvent()),
    );
  }

  _onDeleteTodoEvent(DeleteTodoEvent event, Emitter<TodoState> emit) async {
    final result = await _deleteTodoUsecase(id: event.id);
    result.fold(
      (error) => emit(ErrorState(message: error.message)),
      (onRight) => add(GetTodosEvent()),
    );
  }

  _onGetTodosEvent(GetTodosEvent event, Emitter<TodoState> emit) async {
    final result = await _getTodoUsecase();
    result.fold(
      (error) => emit(ErrorState(message: error.message)),
      (success) => emit(SuccessState(data: success)),
    );
  }
}

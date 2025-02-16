// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';

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
  }

  _onAddTodoEvent(AddTodoEvent event, Emitter<TodoState> emit) async {
    emit(LoadingState());
    final result = await _addTodoUsecase(title: event.title);
    result.fold((error) => emit(ErrorState(message: error.message)),
        (onRight) => emit(SuccessState()));
  }
}

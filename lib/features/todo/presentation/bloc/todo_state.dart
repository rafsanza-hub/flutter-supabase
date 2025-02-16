// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'todo_bloc.dart';

// State awal
class TodoInitial extends TodoState {}

// State untuk menandakan loading
class LoadingState extends TodoState {}

// State untuk menandakan success
class SuccessState extends TodoState {}

// State untuk menandakan error
class ErrorState extends TodoState {
  final String message;
  ErrorState({
    required this.message,
  });
}

// Base class untuk semua state
abstract class TodoState {
  const TodoState();
}
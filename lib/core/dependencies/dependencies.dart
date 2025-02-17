import 'package:flutter_ca2/features/todo/data/datasources/todo_remote_data_source_impl.dart';
import 'package:flutter_ca2/features/todo/data/datasources/todo_remote_datasource.dart';
import 'package:flutter_ca2/features/todo/data/repositories/todo_repository_impl.dart';
import 'package:flutter_ca2/features/todo/domain/repositories/todo_repository.dart';
import 'package:flutter_ca2/features/todo/domain/usecases/add_todo_usecase.dart';
import 'package:flutter_ca2/features/todo/domain/usecases/delete_todo_usecase.dart';
import 'package:flutter_ca2/features/todo/domain/usecases/get_todo_usecase.dart';
import 'package:flutter_ca2/features/todo/domain/usecases/update_todo_usecase.dart';
import 'package:flutter_ca2/features/todo/presentation/bloc/todo_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'dependencies_main.dart';

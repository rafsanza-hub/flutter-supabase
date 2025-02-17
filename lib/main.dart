import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ca2/core/dependencies/dependencies.dart';
import 'package:flutter_ca2/features/todo/data/datasources/todo_remote_data_source_impl.dart';
import 'package:flutter_ca2/features/todo/data/datasources/todo_remote_datasource.dart';
import 'package:flutter_ca2/features/todo/data/repositories/todo_repository_impl.dart';
import 'package:flutter_ca2/features/todo/domain/repositories/todo_repository.dart';
import 'package:flutter_ca2/features/todo/presentation/bloc/todo_bloc.dart';
import 'package:flutter_ca2/features/todo/presentation/pages/todo_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => sl<TodoBloc>(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TodoPage(),
    );
  }
}

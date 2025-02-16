part of 'dependencies.dart';

final sl = GetIt.instance;

initializeDependencies() async {
  await Supabase.initialize(
    url: 'https://tlravcdezcwdmxleviuh.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRscmF2Y2RlemN3ZG14bGV2aXVoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzk2Mzk4MjksImV4cCI6MjA1NTIxNTgyOX0.osr8w5WHGCTvwk6nel52qZt3D7XkxWDFGReTMv0JXg4',
  );

  sl.registerLazySingleton(() => Supabase.instance.client);

  _todo();
}

_todo(){
  sl..registerLazySingleton<TodoRemoteDataSource>(()=> TodoRemoteDataSourceImpl(supabaseClient: sl()))
  ..registerLazySingleton<TodoRepository>(()=> TodoRepositoryImpl(remoteDataSource: sl()))
  ..registerLazySingleton(()=> AddTodoUsecase(repository: sl()))
  ..registerLazySingleton(()=> UpdateTodoUsecase(repository: sl()))
  ..registerLazySingleton(()=> DeleteTodoUsecase(repository: sl()))
  ..registerLazySingleton(()=> GetTodoUsecase(repository: sl()));
}

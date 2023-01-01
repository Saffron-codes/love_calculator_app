import 'package:get_it/get_it.dart';
import 'package:love_calculator/data/datasources/love_info_remote_datasource.dart';
import 'package:love_calculator/data/repositories/love_info_repository_impl.dart';
import 'package:love_calculator/domain/repositories/love_info_repository.dart';
import 'package:love_calculator/domain/usecases/get_love_info.dart';
import 'package:love_calculator/presentation/bloc/love_info_bloc.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(
    () => LoveInfoBloc(
      getLoveInfo: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetLoveInfo(sl()));

  // Repository
  sl.registerLazySingleton<LoveInfoRepository>(() => LoveInfoRepositoryImpl(remoteDataSource: sl()));

  // Data sources
  sl.registerLazySingleton<LoveInfoRemoteDataSource>(() => LoveInfoRemoteDataSourceImpl(client: sl()));

  // External
  sl.registerLazySingleton(() => http.Client());
}

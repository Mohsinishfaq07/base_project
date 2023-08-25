import 'package:dio/dio.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:sb_myreports/features/authentication/login/data/data_sources/login_remote_data_source.dart';
import 'package:sb_myreports/features/authentication/login/data/repository/auth_repo_imp.dart';
import 'package:sb_myreports/features/authentication/login/domain/repository/auth_repo.dart';
import 'package:sb_myreports/features/authentication/login/domain/usecases/login_usecase.dart';
import 'package:sb_myreports/features/authentication/login/presentation/manager/auth_provider.dart';
import 'package:sb_myreports/features/google_map/data/data_sources/direction_remote_data_source.dart';
import 'package:sb_myreports/features/google_map/data/data_sources/place_remote_data_source.dart';
import 'package:sb_myreports/features/google_map/data/repositories/direction_repository.dart';
import 'package:sb_myreports/features/google_map/data/repositories/place_repository.dart';
import 'package:sb_myreports/features/google_map/domain/repositories/direction_repo_imp.dart';
import 'package:sb_myreports/features/google_map/domain/use_cases/get_query_place.dart';
import 'package:sb_myreports/features/jokes/data/data_sources/joke_remote_data_source.dart';
import 'package:sb_myreports/features/jokes/data/repositories/jokes_repo_imp.dart';
import 'package:sb_myreports/features/jokes/domain/repositories/joke_repository.dart';
import 'package:sb_myreports/features/jokes/domain/use_cases/get_query_jokes.dart';
import 'package:sb_myreports/features/jokes/domain/use_cases/get_random_joke.dart';
import 'package:sb_myreports/features/jokes/presentation/manager/jokes_provider.dart';

import 'core/router/app_state.dart';
import 'core/utils/globals/globals.dart';
import 'core/utils/network/network_info.dart';
import 'features/google_map/domain/repositories/place_repo_imp.dart';
import 'features/google_map/domain/use_cases/get_google_direction_use_case.dart';
import 'features/google_map/presentation/manager/map_provider.dart';

Future<void> init() async {
  /// UseCases
  sl.registerLazySingleton(() => LoginUsecase(sl()));
  sl.registerLazySingleton(() => GetRandomJokeUsecase(sl()));
  sl.registerLazySingleton(() => GetQueryJokesUsecase(sl()));
  sl.registerLazySingleton(() => GetQueryPlaceUsecase(sl()));
  sl.registerLazySingleton(() => GetGoogleDirectionUsecase(sl()));
  sl.registerLazySingleton(() => GetMapboxDirectionUsecase(sl()));

  //Repositories
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImp(dio: sl()));

  sl.registerLazySingleton<JokeRepository>(
    () => JokesRepoImp(remoteDataSource: sl(), networkInfo: sl()),
  );

  sl.registerLazySingleton<PlaceRepository>(
    () => PlaceRepoImp(remoteDataSource: sl(), networkInfo: sl()),
  );
  sl.registerLazySingleton<DirectionRepository>(
    () => DirectionRepoImp(remoteDataSource: sl(), networkInfo: sl()),
  );

  //Data sources
  sl.registerLazySingleton<AuthRepository>(
      () => LoginRepoImp(networkInfo: sl(), remoteDataSource: sl()));

  sl.registerLazySingleton<JokesRemoteDataSource>(
      () => JokesRemoteDataSourceImp(dio: sl()));

  sl.registerLazySingleton<PlaceRemoteDataSource>(
      () => PlaceRemoteDataSourceImp(dio: sl()));
  sl.registerLazySingleton<DirectionRemoteDataSource>(
      () => DirectionRemoteDataSourceImp(dio: sl()));

  /// Configs

  /// Repository

  /// External
  sl.registerLazySingleton<InternetConnectionChecker>(
      () => InternetConnectionChecker());

  /// Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  /// Providers
  ///
  sl.registerLazySingleton(() => AuthProvider(sl()));
  sl.registerLazySingleton(() => JokesProvider(sl(), sl()));
  sl.registerLazySingleton(() => MapProvider(sl(), sl()));
  sl.registerLazySingleton(() => Dio());

  /// Navigator
  sl.registerLazySingleton(() => AppState());
}

import 'package:five_on_4_mobile/src/features/auth/data/data_sources/auth_local/auth_local_data_source_impl.dart';
import 'package:five_on_4_mobile/src/features/auth/data/data_sources/auth_remote/auth_remote_data_source_impl.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/repositories/auth/auth_repository_impl.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/use_cases/get_auth_data_status/get_auth_data_status_use_case.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/use_cases/get_authenticated_player_model_stream/get_authenticated_player_model_stream_use_case.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/use_cases/load_authenticated_player_from_remote/load_authenticated_player_from_remote_use_case.dart';
import 'package:five_on_4_mobile/src/features/auth/presentation/controllers/auth_status/auth_status_controller.dart';
import 'package:five_on_4_mobile/src/features/matches/data/data_sources/matches_local/matches_local_data_source.dart';
import 'package:five_on_4_mobile/src/features/matches/data/data_sources/matches_local/matches_local_data_source_impl.dart';
import 'package:five_on_4_mobile/src/features/matches/data/data_sources/matches_remote/matches_remote_data_source_impl.dart';
import 'package:five_on_4_mobile/src/features/matches/data/repositories/matches/matches_repository_impl.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/create_match/create_match_use_case.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/get_match/get_match_use_case.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/get_my_today_matches/get_my_today_matches_use_case.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/load_match/load_match_use_case.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/load_my_matches/load_my_matches_use_case.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/dio/dio_wrapper.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/flutter_secure_storage/flutter_secure_storage_wrapper.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/go_router/go_router_wrapper.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/google_sign_in/google_sign_in_wrapper.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/path_provider/path_provider_wrapper.dart';
import 'package:five_on_4_mobile/src/wrappers/local/database/database_wrapper.dart';
import 'package:five_on_4_mobile/src/wrappers/local/env_vars_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

@visibleForTesting
final getIt = GetIt.instance;

abstract class GetItWrapper {
  static T get<T extends Object>({
    dynamic param1,
    dynamic param2,
    String? instanceName,
    Type? type,
  }) {
    return getIt.get<T>(
      param1: param1,
      param2: param2,
      instanceName: instanceName,
      type: type,
    );
  }

  static void registerDependencies() {
    // not all of these are needed maybe - but for now lets do all of them
    // TODO extract to specialized functions

    // wrappers

    final envVarsWrapper = EnvVarsWrapper();
    final dioWrapper = DioWrapper.createDefault();
    // final goRouterWrapper = GoRouterWrapper(
    //   authStatusController: authStatusController,
    // );
    final googleSignInWrapper =
        GoogleSignInWrapper.createDefault(envVarsWrapper: envVarsWrapper);
    const pathProviderWrapper = PathProviderWrapper();
    final flutterSecureStorageWrapper =
        FlutterSecureStorageWrapper.createDefault();
    final databaseWrapper = DatabaseWrapper.createDefault();

    // TODO maybe these dont need to be registered at all?
    // _getIt.registerSingleton<EnvVarsWrapper>(envVarsWrapper);
    // _getIt.registerSingleton<DioWrapper>(dioWrapper);
    // _getIt.registerSingleton<GoRouterWrapper>(goRouterWrapper);
    // _getIt.registerSingleton<GoogleSignInWrapper>(googleSignInWrapper);
    // _getIt.registerSingleton<PathProviderWrapper>(pathProviderWrapper);
    // _getIt.registerSingleton<FlutterSecureStorageWrapper>(
    //     flutterSecureStorageWrapper);
    // _getIt.registerSingleton<DatabaseWrapper>(databaseWrapper);

    // data sources
    final authLocalDataSource = AuthLocalDataSourceImpl(
      databaseWrapper: databaseWrapper,
    );
    final authRemoteDataSourceImpl = AuthRemoteDataSourceImpl(
      dioWrapper: dioWrapper,
      googleSignInWrapper: googleSignInWrapper,
    );

    final matchesLocalDataSource = MatchesLocalDataSourceImpl(
      databaseWrapper: databaseWrapper,
    );
    final matchesRemoteDataSource = MatchesRemoteDataSourceImpl(
      dioWrapper: dioWrapper,
    );

    // repositories
    final authRepository = AuthRepositoryImpl(
      authLocalDataSource: authLocalDataSource,
      authRemoteDataSource: authRemoteDataSourceImpl,
    );
    final matchesRepository = MatchesRepositoryImpl(
      matchesLocalDataSource: matchesLocalDataSource,
      matchesRemoteDataSource: matchesRemoteDataSource,
    );

    // use cases
    final getAuthDataStatusUseCase = GetAuthDataStatusUseCase(
      authRepository: authRepository,
    );

    final getMatchUseCase =
        GetMatchUseCase(matchesRepository: matchesRepository);
    final loadMatchesUseCase =
        LoadMatchUseCase(matchesRepository: matchesRepository);
    final createMatchUseCase =
        CreateMatchUseCase(matchesRepository: matchesRepository);
    final loadMyMatchesUseCase =
        LoadMyMatchesUseCase(matchesRepository: matchesRepository);
    final getMyTodayMatchesUseCase =
        GetMyTodayMatchesUseCase(matchesRepository: matchesRepository);
    final getAuthenticatedPlayerModelStreamUseCase =
        GetAuthenticatedPlayerModelStreamUseCase(
      authRepository: authRepository,
    );
    final loadAuthenticatedPlayerFromRemoteUseCase =
        LoadAuthenticatedPlayerFromRemoteUseCase(
      authRepository: authRepository,
    );

    // register use case singletons
    getIt.registerSingleton<GetAuthDataStatusUseCase>(getAuthDataStatusUseCase);
    getIt.registerSingleton<GetMatchUseCase>(getMatchUseCase);
    getIt.registerSingleton<LoadMatchUseCase>(loadMatchesUseCase);
    getIt.registerSingleton<CreateMatchUseCase>(createMatchUseCase);
    getIt.registerSingleton<LoadMyMatchesUseCase>(loadMyMatchesUseCase);
    getIt.registerSingleton<GetMyTodayMatchesUseCase>(getMyTodayMatchesUseCase);
    getIt.registerSingleton<GetAuthenticatedPlayerModelStreamUseCase>(
        getAuthenticatedPlayerModelStreamUseCase);
    getIt.registerSingleton<LoadAuthenticatedPlayerFromRemoteUseCase>(
        loadAuthenticatedPlayerFromRemoteUseCase);

    // register wrappers
    getIt.registerSingleton<DatabaseWrapper>(databaseWrapper);
    // _getIt.registerSingleton<GoRouterWrapper>(goRouterWrapper);
  }
}

import 'package:five_on_4_mobile/src/features/auth/data/data_sources/auth_local/auth_local_data_source_impl.dart';
import 'package:five_on_4_mobile/src/features/auth/data/data_sources/auth_remote/auth_remote_data_source_impl.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/repositories/auth/auth_repository_impl.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/use_cases/authenticate_with_google/authenticate_with_google_use_case.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/use_cases/get_auth_data_status/get_auth_data_status_use_case.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/use_cases/get_authenticated_player_model/get_authenticated_player_model_use_case.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/use_cases/get_authenticated_player_model_stream/get_authenticated_player_model_stream_use_case.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/use_cases/load_authenticated_player_from_remote/load_authenticated_player_from_remote_use_case.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/use_cases/sign_out/sign_out_use_case.dart';
import 'package:five_on_4_mobile/src/features/auth/presentation/controllers/auth_status/auth_status_controller.dart';
import 'package:five_on_4_mobile/src/features/matches/data/data_sources/matches_local/matches_local_data_source.dart';
import 'package:five_on_4_mobile/src/features/matches/data/data_sources/matches_local/matches_local_data_source_impl.dart';
import 'package:five_on_4_mobile/src/features/matches/data/data_sources/matches_remote/matches_remote_data_source_impl.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/repositories/matches/matches_repository_impl.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/create_match/create_match_use_case.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/get_match/get_match_use_case.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/get_matches/get_matches_use_case.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/get_my_past_matches/get_my_past_matches_use_case.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/get_my_today_matches/get_my_today_matches_use_case.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/get_my_upcoming_matches/get_my_upcoming_matches_use_case.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/get_player_matches_overview/get_player_matches_overview_use_case.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/load_match/load_match_use_case.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/load_my_matches/load_my_matches_use_case.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/load_player_matches_overview/load_player_matches_overview_use_case.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/load_searched_matches/load_searched_matches_use_case.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/auto_route/auto_route_wrapper.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/dio/dio_wrapper.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/flutter_secure_storage/flutter_secure_storage_wrapper.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/go_router/go_router_wrapper.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/google_sign_in/google_sign_in_wrapper.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/path_provider/path_provider_wrapper.dart';
import 'package:five_on_4_mobile/src/wrappers/local/cookies_handler/cookies_handler_wrapper.dart';
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

    // router
    final autoRouteWrapper = AutoRouteWrapper();

    // wrappers
    final envVarsWrapper = EnvVarsWrapper();
    final flutterSecureStorageWrapper =
        FlutterSecureStorageWrapper.createDefault();
    const CookiesHandlerWrapper cookiesHandlerWrapper = CookiesHandlerWrapper();

    final dioWrapper = DioWrapper.createDefault(
      flutterSecureStorageWrapper: flutterSecureStorageWrapper,
      envVarsWrapper: envVarsWrapper,
      cookiesHandlerWrapper: cookiesHandlerWrapper,
    );
    // final goRouterWrapper = GoRouterWrapper(
    //   authStatusController: authStatusController,
    // );
    final googleSignInWrapper =
        GoogleSignInWrapper.createDefault(envVarsWrapper: envVarsWrapper);
    const pathProviderWrapper = PathProviderWrapper();
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
    // final loadMyMatchesUseCase =
    //     LoadMyMatchesUseCase(matchesRepository: matchesRepository);
    // final getMyTodayMatchesUseCase =
    //     GetMyTodayMatchesUseCase(matchesRepository: matchesRepository);
    final getAuthenticatedPlayerModelStreamUseCase =
        GetAuthenticatedPlayerModelStreamUseCase(
      authRepository: authRepository,
    );
    final loadAuthenticatedPlayerFromRemoteUseCase =
        LoadAuthenticatedPlayerFromRemoteUseCase(
      authRepository: authRepository,
    );
    final authenticateWithGoogleUseCase = AuthenticateWithGoogleUseCase(
      authRepository: authRepository,
    );

    // matches
    final LoadPlayerMatchesOverviewUseCase loadPlayerMatchesOverviewUseCase =
        LoadPlayerMatchesOverviewUseCase(
      matchesRepository: matchesRepository,
    );
    final GetPlayerMatchesOverviewUseCase getPlayerMatchesOverviewUseCase =
        GetPlayerMatchesOverviewUseCase(
      matchesRepository: matchesRepository,
    );
    final SignOutUseCase signOutUseCase = SignOutUseCase(
      authRepository: authRepository,
    );
    final LoadSearchedMatchesUseCase loadSearchedMatchesUseCase =
        LoadSearchedMatchesUseCase(
      matchesRepository: matchesRepository,
    );
    final GetMatchesUseCase getMatchesUseCase = GetMatchesUseCase(
      matchesRepository: matchesRepository,
    );

    // auth
    final GetAuthenticatedPlayerModelUseCase
        getAuthenticatedPlayerModelUseCase = GetAuthenticatedPlayerModelUseCase(
      authRepository: authRepository,
    );

    // final
    // TODO FOR NOW NOT NEEDED
    // final getMyPasMatchesUseCase = GetMyPastMatchesUseCase(
    //   matchesRepository: matchesRepository,
    // );
    // final getMyUpcomingMatchesUseCase = GetMyUpcomingMatchesUseCase(
    //   matchesRepository: matchesRepository,
    // );

    // router
    getIt.registerSingleton<AutoRouteWrapper>(autoRouteWrapper);

    // register use case singletons
    // TODO maybe dont need to be registered at all - we can simply instantiate them when needed - just make sure they are stateless
    // but then we would have to expose repositories via getIt
    getIt.registerSingleton<GetAuthDataStatusUseCase>(getAuthDataStatusUseCase);
    getIt.registerSingleton<GetMatchUseCase>(getMatchUseCase);
    getIt.registerSingleton<LoadMatchUseCase>(loadMatchesUseCase);
    getIt.registerSingleton<CreateMatchUseCase>(createMatchUseCase);

    // auth
    getIt.registerSingleton<GetAuthenticatedPlayerModelUseCase>(
        getAuthenticatedPlayerModelUseCase);
    getIt.registerSingleton<GetAuthenticatedPlayerModelStreamUseCase>(
        getAuthenticatedPlayerModelStreamUseCase);
    getIt.registerSingleton<LoadAuthenticatedPlayerFromRemoteUseCase>(
        loadAuthenticatedPlayerFromRemoteUseCase);
    getIt.registerSingleton<AuthenticateWithGoogleUseCase>(
        authenticateWithGoogleUseCase);
    getIt.registerSingleton<SignOutUseCase>(signOutUseCase);

    // matches
    getIt.registerSingleton<LoadPlayerMatchesOverviewUseCase>(
        loadPlayerMatchesOverviewUseCase);
    getIt.registerSingleton<GetPlayerMatchesOverviewUseCase>(
        getPlayerMatchesOverviewUseCase);
    getIt.registerSingleton<LoadSearchedMatchesUseCase>(
        loadSearchedMatchesUseCase);
    getIt.registerSingleton<GetMatchesUseCase>(getMatchesUseCase);

    // getIt.registerSingleton<LoadMyMatchesUseCase>(loadMyMatchesUseCase);
    // getIt.registerSingleton<GetMyTodayMatchesUseCase>(getMyTodayMatchesUseCase);
    // getIt.registerSingleton<GetMyPastMatchesUseCase>(getMyPasMatchesUseCase);
    // getIt.registerSingleton<GetMyUpcomingMatchesUseCase>(
    //     getMyUpcomingMatchesUseCase);

    // register wrappers
    getIt.registerSingleton<DatabaseWrapper>(databaseWrapper);
    // _getIt.registerSingleton<GoRouterWrapper>(goRouterWrapper);
  }
}

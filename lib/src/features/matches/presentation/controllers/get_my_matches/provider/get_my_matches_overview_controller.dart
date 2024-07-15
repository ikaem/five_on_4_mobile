import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/exceptions/auth_exceptions.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/use_cases/get_authenticated_player_model/get_authenticated_player_model_use_case.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/use_cases/sign_out/sign_out_use_case.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/models/match/match_model.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/get_player_matches_overview/get_player_matches_overview_use_case.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/load_player_matches_overview/load_player_matches_overview_use_case.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/get_it/get_it_wrapper.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part "get_my_matches_overview_controller.g.dart";
part 'player_matches_overview_controller_state.dart';
part 'match_time_type.dart';

@riverpod
class GetMyMatchesOverviewController extends _$GetMyMatchesOverviewController {
  // final loadMyMatchesUseCase = GetItWrapper.get<LoadMyMatchesUseCase>();
  // final getMyTodayMatchesUseCase = GetItWrapper.get<GetMyTodayMatchesUseCase>();
  // final getMyPastMatchesUseCase = GetItWrapper.get<GetMyPastMatchesUseCase>();
  // final getMyUpcomingMatchesUseCase =
  //     GetItWrapper.get<GetMyUpcomingMatchesUseCase>();

  final LoadPlayerMatchesOverviewUseCase _loadPlayerMatchesOverviewUseCase =
      GetItWrapper.get<LoadPlayerMatchesOverviewUseCase>();
  final GetPlayerMatchesOverviewUseCase _getPlayerMatchesOverviewUseCase =
      GetItWrapper.get<GetPlayerMatchesOverviewUseCase>();
  final GetAuthenticatedPlayerModelUseCase _getAuthenticatedPlayerModelUseCase =
      GetItWrapper.get<GetAuthenticatedPlayerModelUseCase>();
  final SignOutUseCase _signOutUseCase = GetItWrapper.get<SignOutUseCase>();

  Future<void> handleDispose() async {
    ref.onDispose(() {
      // NOTE for now nothing is needed here
    });
  }

  // TODO it seems we dont need this to be AsyncValue - this works too
  // TODO but then we dont have loading and error state and so on
  // looks that for futures it is automatically async value
  // any error is handled by the build method
  @override
  Future<PlayerMatchesOverviewControllerState> build() async {
    handleDispose();

    // TODO abstract this

    try {
      final player = await _getAuthenticatedPlayerModelUseCase();
      if (player == null) {
        await _signOutUseCase();
        throw const AuthExceptionNotLoggedIn();
      }

      // TODO later, make sure to load existing data first when we come to offline functionality
      await _loadPlayerMatchesOverviewUseCase(playerId: player.playerId);
      final matchesData =
          await _getPlayerMatchesOverviewUseCase(playerId: player.playerId);

      final PlayerMatchesOverviewControllerState controllerState =
          PlayerMatchesOverviewControllerState(
        isRemoteFetchDone: true,
        todayMatches: matchesData.todayMatches,
        pastMatches: matchesData.pastMatches,
        upcomingMatches: matchesData.upcomingMatches,
      );

      return controllerState;
    } catch (e, s) {
      // TODO this part is not needed
      log(
        "Error loading updated data",
        error: e,
        stackTrace: s,
      );

      rethrow;
    }

    // state = AsyncValue.data(controllerState);

    // return AsyncValue.data(controllerState);
    // } catch (e, s) {
    //   log("Error loading updated data", error: e, stackTrace: s);
    //   return AsyncValue.error(
    //     "There was an issue loading player matches overview",
    //     s,
    //   );
    // }

    // If this method throws or returns a future that fails, the error will be caught and an [AsyncError] will be emitted. -> official docs

    // build should automatically emit loading state when await starts
    // final initialData = await _getDataFromDb(
    //   isRemoteFetchDone: false,
    // );
    // _handleLoadUpdatedData();

    // return initialData;
  }

  // TODO will need functions to manually retrieve more matches of each type - getNextBatch
  // TODO
  // Future<void> onLoadMatchesOverview({
  //   required MatchTimeType matchesType,
  // }) async {
  //   switch (matchesType) {
  //     case MatchTimeType.today:
  //       {
  //         // TODO load today maches from server into db
  //         await Future.delayed(const Duration(milliseconds: 100));
  //         // TODO retrieve from db
  //         await Future.delayed(const Duration(milliseconds: 10));
  //       }
  //     // TODO: Handle this case.
  //     case MatchTimeType.upcoming:
  //       {
  //         // TODO load upcoming maches from server into db
  //         await Future.delayed(const Duration(milliseconds: 100));
  //         // TODO retrieve from db
  //         await Future.delayed(const Duration(milliseconds: 10));
  //       }
  //     // TODO: Handle this case.
  //     case MatchTimeType.past:
  //       {
  //         // TODO load past maches from server into db
  //         await Future.delayed(const Duration(milliseconds: 100));
  //         // TODO retrieve from db
  //         await Future.delayed(const Duration(milliseconds: 10));
  //       }
  //   }
  // }

  // TODO create new function to load matches for each match time type

  // Getting data from db
  // Future<PlayerMatchesOverviewControllerState> _getDataFromDb({
  //   required bool isRemoteFetchDone,
  // }) async {
  //   // TODO dont forget to make it so that we only fetch max 5 matches at time for each type
  //   // final todayMatches = await getMyTodayMatchesUseCase();
  //   // // TODO temp only - will implement it
  //   // final pastMatches = <MatchModel>[];
  //   // final upcomingMatches = <MatchModel>[];

  //   final matchesData = await Future.wait([
  //     getMyTodayMatchesUseCase(),
  //     getMyPastMatchesUseCase(),
  //     getMyUpcomingMatchesUseCase(),
  //   ]);
  //   final todayMatches = matchesData[0];
  //   final pastMatches = matchesData[1];
  //   final upcomingMatches = matchesData[2];

  //   final stateValue = PlayerMatchesOverviewControllerState(
  //     isRemoteFetchDone: isRemoteFetchDone,
  //     todayMatches: todayMatches,
  //     pastMatches: pastMatches,
  //     upcomingMatches: upcomingMatches,
  //   );
  //   return stateValue;
  // }

  // Future<void> _handleLoadUpdatedData() async {
  //   try {
  //     // load data from server
  //     await loadMyMatchesUseCase();

  //     final updatedData = await _getDataFromDb(
  //       isRemoteFetchDone: true,
  //     );

  //     state = AsyncValue.data(updatedData);
  //   } catch (e, s) {
  //     log("Error loading updated data", error: e, stackTrace: s);
  //     state = AsyncValue.error(e, s);
  //   }
  // }
}

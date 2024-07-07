import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/use_cases/sign_out/sign_out_use_case.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/models/match/match_model.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/get_match/get_match_use_case.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/get_match/provider/get_match_use_case_provider.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/load_match/load_match_use_case.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/load_match/provider/load_match_use_case_provider.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/get_it/get_it_wrapper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "get_match_controller.g.dart";
part 'get_match_controller_state.dart';

@riverpod
class GetMatchController extends _$GetMatchController {
  // late final LoadMatchUseCase loadMatchUseCase = ref.read(
  //   loadMatchUseCaseProvider,
  // );
  // late final GetMatchUseCase getMatchUseCase = ref.read(
  //   getMatchUseCaseProvider,
  // );

  final LoadMatchUseCase loadMatchUseCase =
      GetItWrapper.get<LoadMatchUseCase>();
  final GetMatchUseCase getMatchUseCase = GetItWrapper.get<GetMatchUseCase>();
  // TODO - will need to use when we get 401 i guess
  final SignOutUseCase signOutUseCase = GetItWrapper.get<SignOutUseCase>();

  Future<void> handleDispose() async {
    ref.onDispose(() {
      // NOTE for now nothing is needed here
    });
  }

// TODO this will produce AsyncValue automatically because it is async
  @override
  Future<GetMatchControllerState> build({required int matchId}) async {
    handleDispose();

    // TODO abstract this

    // TODO loading state will be set automatically

    try {
      await loadMatchUseCase(matchId: matchId);
      final MatchModel match = await getMatchUseCase(matchId: matchId);

      final GetMatchControllerState controllerState = GetMatchControllerState(
        match: match,
        isRemoteFetchDone: true,
      );
      return controllerState;
    } catch (e, s) {
      // TODO we might have to handle 401 here - come back to this
      // if (e is AuthException) {
      // TODO also create reusable handler for this - this will be done on lot of controllers
      // not suure if it will be auth exception
      //   await signOutUseCase();
      // }

      log(
        "Error loading match with id: $matchId into db",
        error: e,
        stackTrace: s,
      );

      // TODO rethrowing so that build can handle it automatically
      rethrow;
    }
  }

// TODO ----------- old --------------
  // @override
  // Future<GetMatchControllerState> build({
  //   required int matchId,
  // }) async {
  //   _handleDispose();

  //   final initialData = await _getDataFromDb(
  //     matchId: matchId,
  //     isRemoteFetchDone: false,
  //   );
  //   _handleLoadUpdatedData(matchId: matchId);

  //   return initialData;
  // }

  // Future<void> onMatchReload() async {
  //   await _handleLoadUpdatedData(matchId: matchId);
  // }

  // Future<GetMatchControllerState> _getDataFromDb({
  //   required int matchId,
  //   required bool isRemoteFetchDone,
  // }) async {
  //   final match = await getMatchUseCase(matchId: matchId);
  //   final stateValue = GetMatchControllerState(
  //     isRemoteFetchDone: isRemoteFetchDone,
  //     match: match,
  //   );

  //   return stateValue;
  // }

  // Future<void> _handleLoadUpdatedData({
  //   required int matchId,
  // }) async {
  //   try {
  //     await loadMatchUseCase(matchId: matchId);

  //     final updatedData = await _getDataFromDb(
  //       matchId: matchId,
  //       isRemoteFetchDone: true,
  //     );

  //     state = AsyncValue.data(updatedData);
  //   } catch (e, s) {
  //     log("Error loading match with id: $matchId into db");
  //     state = AsyncValue.error(e, s);
  //   }
  // }

  // Future<void> _handleDispose() async {
  //   ref.onDispose(() {
  //     // NOTE for now nothing is needed here
  //   });
  // }
// TODO ----------- old --------------
}

import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/exceptions/auth_exceptions.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/use_cases/get_authenticated_player_model/get_authenticated_player_model_use_case.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/use_cases/sign_out/sign_out_use_case.dart';
import 'package:five_on_4_mobile/src/features/player_match_participation/domain/use_cases/join_match/join_match_use_case.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/get_it/get_it_wrapper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "join_match_controller.g.dart";
part "join_match_controller_state.dart";

@riverpod
class JoinMatchController extends _$JoinMatchController {
  final JoinMatchUseCase _joinMatchUseCase =
      GetItWrapper.get<JoinMatchUseCase>();
  final GetAuthenticatedPlayerModelUseCase _getAuthenticatedPlayerModelUseCase =
      GetItWrapper.get<GetAuthenticatedPlayerModelUseCase>();
  final SignOutUseCase _signOutUseCase = GetItWrapper.get<SignOutUseCase>();

  @override
  AsyncValue<JoinMatchControllerState?> build() {
    return const AsyncValue.data(null);
  }

  Future<void> onJoinMatch({
    required int matchId,
  }) async {
    state = const AsyncValue.loading();

    try {
      final authenticatedPlayer = await _getAuthenticatedPlayerModelUseCase();
      if (authenticatedPlayer == null) {
        throw const AuthNotLoggedInException();
      }

      final participationId = await _joinMatchUseCase(
        matchId: matchId,
        playerId: authenticatedPlayer.playerId,
      );
      state = AsyncValue.data(
        JoinMatchControllerState(participationId: participationId),
      );
    } on AuthNotLoggedInException catch (e, s) {
      log(
        "There was an auth issue when joining a match",
        error: e,
        stackTrace: s,
      );
      state = const AsyncValue.error(
        "User is not logged in",
        StackTrace.empty,
      );

      await _signOutUseCase();
    } catch (e, s) {
      log("Error joining a match -> error: $e, stackTrace: $s");
      state = const AsyncValue.error(
        "Error joining a match",
        StackTrace.empty,
      );
    }
  }
}

import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/exceptions/auth_exceptions.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/use_cases/get_authenticated_player_model/get_authenticated_player_model_use_case.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/use_cases/sign_out/sign_out_use_case.dart';
import 'package:five_on_4_mobile/src/features/player_match_participation/domain/use_cases/invite_to_match/invite_to_match_use_case.dart';
import 'package:five_on_4_mobile/src/features/player_match_participation/domain/use_cases/join_match/join_match_use_case.dart';
import 'package:five_on_4_mobile/src/features/player_match_participation/domain/use_cases/unjoin_match/unjoin_match_use_case.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/get_it/get_it_wrapper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "invite_to_match_controller.g.dart";
part "invite_to_match_controller_state.dart";

@riverpod
class InviteToMatchController extends _$InviteToMatchController {
  final InviteToMatchUseCase _inviteToMatchUseCase =
      GetItWrapper.get<InviteToMatchUseCase>();
  final SignOutUseCase _signOutUseCase = GetItWrapper.get<SignOutUseCase>();

  @override
  AsyncValue<InviteToMatchControllerState?> build() {
    return const AsyncValue.data(null);
  }

  Future<void> onInviteToMatch({
    required int matchId,
    required int playerId,
  }) async {
    state = const AsyncValue.loading();

    try {
      final participationId = await _inviteToMatchUseCase(
        matchId: matchId,
        playerId: playerId,
      );
      state = AsyncValue.data(
        InviteToMatchControllerState(participationId: participationId),
      );
    } on AuthNotLoggedInException catch (e, s) {
      // TODO not sure right now what could cause this - probably some auth issue when ping server
      log(
        "There was an auth issue when inviting player to a match",
        error: e,
        stackTrace: s,
      );
      state = const AsyncValue.error(
        "User is not logged in",
        StackTrace.empty,
      );

      await _signOutUseCase();
    } catch (e, s) {
      log("Error inviting player to a match -> error: $e, stackTrace: $s");
      state = const AsyncValue.error(
        "Error inviting player to a match",
        StackTrace.empty,
      );
    }
  }
}

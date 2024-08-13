import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/use_cases/sign_out/sign_out_use_case.dart';
import 'package:five_on_4_mobile/src/features/players/domain/models/player/player_model.dart';
import 'package:five_on_4_mobile/src/features/players/domain/use_cases/get_player/get_player_use_case.dart';
import 'package:five_on_4_mobile/src/features/players/domain/use_cases/load_player/load_player_use_case.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/get_it/get_it_wrapper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "get_player_controller_state.dart";
part "get_player_controller.g.dart";

@riverpod
class GetPlayerController extends _$GetPlayerController {
  final LoadPlayerUseCase loadPlayerUseCase =
      GetItWrapper.get<LoadPlayerUseCase>();
  final GetPlayerUseCase getPlayerUseCase =
      GetItWrapper.get<GetPlayerUseCase>();
  final SignOutUseCase signOutUseCase = GetItWrapper.get<SignOutUseCase>();

  Future<void> handleDispose() async {
    ref.onDispose(() {
      // NOTE for now nothing is needed here
    });
  }

  // because this is a future, AsyncValue (.when) will be returned automatically
  @override
  Future<GetPlayerControllerState> build({required int playerId}) async {
    // TODO abstract this

    // loading and error state will be handled autoamtically

    try {
      await loadPlayerUseCase(playerId: playerId);
      final PlayerModel player = await getPlayerUseCase(playerId: playerId);

      final GetPlayerControllerState controllerState = GetPlayerControllerState(
        player: player,
      );
      return controllerState;
    } catch (e, s) {
      // TODO we might have to handle 401 here - come back to this
      // if (e is AuthException) {
      // TODO also create reusable handler for this - this will be done on lot of controllers
      // not suure if it will be auth exception
      //   await signOutUseCase();
      // }
      //

      // TODO dont forget to handle authnotloggedin exception situation

      log(
        "There was an issue loading the player with id: $playerId",
        error: e,
        stackTrace: s,
      );

      // rethrowing so that the erro state is produced
      rethrow;
    }
  }
}

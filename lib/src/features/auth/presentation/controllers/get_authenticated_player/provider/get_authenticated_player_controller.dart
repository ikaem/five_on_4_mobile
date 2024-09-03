// TODO this needs to be tested too

import 'dart:developer';

import 'package:five_on_4_mobile/src/features/auth/domain/exceptions/auth_exceptions.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/models/authenticated_player/authenticated_player_model.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/use_cases/get_authenticated_player_model/get_authenticated_player_model_use_case.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/use_cases/sign_out/sign_out_use_case.dart';
import 'package:five_on_4_mobile/src/features/auth/presentation/controllers/get_authenticated_player/provider/get_authenticated_player_controller_state.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/get_it/get_it_wrapper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "get_authenticated_player_controller.g.dart";

// TODO not sure if state should

@riverpod
class GetAuthenticatedPlayerController
    extends _$GetAuthenticatedPlayerController {
  final _getAuthenticatedPlayerModelUseCase =
      GetItWrapper.get<GetAuthenticatedPlayerModelUseCase>();

  final _signOutUseCase = GetItWrapper.get<SignOutUseCase>();

  @override
  Future<GetAuthenticatedPlayerControllerState> build() async {
    _handleDispose();

    try {
      //

      final player = await _getAuthenticatedPlayerModelUseCase();
      if (player == null) {
        throw const AuthNotLoggedInException();
      }

      return GetAuthenticatedPlayerControllerState(
        authenticatedPlayer: player,
      );
    } on AuthNotLoggedInException catch (e, s) {
      //
      log("There is no authenticated player -> error: $e, stack: $s");

      await _signOutUseCase();

      // rethrow;
      throw Exception("No authenticated player");
      // throw const AsyncError(AuthNotLoggedInException, StackTrace.empty);
      // throw const AuthNotLoggedInException();
    } catch (e, s) {
      log("There was an error when getting authenticated player -> error: $e, stack: $s");

      rethrow;
      //
    }

    // return const AsyncValue.data(false);
  }

  // Future<AuthenticatedPlayerModel?> getAuthenticatedPlayerModel() async {
  //   state = const AsyncValue.loading();

  //   try {
  //     final authenticatedPlayer = await _getAuthenticatedPlayerModelUseCase();

  //     if (authenticatedPlayer == null) {
  //       throw const AuthNotLoggedInException();
  //     }

  //     state = const AsyncValue.data(true);

  //     return authenticatedPlayer;
  //   } on AuthNotLoggedInException catch (e, s) {
  //     log("There was an issue when getting authenticated player -> error: $e, stack: $s");
  //     state = const AsyncValue.error(
  //         "Unable to find authenticated player", StackTrace.empty);

  //     // TODO need to do this when logout is implemented
  //     // TODO what happens if there is an erro when logout - is this caugth by the following catch?
  //     // TODO not sure if this is a right flow
  //     state = const AsyncValue.data(false);

  //     await _signOutUseCase();

  //     return null;
  //   } catch (e, s) {
  //     // TODO handle error
  //     log("There was an error when getting authenticated player -> error: $e, stack: $s");

  //     // state = AsyncValue.error(e, s);
  //     // TODO empty because i dont know how
  //     state = AsyncValue.error(e, StackTrace.empty);

  //     // TODO this should probably logout player

  //     // TODO we will never reach this
  //     return null;
  //   }
  // }

  Future<void> _handleDispose() async {
    ref.onDispose(() {
      // TODO probably no cleanup will be needed here
    });
  }
}

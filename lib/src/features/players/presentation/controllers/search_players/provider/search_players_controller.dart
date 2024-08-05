import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/exceptions/auth_exceptions.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/use_cases/sign_out/sign_out_use_case.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/models/match/match_model.dart';
import 'package:five_on_4_mobile/src/features/players/domain/models/player/player_model.dart';
import 'package:five_on_4_mobile/src/features/players/domain/use_cases/get_players/get_players_use_case.dart';
import 'package:five_on_4_mobile/src/features/players/domain/use_cases/load_searched_players/load_searched_players_use_case.dart';
import 'package:five_on_4_mobile/src/features/players/domain/values/search_players_fluter_value.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/get_it/get_it_wrapper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "search_players_controller_state.dart";
part "search_players_controller.g.dart";

@riverpod
class SearchPlayersController extends _$SearchPlayersController {
  final LoadSearchedPlayersUseCase _loadSearchedPlayersUseCase =
      GetItWrapper.get<LoadSearchedPlayersUseCase>();
  final GetPlayersUseCase _getPlayersUseCase =
      GetItWrapper.get<GetPlayersUseCase>();
  final SignOutUseCase _signOutUseCase = GetItWrapper.get<SignOutUseCase>();

  Future<void> handleDispose() async {
    ref.onDispose(() {
      // NOTE for now nothing is needed here
    });
  }

  @override
  AsyncValue<SearchPlayersControllerState> build() {
    handleDispose();

    const initialState = SearchPlayersControllerState(
      foundPlayers: [],
    );
    return const AsyncValue.data(initialState);
  }

  Future<void> onSearchPlayers({
    required String nameTerm,
  }) async {
    if (nameTerm.isEmpty) {
      return;
    }

    try {
      state = const AsyncValue.loading();

      final SearchPlayersFilterValue filter = SearchPlayersFilterValue(
        name: nameTerm,
      );

      final List<int> matchIds = await _loadSearchedPlayersUseCase(
        filter: filter,
      );
      final List<PlayerModel> players = await _getPlayersUseCase(
        playerIds: matchIds,
      );

      final SearchPlayersControllerState newState =
          SearchPlayersControllerState(foundPlayers: players);

      state = AsyncValue.data(newState);
    } on AuthNotLoggedInException catch (e, s) {
      log("There was an auth issue when searching players -> error: $e, stack: $s");
      state = const AsyncValue.error("User is not logged in", StackTrace.empty);

      // TODO need to do this when logout is implemented
      // TODO what happens if there is an erro when logout - is this caugth by the following catch?
      await _signOutUseCase();
    } catch (e, s) {
      log("There was an issue getting searched players: $e, stack: $s");
      state = const AsyncValue.error(
        "There was an issue getting searched players",
        StackTrace.empty,
      );
    }
  }
}

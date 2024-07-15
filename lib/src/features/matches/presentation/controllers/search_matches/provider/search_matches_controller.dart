// TODO this will need its own state with pagination data and so on

import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/exceptions/auth_exceptions.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/use_cases/sign_out/sign_out_use_case.dart';
import 'package:five_on_4_mobile/src/features/matches/data/data_sources/matches_remote/matches_remote_data_source.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/models/match/match_model.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/get_matches/get_matches_use_case.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/load_searched_matches/load_searched_matches_use_case.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/get_it/get_it_wrapper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "search_matches_controller_state.dart";
part "search_matches_controller.g.dart";

@riverpod
class SearchMatchesController extends _$SearchMatchesController {
  final LoadSearchedMatchesUseCase _loadSearchedMatchesUseCase =
      GetItWrapper.get<LoadSearchedMatchesUseCase>();
  final GetMatchesUseCase _getMatchesUseCase =
      GetItWrapper.get<GetMatchesUseCase>();
  final SignOutUseCase _signOutUseCase = GetItWrapper.get<SignOutUseCase>();

  Future<void> handleDispose() async {
    ref.onDispose(() {
      // NOTE for now nothing is needed here
    });
  }

  // @override
  // Future<SearchMatchesControllerState> build() async {
  //   handleDispose();

  //   const initialState = SearchMatchesControllerState(
  //     foundMatches: [],
  //   );
  //   return initialState;
  // }

  @override
  AsyncValue<SearchMatchesControllerState> build() {
    handleDispose();

    const initialState = SearchMatchesControllerState(
      foundMatches: [],
    );
    return const AsyncValue.data(initialState);
  }

  Future<void> onSearchMatches({
    required String matchTitle,
  }) async {
    try {
      state = const AsyncValue.loading();

      final SearchMatchesFilterValue filter = SearchMatchesFilterValue(
        matchTitle: matchTitle,
      );

      final matchIds = await _loadSearchedMatchesUseCase(filter: filter);
      final matches = await _getMatchesUseCase(matchIds: matchIds);

      final newState = SearchMatchesControllerState(
        foundMatches: matches,
      );
      state = AsyncValue.data(newState);
    } on AuthNotLoggedInException catch (e, s) {
      log("There was an auth issue when creating match -> error: $e, stack: $s");
      state = const AsyncValue.error("User is not logged in", StackTrace.empty);

      // TODO need to do this when logout is implemented
      await _signOutUseCase();
    } catch (e, s) {
      log("There was an issue getting searched matches: $e, stack: $s");
      state = const AsyncValue.error(
        "There was an issue getting searched matches",
        StackTrace.empty,
      );
    }
  }
}

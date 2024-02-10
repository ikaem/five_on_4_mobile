import 'package:equatable/equatable.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/models/match/match_model.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/get_my_today_matches/get_my_today_matches_use_case.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/get_my_today_matches/provider/get_my_today_matches_use_case_provider.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/load_my_matches/load_my_matches_use_case.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/load_my_matches/provider/load_my_matches_use_case_provider.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/values/matches_controller_state_value.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "get_my_matches_controller.g.dart";

@riverpod
class GetMyMatchesController extends _$GetMyMatchesController {
  late final GetMyTodayMatchesUseCase getMyTodayMatchesUseCase =
      ref.read(getMyTodayMatchesUseCaseProvider);
  late final LoadMyMatchesUseCase loadMyMatchesUseCase =
      ref.read(loadMyMatchesUseCaseProvider);

  Future<void> handleDispose() async {
    ref.onDispose(() {
      // NOTE for now nothing is needed here
    });
  }

  @override
  Future<MatchesControllerStateValue> build() async {
    handleDispose();
    // If this method throws or returns a future that fails, the error will be caught and an [AsyncError] will be emitted. -> official docs

    // build should automatically emit loading state when await starts
    final initialData = await _getDataFromDb(
      isRemoteFetchDone: false,
    );
    // await Future.delayed(Duration.zero);
    _handleLoadUpdatedData();

    return initialData;
  }

  // TODO will need functions to manually retrieve more matches of each type - getNextBatch

  // Getting data from db
  Future<MatchesControllerStateValue> _getDataFromDb({
    required bool isRemoteFetchDone,
  }) async {
    // TODO dont forget to make it so that we only fetch max 5 matches at time for each type
    final todayMatches = await getMyTodayMatchesUseCase();
    // TODO temp only - will implement it
    final pastMatches = <MatchModel>[];
    final upcomingMatches = <MatchModel>[];

    final stateValue = MatchesControllerStateValue(
      isRemoteFetchDone: isRemoteFetchDone,
      todayMatches: todayMatches,
      pastMatches: pastMatches,
      upcomingMatches: upcomingMatches,
    );
    return stateValue;
  }

  Future<void> _handleLoadUpdatedData() async {
    try {
      // load data from server
      await loadMyMatchesUseCase();

      final updatedData = await _getDataFromDb(
        isRemoteFetchDone: true,
      );

      state = AsyncValue.data(updatedData);
    } catch (e, s) {
      // TODO log error
      state = AsyncValue.error(e, s);
    }
  }
}
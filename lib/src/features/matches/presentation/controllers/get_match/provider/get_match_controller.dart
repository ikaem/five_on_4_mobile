import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/models/match/match_model.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/get_match/get_match_use_case.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/get_match/provider/get_match_use_case_provider.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/load_match/load_match_use_case.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/load_match/provider/load_match_use_case_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "get_match_controller.g.dart";
part 'get_match_controller_state.dart';

@riverpod
class GetMatchController extends _$GetMatchController {
  late final LoadMatchUseCase loadMatchUseCase = ref.read(
    loadMatchUseCaseProvider,
  );
  late final GetMatchUseCase getMatchUseCase = ref.read(
    getMatchUseCaseProvider,
  );

  Future<void> handleDispose() async {
    ref.onDispose(() {
      // NOTE for now nothing is needed here
    });
  }

  @override
  Future<GetMatchControllerState> build({
    required int matchId,
  }) async {
    handleDispose();

    final initialData = await _getDataFromDb(
      matchId: matchId,
      isRemoteFetchDone: false,
    );
    _handleLoadUpdatedData(matchId: matchId);

    return initialData;
  }

  Future<GetMatchControllerState> _getDataFromDb({
    required int matchId,
    required bool isRemoteFetchDone,
  }) async {
    final match = await getMatchUseCase(matchId: matchId);
    final stateValue = GetMatchControllerState(
      isRemoteFetchDone: isRemoteFetchDone,
      match: match,
    );

    return stateValue;
  }

  void _handleLoadUpdatedData({
    required int matchId,
  }) async {
    try {
      await loadMatchUseCase(matchId: matchId);

      final updatedData = await _getDataFromDb(
        matchId: matchId,
        isRemoteFetchDone: true,
      );

      state = AsyncValue.data(updatedData);
    } catch (e, s) {
      log("Error loading match with id: $matchId into db");
      state = AsyncValue.error(e, s);
    }
  }
}

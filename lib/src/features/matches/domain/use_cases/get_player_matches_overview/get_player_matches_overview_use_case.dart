import 'package:five_on_4_mobile/src/features/matches/domain/repositories/matches/matches_repository.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/values/player_match_models_overview_value.dart';

class GetPlayerMatchesOverviewUseCase {
  const GetPlayerMatchesOverviewUseCase({
    required MatchesRepository matchesRepository,
  }) : _matchesRepository = matchesRepository;

  final MatchesRepository _matchesRepository;

  Future<PlayerMatchModelsOverviewValue> call({
    required int playerId,
  }) async {
    final response = await _matchesRepository.getPlayerMatchesOverview(
      playerId: playerId,
    );

    return response;
  }
}

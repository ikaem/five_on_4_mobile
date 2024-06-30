import 'package:five_on_4_mobile/src/features/matches/domain/repositories/matches/matches_repository.dart';

class LoadPlayerMatchesOverviewUseCase {
  const LoadPlayerMatchesOverviewUseCase({
    required MatchesRepository matchesRepository,
  }) : _matchesRepository = matchesRepository;

  final MatchesRepository _matchesRepository;

  Future<void> call({
    required int playerId,
  }) async {
    await _matchesRepository.loadPlayerMatchesOverview(
      playerId: playerId,
    );
  }
}

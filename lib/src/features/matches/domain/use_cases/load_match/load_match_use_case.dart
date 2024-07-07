import 'package:five_on_4_mobile/src/features/matches/domain/repositories/matches/matches_repository.dart';

class LoadMatchUseCase {
  LoadMatchUseCase({
    required MatchesRepository matchesRepository,
  }) : _matchesRepository = matchesRepository;

  final MatchesRepository _matchesRepository;

  Future<void> call({
    required int matchId,
  }) async {
    await _matchesRepository.loadMatch(
      matchId: matchId,
    );

    // return response;
  }
}

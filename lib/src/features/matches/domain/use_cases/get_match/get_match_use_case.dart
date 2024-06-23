import 'package:five_on_4_mobile/src/features/matches/domain/models/match/match_model.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/repositories/matches/matches_repository.dart';

class GetMatchUseCase {
  GetMatchUseCase({
    required MatchesRepository matchesRepository,
  }) : _matchesRepository = matchesRepository;

  final MatchesRepository _matchesRepository;

  Future<MatchModel> call({
    required int matchId,
  }) async {
    final response = await _matchesRepository.getMatch(
      matchId: matchId,
    );

    return response;
  }
}

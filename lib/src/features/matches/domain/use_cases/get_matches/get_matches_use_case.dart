import 'package:five_on_4_mobile/src/features/matches/domain/models/match/match_model.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/repositories/matches/matches_repository.dart';

class GetMatchesUseCase {
  const GetMatchesUseCase({
    required MatchesRepository matchesRepository,
  }) : _matchesRepository = matchesRepository;

  final MatchesRepository _matchesRepository;

  Future<List<MatchModel>> call({required List<int> matchIds}) async {
    final matches = await _matchesRepository.getMatches(
      matchIds: matchIds,
    );
    return matches;
  }
}

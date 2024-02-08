// TODO make some interfcae for use cases maybe
import 'package:five_on_4_mobile/src/features/matches/domain/models/match/match_model.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/repository_interfaces/matches_repository.dart';

class GetMyTodayMatchesUseCase {
  GetMyTodayMatchesUseCase({
    required MatchesRepository matchesRepository,
  }) : _matchesRepository = matchesRepository;

  final MatchesRepository _matchesRepository;

  Future<List<MatchModel>> call() async {
    return await _matchesRepository.getMyTodayMatches();
  }
}

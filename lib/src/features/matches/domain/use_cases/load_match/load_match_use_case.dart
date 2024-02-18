import 'package:five_on_4_mobile/src/features/matches/domain/repository_interfaces/matches_repository.dart';

class LoadMatchUseCase {
  LoadMatchUseCase({
    required MatchesRepository matchesRepository,
  }) : _matchesRepository = matchesRepository;

  final MatchesRepository _matchesRepository;

  Future<int> call({
    required int matchId,
  }) async {
    final response = await _matchesRepository.loadMatch(
      matchId: matchId,
    );

    return response;
  }
}

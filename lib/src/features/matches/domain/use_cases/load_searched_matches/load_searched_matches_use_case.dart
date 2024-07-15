import 'package:five_on_4_mobile/src/features/matches/data/data_sources/matches_remote/matches_remote_data_source.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/repositories/matches/matches_repository.dart';

class LoadSearchedMatchesUseCase {
  const LoadSearchedMatchesUseCase({
    required MatchesRepository matchesRepository,
  }) : _matchesRepository = matchesRepository;

  final MatchesRepository _matchesRepository;

  Future<List<int>> call({
    required SearchMatchesFilterValue filter,
  }) async {
    final ids = await _matchesRepository.loadSearchedMatches(
      filter: filter,
    );
    return ids;
  }
}

import 'package:five_on_4_mobile/src/features/matches/domain/repository_interfaces/matches_repository.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/values/match_create_data_value.dart';

class CreateMatchUseCase {
  CreateMatchUseCase({
    required MatchesRepository matchesRepository,
  }) : _matchesRepository = matchesRepository;

  final MatchesRepository _matchesRepository;

  Future<int> call({
    required MatchCreateDataValue matchData,
  }) async {
    final response = await _matchesRepository.createMatch(
      matchData: matchData,
    );

    return response;
  }
}

import 'package:five_on_4_mobile/src/features/matches/domain/repositories_interfaces.dart';

class LoadMyMatchesUseCase {
  LoadMyMatchesUseCase({
    required MatchesRepository matchesRepository,
  }) : _matchesRepository = matchesRepository;

  final MatchesRepository _matchesRepository;

  Future<void> call() async {
    await _matchesRepository.loadMyMatches();
  }
}

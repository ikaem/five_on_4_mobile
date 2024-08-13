import 'package:five_on_4_mobile/src/features/players/domain/repositories/players/players_repository.dart';
import 'package:five_on_4_mobile/src/features/players/domain/values/search_players_fluter_value.dart';

class LoadSearchedPlayersUseCase {
  const LoadSearchedPlayersUseCase({
    required PlayersRepository playersRepository,
  }) : _playersRepository = playersRepository;

  final PlayersRepository _playersRepository;

  Future<List<int>> call({
    required SearchPlayersFilterValue filter,
  }) async {
    final ids = await _playersRepository.loadSearchedPlayers(
      filter: filter,
    );
    return ids;
  }
}

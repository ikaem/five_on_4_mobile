import 'package:five_on_4_mobile/src/features/players/domain/models/player/player_model.dart';
import 'package:five_on_4_mobile/src/features/players/domain/repositories/players/players_repository.dart';

class GetPlayersUseCase {
  const GetPlayersUseCase({
    required PlayersRepository playersRepository,
  }) : _playersRepository = playersRepository;

  final PlayersRepository _playersRepository;

  Future<List<PlayerModel>> call({required List<int> playerIds}) async {
    final players = await _playersRepository.getPlayers(
      playerIds: playerIds,
    );
    return players;
  }
}

import 'package:five_on_4_mobile/src/features/matches/domain/models/match/match_model.dart';
import 'package:five_on_4_mobile/src/features/players/domain/models/player/player_model.dart';
import 'package:five_on_4_mobile/src/features/players/domain/repositories/players/players_repository.dart';

class GetPlayerUseCase {
  const GetPlayerUseCase({required PlayersRepository playersRepository})
      : _playersRepository = playersRepository;

  final PlayersRepository _playersRepository;

  Future<PlayerModel> call() async {
    final PlayerModel player = await _playersRepository.getPlayer(
      playerId: playerId,
    );

// TODO need to test this
    return player;
  }
}

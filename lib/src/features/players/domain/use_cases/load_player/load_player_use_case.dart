import 'package:five_on_4_mobile/src/features/players/domain/repositories/players/players_repository.dart';
import 'package:five_on_4_mobile/src/features/players/domain/repositories/players/players_repository_impl.dart';

class LoadPlayerUseCase {
  const LoadPlayerUseCase({
    required PlayersRepository playersRepository,
  }) : _playersRepository = playersRepository;

  final PlayersRepository _playersRepository;

  Future<void> call({
    required int playerId,
  }) async {
    await _playersRepository.loadPlayer(
      playerId: playerId,
    );
  }
}

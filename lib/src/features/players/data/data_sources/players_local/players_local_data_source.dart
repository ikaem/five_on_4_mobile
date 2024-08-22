import 'package:five_on_4_mobile/src/features/players/domain/values/player_local_entity_value.dart';

abstract interface class PlayersLocalDataSource {
  Future<int> storePlayer({
    required PlayerLocalEntityValue playerValue,
  });

  Future<List<int>> storePlayers({
    required List<PlayerLocalEntityValue> matchValues,
  });

  Future<PlayerLocalEntityValue> getPlayer({
    required int playerId,
  });

  Future<List<PlayerLocalEntityValue>> getPlayers({
    required List<int> playerIds,
  });
}

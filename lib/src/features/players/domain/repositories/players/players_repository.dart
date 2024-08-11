import 'package:five_on_4_mobile/src/features/players/domain/models/player/player_model.dart';
import 'package:five_on_4_mobile/src/features/players/domain/values/search_players_fluter_value.dart';

abstract interface class PlayersRepository {
  Future<List<PlayerModel>> getPlayers({
    required List<int> playerIds,
  });

  Future<List<int>> loadSearchedPlayers({
    required SearchPlayersFilterValue filter,
  });

  Future<void> loadPlayer({
    required int playerId,
  });
}

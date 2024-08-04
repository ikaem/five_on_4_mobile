import 'package:equatable/equatable.dart';
import 'package:five_on_4_mobile/src/features/players/data/entities/player_remote/player_remote_entity.dart';
import 'package:five_on_4_mobile/src/features/players/domain/values/player_local_entity_value.dart';
import 'package:five_on_4_mobile/src/features/players/domain/values/search_players_fluter_value.dart';

abstract interface class PlayersRemoteDataSource {
  Future<List<PlayerRemoteEntity>> getSearchedPlayers({
    required SearchPlayersFilterValue searchPlayersFilter,
  });
}

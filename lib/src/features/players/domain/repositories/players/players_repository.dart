import 'package:five_on_4_mobile/src/features/players/domain/values/search_players_fluter_value.dart';

abstract interface class PlayersRepository {
  Future<List<int>> loadSearchedPlayers({
    required SearchPlayersFilterValue filter,
  });
}

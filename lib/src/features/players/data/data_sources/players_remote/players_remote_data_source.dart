import 'package:equatable/equatable.dart';
import 'package:five_on_4_mobile/src/features/players/data/entities/player_remote/player_remote_entity.dart';

abstract interface class PlayersRemoteDataSource {
  Future<List<PlayerRemoteEntity>> getSearchedPlayers({
    required SearchPlayersFilterValue searchPlayersFilter,
  });
}

// TODO move to values somewhere
class SearchPlayersFilterValue extends Equatable {
  const SearchPlayersFilterValue({required this.name});

  /// [name] will be used to search against players:
  /// - First name
  /// - Last name
  /// - Nickname
  final String name;

  @override
  List<Object> get props => [
        name,
      ];
}

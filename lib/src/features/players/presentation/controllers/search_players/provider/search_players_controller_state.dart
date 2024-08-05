part of "search_players_controller.dart";

class SearchPlayersControllerState extends Equatable {
  const SearchPlayersControllerState({
    required this.foundPlayers,
  });

  final List<PlayerModel> foundPlayers;

  @override
  List<Object> get props => [
        foundPlayers,
      ];
}

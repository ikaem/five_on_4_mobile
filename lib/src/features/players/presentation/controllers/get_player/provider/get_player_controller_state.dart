// TODO maybe state is an overkill here, we could just use a simple variable
part of "get_player_controller.dart";

class GetPlayerControllerState extends Equatable {
  const GetPlayerControllerState({
    // required this.isRemoteFetchDone,
    required this.player,
  });

  // TODO not needed for now
  // final bool isRemoteFetchDone;
  final PlayerModel player;

  @override
  List<Object> get props => [
        // isRemoteFetchDone,
        player,
      ];
}

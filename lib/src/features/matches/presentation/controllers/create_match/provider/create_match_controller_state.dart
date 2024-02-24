part of "create_match_controller.dart";

class CreateMatchControllerState extends Equatable {
  const CreateMatchControllerState({
    required this.matchId,
  });

  final int matchId;

  @override
  List<Object> get props => [
        matchId,
      ];
}

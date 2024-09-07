part of "join_match_controller.dart";

class JoinMatchControllerState extends Equatable {
  const JoinMatchControllerState({
    required this.participationId,
  });

  final int participationId;

  @override
  List<Object> get props => [
        participationId,
      ];
}

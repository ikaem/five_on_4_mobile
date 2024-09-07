part of "invite_to_match_controller.dart";

class InviteToMatchControllerState extends Equatable {
  const InviteToMatchControllerState({
    required this.participationId,
  });

  final int participationId;

  @override
  List<Object> get props => [
        participationId,
      ];
}

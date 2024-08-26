part of "unjoin_match_controller.dart";

class UnjoinMatchControllerState extends Equatable {
  const UnjoinMatchControllerState({
    required this.participationId,
  });

  final int participationId;

  @override
  List<Object> get props => [
        participationId,
      ];
}

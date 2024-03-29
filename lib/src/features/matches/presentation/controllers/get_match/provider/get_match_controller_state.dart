part of "get_match_controller.dart";

class GetMatchControllerState extends Equatable {
  const GetMatchControllerState({
    required this.isRemoteFetchDone,
    required this.match,
  });

  final bool isRemoteFetchDone;
  final MatchModel match;

  @override
  List<Object> get props => [
        isRemoteFetchDone,
        match,
      ];
}

part of "search_matches_controller.dart";

class SearchMatchesControllerState extends Equatable {
  const SearchMatchesControllerState({
    required this.foundMatches,
  });

  final List<MatchModel> foundMatches;
// TODO more fields will come to be used for pagination

  @override
  List<Object> get props => [
        foundMatches,
      ];
}

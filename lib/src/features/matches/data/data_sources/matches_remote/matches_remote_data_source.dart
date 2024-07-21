import 'package:equatable/equatable.dart';
import 'package:five_on_4_mobile/src/features/matches/data/entities/match_remote/match_remote_entity.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/values/match_create_data_value.dart';

// TODO move to values

abstract interface class MatchesRemoteDataSource {
  Future<int> createMatch({
    required MatchCreateDataValue matchData,
  });

  Future<MatchRemoteEntity> getMatch({
    required int matchId,
  });

  Future<List<MatchRemoteEntity>> getPlayerMatchesOverview({
    required int playerId,
  });

  // TODO dont forget that all of this stuff will require pagination data eventually
  Future<List<MatchRemoteEntity>> getSearchedMatches({
    required SearchMatchesFilterValue searchMatchesFilter,
  });

  // TODO deprecate this
  // TODO eventually change this to pass playerId Parameter as well
  // Future<List<MatchRemoteEntity>> getPlayerInitialMatches(
  //     // TODO also we should make this called something like - getInitialPlayerMatches
  //     // TODO this function should get 5 matches for today, and 5 for past, and 5 for upcogming
  //     // TODO we should make this generic
  //     /*
  //     pass info:
  //     - playerId
  //     - page
  //      */
  //     );
}

// TODO move to values
class SearchMatchesFilterValue extends Equatable {
  const SearchMatchesFilterValue({
    required this.matchTitle,
  });

  final String matchTitle;

  @override
  List<Object> get props => [
        matchTitle,
      ];
}

import 'package:five_on_4_mobile/src/features/matches/data/entities/match_local/match_local_entity.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/values/match_local_entity_value.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/values/player_match_local_entities_overview_value%20copy.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/drift/app_database.dart';

// TODO move to values

// TODO move to values

abstract interface class MatchesLocalDataSource {
  // TODO not sure if i even need a response here
  // TODO old
  // Future<int> saveMatch({
  //   required MatchLocalEntity match,
  // });

  /// This upserts the match
  Future<int> storeMatch({
    required MatchLocalEntityValue matchValue,
  });

  /// This upserts the matches
  Future<void> storeMatches({
    required List<MatchLocalEntityValue> matchValues,
  });

  Future<PlayerMatchLocalEntitiesOverviewValue> getPlayerMatchesOverview({
    required int playerId,
  });

  // TODO deprecated this
  Future<List<int>> saveMatches({
    required List<MatchLocalEntity> matches,
  });

  // TODO deprecated this
  // TODO these could all probably be abstracted into one function with a parameter for the type of match
  Future<List<MatchLocalEntity>> getUpcomingMatchesForPlayer({
    required int playerId,
  });

  Future<List<MatchLocalEntity>> getTodayMatchesForPlayer({
    required int playerId,
  });

  Future<List<MatchLocalEntity>> getPastMatchesForPlayer({
    required int playerId,
  });

  // TODO old
  // Future<MatchLocalEntity> getMatch({
  //   required int matchId,
  // });

  // TODO all of these should return values, not direct entities
  Future<MatchLocalEntityData> getMatch({
    required int matchId,
  });
}

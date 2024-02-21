import 'package:five_on_4_mobile/src/features/matches/data/entities/match_remote/match_remote_entity.dart';

// TODO move to values

abstract interface class MatchesRemoteDataSource {
  Future<int> createMatch({
    required MatchRemoteEntity match,
  });

  Future<MatchRemoteEntity> getMatch({
    required int matchId,
  });
  // TODO eventually change this to pass playerId Parameter as well
  Future<List<MatchRemoteEntity>> getPlayerInitialMatches(
      // TODO also we should make this called something like - getInitialPlayerMatches
      // TODO this function should get 5 matches for today, and 5 for past, and 5 for upcogming
      // TODO we should make this generic
      /* 
      pass info:
      - playerId
      - page
       */
      );
}

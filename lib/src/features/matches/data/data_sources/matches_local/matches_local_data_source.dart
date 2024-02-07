import 'package:five_on_4_mobile/src/features/matches/data/entities/match_remote/match_local/match_local_entity.dart';

abstract interface class MatchesLocalDataSource {
  Future<List<int>> saveMatches({
    required List<MatchLocalEntity> matches,
  });

  Future<List<MatchLocalEntity>> getFollowingMatchesForPlayer({
    required int playerId,
  });

  Future<List<MatchLocalEntity>> getTodayMatchesForPlayer({
    required int playerId,
  });
}

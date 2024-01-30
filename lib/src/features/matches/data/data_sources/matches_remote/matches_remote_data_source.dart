import 'package:five_on_4_mobile/src/features/matches/data/entities/match_remote/match_remote_entity.dart';

abstract interface class MatchesRemoteDataSource {
  Future<List<MatchRemoteEntity>> getMyFollowingMatches({
    required String userId,
  });
}

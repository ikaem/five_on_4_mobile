import 'package:five_on_4_mobile/src/features/matches/data/entities/match_remote/match_remote_entity.dart';

abstract interface class MatchesRemoteDataSource {
  Future<List<MatchRemoteEntity>> getMyFollowingMatches(
      // TODO no need to provide anything  - interceptor will retrieve logged in user id and send it together with request - on backend, we will extract it from the token
      );
}

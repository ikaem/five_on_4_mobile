import 'package:five_on_4_mobile/src/features/player_match_participation/data/data_sources/player_match_participation_remote_data_source.dart';

class PlayerMatchParticipationRemoteDataSourceImpl
    implements PlayerMatchParticipationRemoteDataSource {
  @override
  Future<int> joinMatch({required int matchId, required int playerId}) async {
    // TODO: implement joinMatch
    throw UnimplementedError();
  }

  @override
  Future<int> unjoinMatch({required int matchId, required int playerId}) async {
    throw UnimplementedError();
  }

  @override
  Future<int> inviteToMatch(
      {required int matchId, required int playerId}) async {
    // TODO: implement inviteToMatch
    throw UnimplementedError();
  }
}

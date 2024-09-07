import 'package:five_on_4_mobile/src/features/player_match_participation/data/data_sources/player_match_participation_remote/player_match_participation_remote_data_source.dart';
import 'package:five_on_4_mobile/src/features/player_match_participation/domain/repositories/player_match_participation_repository.dart';

// TODO this whole thing should be with player_match_participations, plural. change it in future

class PlayerMatchParticipationRepositoryImpl
    implements PlayerMatchParticipationRepository {
  PlayerMatchParticipationRepositoryImpl({
    required this.playerMatchParticipationRemoteDataSource,
  });

  final PlayerMatchParticipationRemoteDataSource
      playerMatchParticipationRemoteDataSource;

  @override
  Future<int> joinMatch({
    required int matchId,
    // TODO maybe it would be better to let backend get this from token, but for now it is this way
    required int playerId,
  }) async {
    final id = await playerMatchParticipationRemoteDataSource.joinMatch(
      matchId: matchId,
      playerId: playerId,
    );

    return id;
  }

  @override
  Future<int> unjoinMatch({
    required int matchId,
    required int playerId,
  }) async {
    final id = await playerMatchParticipationRemoteDataSource.unjoinMatch(
      matchId: matchId,
      playerId: playerId,
    );

    return id;
  }

  @override
  Future<int> inviteToMatch({
    required int matchId,
    required int playerId,
  }) async {
    final id = await playerMatchParticipationRemoteDataSource.inviteToMatch(
      matchId: matchId,
      playerId: playerId,
    );

    return id;
  }
}

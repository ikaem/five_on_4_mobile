import 'package:five_on_4_mobile/src/features/player_match_participation/domain/repositories/player_match_participation_repository.dart';

class InviteToMatchUseCase {
  const InviteToMatchUseCase({
    required PlayerMatchParticipationRepository
        playerMatchParticipationRepository,
  }) : _playerMatchParticipationRepository = playerMatchParticipationRepository;

  final PlayerMatchParticipationRepository _playerMatchParticipationRepository;

  Future<int> call({
    required int matchId,
    required int playerId,
  }) async {
    final response = await _playerMatchParticipationRepository.inviteToMatch(
      matchId: matchId,
      playerId: playerId,
    );

    return response;
  }
}

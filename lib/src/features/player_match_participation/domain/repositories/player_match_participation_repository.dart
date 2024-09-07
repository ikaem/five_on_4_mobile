abstract interface class PlayerMatchParticipationRepository {
  // TODO we dont need this yet
  // Future<int> storePlayerMatchParticipation({
  //   required PlayerMatchParticipationLocalEntityValue
  //       playerMatchParticipationValue,
  // });

  Future<int> joinMatch({
    required int matchId,
    // TODO maybe it would be better to let backend get this from token, but for now it is this way
    required int playerId,
  });

  Future<int> unjoinMatch({
    required int matchId,
    required int playerId,
  });

  Future<int> inviteToMatch({
    required int matchId,
    required int playerId,
  });
}

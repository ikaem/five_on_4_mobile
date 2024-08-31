import 'package:equatable/equatable.dart';
import 'package:five_on_4_mobile/src/features/player_match_participation/data/entities/player_match_participation_local/player_match_participation_local_entity.dart';
import 'package:five_on_4_mobile/src/features/player_match_participation/domain/values/player_match_participation_local_entity_value.dart';

abstract interface class PlayerMatchParticipationLocalDataSource {
  // TODO we dont need this yet
  Future<int> storeParticipation({
    required PlayerMatchParticipationLocalEntityValue
        playerMatchParticipationValue,
  });

  Future<List<int>> storeParticipations({
    required List<PlayerMatchParticipationLocalEntityValue>
        playerMatchParticipationValues,
  });
}

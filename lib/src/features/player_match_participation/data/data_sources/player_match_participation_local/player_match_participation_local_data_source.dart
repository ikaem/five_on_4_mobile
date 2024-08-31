import 'package:equatable/equatable.dart';
import 'package:five_on_4_mobile/src/features/player_match_participation/data/entities/player_match_participation_local/player_match_participation_local_entity.dart';
import 'package:five_on_4_mobile/src/features/player_match_participation/domain/values/player_match_participation_local_entity_value.dart';

abstract interface class PlayerMatchParticipationLocalDataSource {
  // NOTE this might not even be needed - matches and players local data sources might be doing this instead, to make sure all is in one trasnaction
  // TODO we will see
  // TODO maybe this will be useful when we do some isolatioed creation of participation(s)
  Future<int> storeParticipation({
    required PlayerMatchParticipationLocalEntityValue
        playerMatchParticipationValue,
  });

  Future<List<int>> storeParticipations({
    required List<PlayerMatchParticipationLocalEntityValue>
        playerMatchParticipationValues,
  });
}

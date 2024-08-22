import 'package:five_on_4_mobile/src/features/players/data/entities/player_local/player_local_entity.dart';
import 'package:five_on_4_mobile/src/features/players/domain/models/player/player_model.dart';
import 'package:five_on_4_mobile/src/features/players/domain/values/player_local_entity_value.dart';

abstract class PlayersConverter {
  static PlayerModel toModelFromLocalEntityValue(
      PlayerLocalEntityValue entityValue) {
    return PlayerModel(
      id: entityValue.id,
      avatarUri: Uri.parse(entityValue.avatarUrl),
      name: "${entityValue.firstName} ${entityValue.lastName}",
      nickname: entityValue.nickname,
    );
  }
}

import 'package:five_on_4_mobile/src/features/auth/domain/models/authenticated_player/authenticated_player_model.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/drift/app_database.dart';

abstract class AuthenticatedPlayerConverters {
  static AuthenticatedPlayerModel toModelFromLocalEntityData({
    required AuthenticatedPlayerLocalEntityData entity,
  }) {
    return AuthenticatedPlayerModel(
      playerId: entity.playerId,
      playerName: entity.playerName,
      playerNickname: entity.playerNickname,
    );
  }
}

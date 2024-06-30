import 'package:five_on_4_mobile/src/features/auth/data/entities/auth_local/auth_local_entity.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/values/anthenticated_player_local_entity_value.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/drift/app_database.dart';

abstract interface class AuthLocalDataSource {
  // Future<AuthDataEntity?> getLoggedInAuthLocalEntity();
  // Future<void> storeAuthData({
  //   // TODO this type needs rename
  //   required AuthDataEntity authLocalEntityDraft,
  // });

  Future<AuthLocalEntity?> getAuthEntity(int authId);
  Future<int> storeAuthEntity(AuthLocalEntity authLocalEntity);
  Future<int> storeAuthenticatedPlayerEntity(
    AuthenticatedPlayerLocalEntityValue entityValue,
  );
  Future<void> deleteAuthenticatedPlayerEntities();

  // Stream<List<AuthenticatedPlayerLocalEntityData?>>
  //     getAuthenticatedPlayersLocalEntityDataStream();

  // TODO use here value as well
  Stream<AuthenticatedPlayerLocalEntityData?>
      getAuthenticatedPlayerLocalEntityDataStream();

  Future<AuthenticatedPlayerLocalEntityValue?>
      getAuthenticatedPlayerLocalEntity();
}

// TODO move to values

// class AuthenticatedPlayerLocalEntityValue {
//   const AuthenticatedPlayerLocalEntityValue({
//     required this.playerId,
//     required this.playerName,
//     required this.playerNickname,
//   });

//   final int playerId;
//   final String playerName;
//   final String playerNickname;
// }

import 'package:five_on_4_mobile/src/features/auth/data/data_sources/auth_local/auth_local_data_source.dart';
import 'package:five_on_4_mobile/src/features/auth/data/entities/auth_data/auth_data_entity.dart';
import 'package:five_on_4_mobile/src/features/auth/data/entities/auth_local/auth_local_entity.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/isar/isar_wrapper.dart';
import 'package:isar/isar.dart';

// TODO maybe we dont need secure storage wrapper here

// TODO temp - remove this
final dummyAuthDataEntity = AuthDataEntity(
  playerInfo: const AuthDataPlayerInfoEntity(
    id: 1,
    firstName: "John",
    lastName: "Doe",
    nickName: "JD",
  ),
  teamInfo: const AuthDataTeamInfoEntity(
    id: 1,
    teamName: "Team 1",
  ),
);

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  const AuthLocalDataSourceImpl({
    required IsarWrapper isarWrapper,
  }) : _isarWrapper = isarWrapper;

  final IsarWrapper _isarWrapper;

  @override
  Future<AuthLocalEntity?> getAuthEntity(int authId) async {
    final authDataEntity = await _isarWrapper.db.authLocalEntitys
        .where()
        .idEqualTo(authId)
        .findFirst();
    return authDataEntity;
  }

  @override
  Future<int> storeAuthEntity(AuthLocalEntity authLocalEntity) async {
    final id = await _isarWrapper.db.writeTxn(() async {
      return await _isarWrapper.db.authLocalEntitys.put(authLocalEntity);
    });

    return id;
  }

// TODO no need for this
  // @override
  // Future<AuthDataEntity?> getLoggedInAuthLocalEntity() async {
  //   final authId = await _secureStorageWrapper.getAuthId();
  //   if (authId == null) {
  //     await _secureStorageWrapper.clearAuthData();
  //     return null;
  //   }

  //   // get db data
  //   final authDataEntity =
  //       await _isarWrapper.db.authDataEntitys.where().findAll();
  //   if (authDataEntity.isEmpty) {
  //     await _secureStorageWrapper.clearAuthData();
  //     return null;
  //   }
  //   return null;

  //   // TODO use this for short circuit log in dev
  //   // return dummyAuthDataEntity;

  //   // return null;

  //   // final storedAuthData = await _secureStorageWrapper.getAuthData();
  //   // if (storedAuthData == null) return null;

  //   // final (_, authId) = storedAuthData;

  //   // final authData = await _isarWrapper.db.authDataEntitys.where().findAll();
  //   // if (authData.isEmpty) {
  //   //   // TODO this should not happen - clear token now
  //   //   return null;
  //   // }

  //   // if (authData.length > 1) {
  //   //   // TODO this should not happen - clear token now
  //   //   return null;
  //   // }

  //   // final authDataEntity = authData.first;

  //   // if (authDataEntity == null) return null;
  //   // if (authDataEntity.id != authId) return null;
  //   // // TODO also should clear token for sure here

  //   // return authDataEntity;
  // }

  /// authDataEntityDraft is the entity that is not yet stored in the database
  // @override
  // Future<void> storeAuthData({
  //   required AuthDataEntity authLocalEntityDraft,
  // }) async {
  //   final result = await _isarWrapper.db.writeTxn(() async {
  //     final id =
  //         await _isarWrapper.db.authDataEntitys.put(authLocalEntityDraft);
  //     return id;
  //   });

  //   await _secureStorageWrapper.storeAuthId(result);
  // }

  // TODO create same one like this to save auth data to secure storage
}

import 'package:five_on_4_mobile/src/features/auth/data/data_sources/auth_local/auth_local_data_source.dart';
import 'package:five_on_4_mobile/src/features/auth/data/entities/auth_data/auth_data_entity.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/flutter_secure_storage/flutter_secure_storage_wrapper.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/isar/isar_wrapper.dart';

// TODO temp - remove this
final dummyAuthDataEntity = AuthDataEntity(
  playerInfo: AuthDataPlayerInfoEntity(
    id: 1,
    firstName: "John",
    lastName: "Doe",
    nickName: "JD",
  ),
  teamInfo: AuthDataTeamInfoEntity(
    id: 1,
    teamName: "Team 1",
  ),
);

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  const AuthLocalDataSourceImpl({
    required FlutterSecureStorageWrapper secureStorageWrapper,
    required IsarWrapper isarWrapper,
  })  : _secureStorageWrapper = secureStorageWrapper,
        _isarWrapper = isarWrapper;

  final FlutterSecureStorageWrapper _secureStorageWrapper;
  final IsarWrapper _isarWrapper;

  @override
  Future<AuthDataEntity?> getAuthData() async {
    // TODO use this for short circuit log in dev
    return dummyAuthDataEntity;

    // final storedAuthData = await _secureStorageWrapper.getAuthData();
    // if (storedAuthData == null) return null;

    // final (_, authId) = storedAuthData;

    // final authData = await _isarWrapper.findAllEntities<AuthDataEntity>();
    // if (authData.isEmpty) {
    //   // TODO this should not happen - clear token now
    //   return null;
    // }

    // if (authData.length > 1) {
    //   // TODO this should not happen - clear token now
    //   return null;
    // }

    // final authDataEntity = authData.first;

    // if (authDataEntity == null) return null;
    // if (authDataEntity.id != authId) return null;
    // // TODO also should clear token for sure here

    // return authDataEntity;
  }

  @override
  Future<void> setAuthData({
    /// authDataEntityDraft is the entity that is not yet stored in the database
    required AuthDataEntity authDataEntityDraft,
    required String authToken,
  }) async {
    final id = await _isarWrapper.putEntity<AuthDataEntity>(
      entity: authDataEntityDraft,
    );

    await _secureStorageWrapper.storeAuthData(
      token: authToken,
      authId: id,
    );
  }

  // TODO create same one like this to save auth data to secure storage
}

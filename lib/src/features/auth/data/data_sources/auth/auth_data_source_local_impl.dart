import 'package:five_on_4_mobile/src/features/auth/data/data_sources/auth/auth_data_source_local.dart';
import 'package:five_on_4_mobile/src/features/auth/data/entities/auth_data/auth_data_entity.dart';
import 'package:five_on_4_mobile/src/features/auth/utils/constants/secure_storage_auth_key_constants.dart';
import 'package:five_on_4_mobile/src/features/auth/utils/extensions/flutter_secure_storage_wrapper_auth_extension.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/flutter_secure_storage/flutter_secure_storage_wrapper.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/isar/isar_wrapper.dart';

class AuthDataSourceLocalImpl implements AuthDataSourceLocal {
  const AuthDataSourceLocalImpl({
    required FlutterSecureStorageWrapper secureStorageWrapper,
    required IsarWrapper isarWrapper,
  })  : _secureStorageWrapper = secureStorageWrapper,
        _isarWrapper = isarWrapper;

  final FlutterSecureStorageWrapper _secureStorageWrapper;
  final IsarWrapper _isarWrapper;

  @override
  Future<AuthDataEntity?> getAuthData() async {
    // final token = await _secureStorageWrapper.readKeyValue(
    //   key: SecureStorageAuthKey.TOKEN.value,
    // );
    // if (token == null) {
    //   return null;
    // }
    // TODO no

    final storedAuthData = await _secureStorageWrapper.getAuthData();
    if (storedAuthData == null) return null;

    final (_, authId) = storedAuthData;

    // TODO not sure if this would work
    final authData = await _isarWrapper.db.authDataEntitys.getAll([]);
    if (authData.isEmpty) {
      // TODO this should not happen - clear token now
      return null;
    }

    if (authData.length > 1) {
      // TODO this should not happen - clear token now
      return null;
    }

    final authDataEntity = authData.first;

    if (authDataEntity == null) return null;
    if (authDataEntity.id != authId) return null;
    // TODO also should clear token for sure here

    return authDataEntity;
  }

  // TODO create same one like this to save auth data to secure storage
}

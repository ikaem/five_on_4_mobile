import 'package:five_on_4_mobile/src/features/auth/utils/constants/secure_storage_auth_key_constants.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FlutterSecureStorageWrapper {
  const FlutterSecureStorageWrapper({
    required FlutterSecureStorage secureStorage,
  }) : _secureStorage = secureStorage;

  // TODO this might be good to be provided to the wrapper
  final FlutterSecureStorage _secureStorage;

  // TODO much of this migth not be needed

  Future<void> storeAuthId(int authId) async {
    await _saveKeyValue(
      key: SecureStorageAuthKeyConstants.AUTH_ID.value,
      value: authId.toString(),
    );
  }

  Future<int?> getAuthId() async {
    final authIdString = await _readKeyValue(
      key: SecureStorageAuthKeyConstants.AUTH_ID.value,
    );

    final authId = int.tryParse(authIdString ?? "");

    return authId;
  }

  Future<String?> getAccessCookie() {
    return _readKeyValue(
      key: SecureStorageAuthKeyConstants.ACCESS_COOKIE.value,
    );
  }

  Future<void> storeAccessCookie(String cookie) {
    return _saveKeyValue(
      key: SecureStorageAuthKeyConstants.ACCESS_COOKIE.value,
      value: cookie,
    );
  }

  Future<void> clearAuthData() async {
    await Future.wait([
      _deleteKeyValue(
        key: SecureStorageAuthKeyConstants.ACCESS_COOKIE.value,
      ),
      _deleteKeyValue(
        key: SecureStorageAuthKeyConstants.AUTH_ID.value,
      ),
    ]);
  }

  Future<void> _saveKeyValue({
    required String key,
    required String value,
  }) {
    return _secureStorage.write(key: key, value: value);
  }

  Future<void> _deleteKeyValue({
    required String key,
  }) {
    return _secureStorage.delete(key: key);
  }

  Future<String?> _readKeyValue({
    required String key,
  }) {
    return _secureStorage.read(key: key);
  }

  @visibleForTesting
  Future<void> deleteAll() {
    return _secureStorage.deleteAll();
  }
}

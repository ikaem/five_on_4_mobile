import 'package:five_on_4_mobile/src/features/auth/utils/constants/secure_storage_auth_key_constants.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FlutterSecureStorageWrapper {
  const FlutterSecureStorageWrapper({
    required FlutterSecureStorage secureStorage,
  }) : _secureStorage = secureStorage;

  // TODO this might be good to be provided to the wrapper
  final FlutterSecureStorage _secureStorage;

  Future<void> storeAccessToken(String accessToken) async {
    await _saveKeyValue(
      key: SecureStorageAuthKeyConstants.ACCESS_TOKEN.value,
      value: accessToken,
    );
  }

  Future<String?> getAccessToken() async {
    return _readKeyValue(
      key: SecureStorageAuthKeyConstants.ACCESS_TOKEN.value,
    );
  }

  Future<void> clearAccessToken() async {
    await _deleteKeyValue(
      key: SecureStorageAuthKeyConstants.ACCESS_TOKEN.value,
    );
  }

  Future<void> storeRefreshTokenCookie(String refreshTokenCookie) async {
    await _saveKeyValue(
      key: SecureStorageAuthKeyConstants.REFRESH_TOKEN_COOKIE.value,
      value: refreshTokenCookie,
    );
  }

  Future<String?> getRefreshTokenCookie() async {
    return _readKeyValue(
      key: SecureStorageAuthKeyConstants.REFRESH_TOKEN_COOKIE.value,
    );
  }

  Future<void> clearRefreshTokenCookie() async {
    await _deleteKeyValue(
      key: SecureStorageAuthKeyConstants.REFRESH_TOKEN_COOKIE.value,
    );
  }

  // TODO much of this migth not be needed

// TODO lot of this is not needed - we will transfer all of this into db except for access token and refresh token cookie (entire - need all values inside)
  // Future<void> storeAuthId(int authId) async {
  //   // TODO maybe not needed
  //   // await _saveKeyValue(
  //   //   key: SecureStorageAuthKeyConstants.AUTH_ID.value,
  //   //   value: authId.toString(),
  //   // );
  // }

  // Future<int?> getAuthId() async {
  //   return null;
  //   // TODO maybe bnot needed
  //   // final authIdString = await _readKeyValue(
  //   //   key: SecureStorageAuthKeyConstants.AUTH_ID.value,
  //   // );

  //   // final authId = int.tryParse(authIdString ?? "");

  //   // return authId;
  // }

  // Future<String?> getAccessCookie() async {
  //   return null;
  //   // TODO not needed
  //   // return _readKeyValue(
  //   //   key: SecureStorageAuthKeyConstants.ACCESS_COOKIE.value,
  //   // );
  // }

  // Future<void> storeAccessCookie(String cookie) async {
  //   // TODO not needed
  //   // return _saveKeyValue(
  //   //   key: SecureStorageAuthKeyConstants.ACCESS_COOKIE.value,
  //   //   value: cookie,
  //   // );
  // }

  // Future<void> clearAuthData() async {
  //   // TODO not needed
  //   // await Future.wait([
  //   //   _deleteKeyValue(
  //   //     key: SecureStorageAuthKeyConstants.ACCESS_COOKIE.value,
  //   //   ),
  //   //   _deleteKeyValue(
  //   //     key: SecureStorageAuthKeyConstants.AUTH_ID.value,
  //   //   ),
  //   // ]);
  // }

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

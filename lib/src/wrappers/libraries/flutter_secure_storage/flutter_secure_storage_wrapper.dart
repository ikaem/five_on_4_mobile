import 'package:five_on_4_mobile/src/features/auth/utils/constants/secure_storage_auth_key_constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FlutterSecureStorageWrapper {
  const FlutterSecureStorageWrapper();

  final secureStorage = const FlutterSecureStorage();

  Future<(String, int)?> getAuthData() async {
    final token = await _readKeyValue(
      key: SecureStorageAuthKeyConstants.TOKEN.value,
    );
    if (token == null) return null;

    final authIdString = await _readKeyValue(
      key: SecureStorageAuthKeyConstants.AUTH_ID.value,
    );
    if (authIdString == null) return null;

    final authId = int.tryParse(authIdString);
    if (authId == null) return null;

    return (token, authId);
  }

  Future<void> storeAuthData({
    required String token,
    required int authId,
  }) async {
    await _saveKeyValue(
      key: SecureStorageAuthKeyConstants.TOKEN.value,
      value: token,
    );
    await _saveKeyValue(
      key: SecureStorageAuthKeyConstants.AUTH_ID.value,
      value: authId.toString(),
    );
  }

  Future<void> _saveKeyValue({
    required String key,
    required String value,
  }) {
    return secureStorage.write(key: key, value: value);
  }

  Future<void> _deleteKeyValue({
    required String key,
  }) {
    return secureStorage.delete(key: key);
  }

  Future<String?> _readKeyValue({
    required String key,
  }) {
    return secureStorage.read(key: key);
  }
}

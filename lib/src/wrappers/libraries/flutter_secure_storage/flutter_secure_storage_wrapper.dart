import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FlutterSecureStorageWrapper {
  const FlutterSecureStorageWrapper();

  final secureStorage = const FlutterSecureStorage();

  Future<void> saveKeyValue({
    required String key,
    required String value,
  }) {
    return secureStorage.write(key: key, value: value);
  }

  Future<void> deleteKeyValue({
    required String key,
  }) {
    return secureStorage.delete(key: key);
  }

  Future<String?> readKeyValue({
    required String key,
  }) {
    return secureStorage.read(key: key);
  }
}

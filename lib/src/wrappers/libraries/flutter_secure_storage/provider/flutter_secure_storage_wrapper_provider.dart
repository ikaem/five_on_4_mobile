import 'package:five_on_4_mobile/src/wrappers/libraries/flutter_secure_storage/flutter_secure_storage_wrapper.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "flutter_secure_storage_wrapper_provider.g.dart";

@riverpod
FlutterSecureStorageWrapper flutterSecureStorageWrapper(
  FlutterSecureStorageWrapperRef ref,
) {
  const secureStorage = FlutterSecureStorage();
  return const FlutterSecureStorageWrapper(
    secureStorage: secureStorage,
  );
}

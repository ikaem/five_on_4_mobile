import 'package:five_on_4_mobile/src/wrappers/libraries/flutter_secure_storage/flutter_secure_storage_wrapper.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';

/// Sets up a test secure storage using FlutterSecureStorage.
///
/// This function
/// - initializes a test secure storage wrapper
/// - after each test it clears the secure storage.
/// - returns an instance of the FlutterSecureStorageWrapper for the test secure storage.
FlutterSecureStorageWrapper setupTestSecureStorage() {
  TestWidgetsFlutterBinding.ensureInitialized();
  // as per https://stackoverflow.com/questions/71873139/missingpluginexceptionno-implementation-found-for-method-read-on-channel-plugin
  FlutterSecureStorage.setMockInitialValues({});

  const secureStorageWrapper = FlutterSecureStorageWrapper();
  // });

  tearDown(() async {
    await secureStorageWrapper.deleteAll();
  });

  return secureStorageWrapper;
}

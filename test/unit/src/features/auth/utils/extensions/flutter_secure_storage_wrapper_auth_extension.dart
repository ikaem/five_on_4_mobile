import 'package:five_on_4_mobile/src/features/auth/utils/constants/secure_storage_auth_key_constants.dart';
import 'package:five_on_4_mobile/src/features/auth/utils/extensions/flutter_secure_storage_wrapper_auth_extension.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/flutter_secure_storage/flutter_secure_storage_wrapper.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const secureStorage = FlutterSecureStorage();

  group("FlutterSecureStorageWrapperAuthExtension", () {
    tearDown(() async {
      await secureStorage.deleteAll();
    });

    group("StoreAuthData", () {
      test("should store token and authId to secure storage WHEN called",
          () async {
        const secureStorageWrapper = FlutterSecureStorageWrapper();

        const token = "token";
        const authId = 1;

        await secureStorageWrapper.storeAuthData(
          token: token,
          authId: authId,
        );

        final storedToken = await secureStorage.read(
          key: SecureStorageAuthKeyConstants.TOKEN.value,
        );

        final storedAuthIdString = await secureStorage.read(
          key: SecureStorageAuthKeyConstants.AUTH_ID.value,
        );
        final storedAuthId = int.tryParse(storedAuthIdString ?? "");

        expect(storedToken, token);
        expect(storedAuthId, authId);
      });
    });
  });
}

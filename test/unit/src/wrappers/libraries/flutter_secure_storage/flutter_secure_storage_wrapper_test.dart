import 'package:five_on_4_mobile/src/features/auth/utils/constants/secure_storage_auth_key_constants.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/flutter_secure_storage/flutter_secure_storage_wrapper.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  // as per https://stackoverflow.com/questions/71873139/missingpluginexceptionno-implementation-found-for-method-read-on-channel-plugin
  FlutterSecureStorage.setMockInitialValues({});

  // use for validation only
  const secureStorage = FlutterSecureStorage();

  tearDown(() async {
    await secureStorage.deleteAll();
  });
  group(
    "FlutterSecureStorageWrapper",
    () {
      group(
        ".getAuthData",
        () {
          test(
            "given authId and authToken stored in secure storage"
            "when '.getAuthData' is called"
            "should retrieve expected authId and authToken",
            () async {
              const secureStorageWrapper = FlutterSecureStorageWrapper();
              const expectedAuthId = 1;
              const expectedToken = "testToken";

              await secureStorage.write(
                key: SecureStorageAuthKeyConstants.AUTH_ID.value,
                value: expectedAuthId.toString(),
              );
              await secureStorage.write(
                key: SecureStorageAuthKeyConstants.TOKEN.value,
                value: expectedToken,
              );

              final (token, authId) =
                  (await secureStorageWrapper.getAuthData())!;

              expect(token, expectedToken);
              expect(authId, expectedAuthId);
            },
          );
        },
      );

      group(
        ".storeAuthData()",
        () {
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
        },
      );

      group(
        ".deleteAuthData()",
        () {
          test("should delete token and authId from secure storage WHEN called",
              () async {
            const secureStorageWrapper = FlutterSecureStorageWrapper();

            const token = "token";
            const authId = 1;

            await secureStorage.write(
              key: SecureStorageAuthKeyConstants.AUTH_ID.value,
              value: authId.toString(),
            );
            await secureStorage.write(
              key: SecureStorageAuthKeyConstants.TOKEN.value,
              value: token,
            );

            await secureStorageWrapper.clearAuthData();

            final deletedToken = await secureStorage.read(
              key: SecureStorageAuthKeyConstants.TOKEN.value,
            );
            final deletedAuthIdString = await secureStorage.read(
              key: SecureStorageAuthKeyConstants.AUTH_ID.value,
            );

            expect(deletedToken, isNull);
            expect(deletedAuthIdString, isNull);
          });
        },
      );
    },
  );
}

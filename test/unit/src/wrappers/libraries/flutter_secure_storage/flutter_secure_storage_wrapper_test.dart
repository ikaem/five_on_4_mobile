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
  const secureStorageWrapper = FlutterSecureStorageWrapper(
    secureStorage: secureStorage,
  );

  tearDown(() async {
    await secureStorage.deleteAll();
  });
  group(
    "FlutterSecureStorageWrapper",
    () {
      group(
        ".storeAuthId",
        () {
          test(
            "given authId argument is provided"
            "when '.storeAuthId()' is called"
            "then should store authId in secure storage",
            () async {
              // setup

              // given
              const authId = 1;

              // when
              await secureStorageWrapper.storeAuthId(authId);

              // then
              final storedAuthIdString = await secureStorage.read(
                key: SecureStorageAuthKeyConstants.AUTH_ID.value,
              );
              final storedAuthId = int.tryParse(storedAuthIdString ?? "");

              expect(storedAuthId, authId);

              // cleanup
            },
          );
        },
      );

      group(
        ".getAuthId",
        () {
          test(
            "given authId is stored in secure storage"
            "when '.getAuthId()' is called"
            "then should return expectedAuthId",
            () async {
              // setup
              const authId = 1;
              // store manually

              // given
              secureStorage.write(
                key: SecureStorageAuthKeyConstants.AUTH_ID.value,
                value: authId.toString(),
              );

              // when
              final retrievedAuthId = await secureStorageWrapper.getAuthId();

              // then
              expect(retrievedAuthId, authId);

              // cleanup
            },
          );

          test(
            "given authId is not stored in secure storage"
            "when '.getAuthId()' is called"
            "then should return null",
            () async {
              // setup
              // given

              // when
              final retrievedAuthId = await secureStorageWrapper.getAuthId();

              // then
              expect(retrievedAuthId, isNull);

              // cleanup
            },
          );
        },
      );

      group(
        ".storeAccessCookie()",
        () {
          test(
            "given accessCookie argument is provided"
            "when '.storeAccessCookie()' is called"
            "then should store accessCookie in secure storage",
            () async {
              // setup

              // given
              const accessCookie = "accessCookie";

              // when
              await secureStorageWrapper.storeAccessCookie(accessCookie);

              // then
              final storedAccessCookie = await secureStorage.read(
                key: SecureStorageAuthKeyConstants.ACCESS_COOKIE.value,
              );

              expect(storedAccessCookie, accessCookie);

              // cleanup
            },
          );
        },
      );

      group(
        ".getAccessCookie()",
        () {
          test(
            "given accessCookie is stored in secure storage"
            "when '.getAccessCookie()' is called"
            "then should return expectedAccessCookie",
            () async {
              // setup
              const accessCookie = "accessCookie";
              // store manually

              // given
              secureStorage.write(
                key: SecureStorageAuthKeyConstants.ACCESS_COOKIE.value,
                value: accessCookie,
              );

              // when
              final retrievedAccessCookie =
                  await secureStorageWrapper.getAccessCookie();

              // then
              expect(retrievedAccessCookie, accessCookie);

              // cleanup
            },
          );

          test(
            "given accessCookie is not stored in secure storage"
            "when '.getAccessCookie()' is called"
            "then should return null",
            () async {
              // setup
              // given

              // when
              final retrievedAccessCookie =
                  await secureStorageWrapper.getAccessCookie();

              // then
              expect(retrievedAccessCookie, isNull);

              // cleanup
            },
          );
        },
      );

      group(
        ".deleteAuthData()",
        () {
          test("should delete token and authId from secure storage WHEN called",
              () async {
            const accessCookie = "accessCookie";
            const authId = 1;

            await secureStorage.write(
              key: SecureStorageAuthKeyConstants.AUTH_ID.value,
              value: authId.toString(),
            );
            await secureStorage.write(
              key: SecureStorageAuthKeyConstants.ACCESS_COOKIE.value,
              value: accessCookie,
            );

            await secureStorageWrapper.clearAuthData();

            final deletedAccessCookie = await secureStorage.read(
              key: SecureStorageAuthKeyConstants.ACCESS_COOKIE.value,
            );
            final deletedAuthIdString = await secureStorage.read(
              key: SecureStorageAuthKeyConstants.AUTH_ID.value,
            );

            expect(deletedAccessCookie, isNull);
            expect(deletedAuthIdString, isNull);
          });
        },
      );
    },
  );
}

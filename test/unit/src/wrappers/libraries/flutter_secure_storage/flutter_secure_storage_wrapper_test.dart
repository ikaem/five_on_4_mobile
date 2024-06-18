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
        ".storeAccessToken",
        () {
          // should store access token in secure storage

          test(
            "given accessToken argument is provided"
            "when '.storeAccessToken()' is called"
            "then should store accessToken in secure storage",
            () async {
              // setup

              // given
              const accessToken = "accessToken";

              // when
              await secureStorageWrapper.storeAccessToken(accessToken);

              // then
              final storedAccessToken = await secureStorage.read(
                key: SecureStorageAuthKeyConstants.ACCESS_TOKEN.value,
              );

              expect(storedAccessToken, accessToken);

              // cleanup
            },
          );
        },
      );

      group(
        ".getAccessToken",
        () {
          test(
            "given accessToken is stored in secure storage"
            "when '.getAccessToken()' is called"
            "then should return expectedAccessToken",
            () async {
              // setup
              const accessToken = "accessToken";
              // store manually

              // given
              secureStorage.write(
                key: SecureStorageAuthKeyConstants.ACCESS_TOKEN.value,
                value: accessToken,
              );

              // when
              final retrievedAccessToken =
                  await secureStorageWrapper.getAccessToken();

              // then
              expect(retrievedAccessToken, accessToken);

              // cleanup
            },
          );

          test(
            "given accessToken is not stored in secure storage"
            "when '.getAccessToken()' is called"
            "then should return null",
            () async {
              // setup
              // given

              // when
              final retrievedAccessToken =
                  await secureStorageWrapper.getAccessToken();

              // then
              expect(retrievedAccessToken, isNull);

              // cleanup
            },
          );
        },
      );

      group(
        ".clearAccessToken",
        () {
          test(
            "given accessToken is stored in secure storage"
            "when '.clearAccessToken()' is called"
            "then should delete accessToken in secure storage",
            () async {
              // setup

              // given
              await secureStorage.write(
                key: SecureStorageAuthKeyConstants.ACCESS_TOKEN.value,
                value: "accessToken",
              );

              // when
              await secureStorageWrapper.clearAccessToken();

              // then
              final deletedAccessToken = await secureStorage.read(
                key: SecureStorageAuthKeyConstants.ACCESS_TOKEN.value,
              );

              expect(deletedAccessToken, isNull);

              // cleanup
            },
          );
        },
      );

      group(
        ".storeRefreshTokenCookie",
        () {
          // should store refresh token cookie in secure storage

          test(
            "given refreshTokenCookie argument is provided"
            "when '.storeRefreshTokenCookie()' is called"
            "then should store refreshTokenCookie in secure storage",
            () async {
              // setup

              // given
              const refreshTokenCookie = "refreshTokenCookie";

              // when
              await secureStorageWrapper.storeRefreshTokenCookie(
                refreshTokenCookie,
              );

              // then
              final storedRefreshTokenCookie = await secureStorage.read(
                key: SecureStorageAuthKeyConstants.REFRESH_TOKEN_COOKIE.value,
              );

              expect(storedRefreshTokenCookie, refreshTokenCookie);

              // cleanup
            },
          );
        },
      );

      group(
        ".getRefreshTokenCookie",
        () {
          test(
            "given refreshTokenCookie is stored in secure storage"
            "when '.getRefreshTokenCookie()' is called"
            "then should return expectedRefreshTokenCookie",
            () async {
              // setup
              const refreshTokenCookie = "refreshTokenCookie";
              // store manually

              // given
              secureStorage.write(
                key: SecureStorageAuthKeyConstants.REFRESH_TOKEN_COOKIE.value,
                value: refreshTokenCookie,
              );

              // when
              final retrievedRefreshTokenCookie =
                  await secureStorageWrapper.getRefreshTokenCookie();

              // then
              expect(retrievedRefreshTokenCookie, refreshTokenCookie);

              // cleanup
            },
          );

          test(
            "given refreshTokenCookie is not stored in secure storage"
            "when '.getRefreshTokenCookie()' is called"
            "then should return null",
            () async {
              // setup
              // given

              // when
              final retrievedRefreshTokenCookie =
                  await secureStorageWrapper.getRefreshTokenCookie();

              // then
              expect(retrievedRefreshTokenCookie, isNull);

              // cleanup
            },
          );
        },
      );

      group(".clearRefreshTokenCookie", () {
        test(
          "given refreshTokenCookie is stored in secure storage"
          "when '.clearRefreshTokenCookie()' is called"
          "then should delete refreshTokenCookie in secure storage",
          () async {
            // setup

            // given
            await secureStorage.write(
              key: SecureStorageAuthKeyConstants.REFRESH_TOKEN_COOKIE.value,
              value: "refreshTokenCookie",
            );

            // when
            await secureStorageWrapper.clearRefreshTokenCookie();

            // then
            final deletedRefreshTokenCookie = await secureStorage.read(
              key: SecureStorageAuthKeyConstants.REFRESH_TOKEN_COOKIE.value,
            );

            expect(deletedRefreshTokenCookie, isNull);

            // cleanup
          },
        );
      });

      group(
        ".deleteAll",
        () {
          test(
            "given existing data in secure storage"
            "when '.deleteAll()' is called"
            "then should delete all data in secure storage",
            () async {
              // setup

              // given
              await secureStorage.write(
                key: SecureStorageAuthKeyConstants.ACCESS_TOKEN.value,
                value: "accessToken",
              );
              await secureStorage.write(
                key: SecureStorageAuthKeyConstants.REFRESH_TOKEN_COOKIE.value,
                value: "refreshToken",
              );

              // when
              await secureStorageWrapper.deleteAll();

              // then
              final deletedAccessToken = await secureStorage.read(
                key: SecureStorageAuthKeyConstants.ACCESS_TOKEN.value,
              );
              final deletedRefreshTokenCookie = await secureStorage.read(
                key: SecureStorageAuthKeyConstants.REFRESH_TOKEN_COOKIE.value,
              );

              expect(deletedAccessToken, isNull);
              expect(deletedRefreshTokenCookie, isNull);

              // cleanup
            },
          );
        },
      );

      // group(
      //   ".storeAuthId",
      //   () {
      //     test(
      //       "given authId argument is provided"
      //       "when '.storeAuthId()' is called"
      //       "then should store authId in secure storage",
      //       () async {
      //         // setup

      //         // given
      //         const authId = 1;

      //         // when
      //         await secureStorageWrapper.storeAuthId(authId);

      //         // then
      //         final storedAuthIdString = await secureStorage.read(
      //           key: SecureStorageAuthKeyConstants.AUTH_ID.value,
      //         );
      //         final storedAuthId = int.tryParse(storedAuthIdString ?? "");

      //         expect(storedAuthId, authId);

      //         // cleanup
      //       },
      //     );
      //   },
      // );

      // group(
      //   ".getAuthId",
      //   () {
      //     test(
      //       "given authId is stored in secure storage"
      //       "when '.getAuthId()' is called"
      //       "then should return expectedAuthId",
      //       () async {
      //         // setup
      //         const authId = 1;
      //         // store manually

      //         // given
      //         secureStorage.write(
      //           key: SecureStorageAuthKeyConstants.AUTH_ID.value,
      //           value: authId.toString(),
      //         );

      //         // when
      //         final retrievedAuthId = await secureStorageWrapper.getAuthId();

      //         // then
      //         expect(retrievedAuthId, authId);

      //         // cleanup
      //       },
      //     );

      //     test(
      //       "given authId is not stored in secure storage"
      //       "when '.getAuthId()' is called"
      //       "then should return null",
      //       () async {
      //         // setup
      //         // given

      //         // when
      //         final retrievedAuthId = await secureStorageWrapper.getAuthId();

      //         // then
      //         expect(retrievedAuthId, isNull);

      //         // cleanup
      //       },
      //     );
      //   },
      // );

      // group(
      //   ".storeAccessCookie()",
      //   () {
      //     test(
      //       "given accessCookie argument is provided"
      //       "when '.storeAccessCookie()' is called"
      //       "then should store accessCookie in secure storage",
      //       () async {
      //         // setup

      //         // given
      //         const accessCookie = "accessCookie";

      //         // when
      //         await secureStorageWrapper.storeAccessCookie(accessCookie);

      //         // then
      //         final storedAccessCookie = await secureStorage.read(
      //           key: SecureStorageAuthKeyConstants.ACCESS_COOKIE.value,
      //         );

      //         expect(storedAccessCookie, accessCookie);

      //         // cleanup
      //       },
      //     );
      //   },
      // );

      // group(
      //   ".getAccessCookie()",
      //   () {
      //     test(
      //       "given accessCookie is stored in secure storage"
      //       "when '.getAccessCookie()' is called"
      //       "then should return expectedAccessCookie",
      //       () async {
      //         // setup
      //         const accessCookie = "accessCookie";
      //         // store manually

      //         // given
      //         secureStorage.write(
      //           key: SecureStorageAuthKeyConstants.ACCESS_COOKIE.value,
      //           value: accessCookie,
      //         );

      //         // when
      //         final retrievedAccessCookie =
      //             await secureStorageWrapper.getAccessCookie();

      //         // then
      //         expect(retrievedAccessCookie, accessCookie);

      //         // cleanup
      //       },
      //     );

      //     test(
      //       "given accessCookie is not stored in secure storage"
      //       "when '.getAccessCookie()' is called"
      //       "then should return null",
      //       () async {
      //         // setup
      //         // given

      //         // when
      //         final retrievedAccessCookie =
      //             await secureStorageWrapper.getAccessCookie();

      //         // then
      //         expect(retrievedAccessCookie, isNull);

      //         // cleanup
      //       },
      //     );
      //   },
      // );
// TODO not needed
      // group(
      //   ".deleteAuthData()",
      //   () {
      //     test("should delete token and authId from secure storage WHEN called",
      //         () async {
      //       const accessCookie = "accessCookie";
      //       const authId = 1;

      //       await secureStorage.write(
      //         key: SecureStorageAuthKeyConstants.AUTH_ID.value,
      //         value: authId.toString(),
      //       );
      //       await secureStorage.write(
      //         key: SecureStorageAuthKeyConstants.ACCESS_COOKIE.value,
      //         value: accessCookie,
      //       );

      //       await secureStorageWrapper.clearAuthData();

      //       final deletedAccessCookie = await secureStorage.read(
      //         key: SecureStorageAuthKeyConstants.ACCESS_COOKIE.value,
      //       );
      //       final deletedAuthIdString = await secureStorage.read(
      //         key: SecureStorageAuthKeyConstants.AUTH_ID.value,
      //       );

      //       expect(deletedAccessCookie, isNull);
      //       expect(deletedAuthIdString, isNull);
      //     });
      //   },
      // );
    },
  );
}

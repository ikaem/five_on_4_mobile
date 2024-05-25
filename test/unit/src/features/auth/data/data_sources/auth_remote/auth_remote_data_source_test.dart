import 'package:five_on_4_mobile/src/features/auth/data/data_sources/auth_remote/auth_remote_data_source.dart';
import 'package:five_on_4_mobile/src/features/auth/data/data_sources/auth_remote/auth_remote_data_source_impl.dart';
import 'package:five_on_4_mobile/src/features/auth/data/entities/auth_remote/auth_remote_entity.dart';
import 'package:five_on_4_mobile/src/features/auth/utils/constants/http_auth_constants.dart';
import 'package:five_on_4_mobile/src/features/core/domain/values/http_request_value.dart';
import 'package:five_on_4_mobile/src/features/core/utils/constants/http_constants.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/dio/dio_wrapper.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/google_sign_in/google_sign_in_wrapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../../../utils/data/test_entities.dart';

void main() {
  final dioWrapper = _MockDioWrapper();
  final googleSignInWrapper = _MockGoogleSignInWrapper();
  final authRemoteDataSource = AuthRemoteDataSourceImpl(
    googleSignInWrapper: googleSignInWrapper,
    dioWrapper: dioWrapper,
  );

  setUpAll(() {
    registerFallbackValue(_FakeHttpRequestUriPartsValue());
  });

  tearDown(() {
    reset(googleSignInWrapper);
    reset(dioWrapper);
  });

  group(
    "$AuthRemoteDataSource",
    () {
      group(
        ".authenticateWithGoogle()",
        () {
          test(
            "given a valid idToken"
            "when .authenticateWithGoogle() is called"
            "then should return expected result",
            () async {
              // setup
              // TODO move to helpers
              final expectedResult = getTestAuthRemoteEntities(count: 1).first;

              when(() => dioWrapper.post<Map<String, dynamic>>(
                    uriParts: any(named: "uriParts"),
                    bodyData: any(named: "bodyData"),
                  )).thenAnswer((_) async {
                return {
                  "ok": true,
                  "data": expectedResult.toJson(),
                };
              });

              // given
              const idToken = "I am valid";

              // when
              final result =
                  await authRemoteDataSource.authenticateWithGoogle(idToken);

              // then
              expect(result, equals(expectedResult));

              // cleanup
            },
          );

          // TODO validate that expected args are passed to dioWrapper.post
          test(
            "given a valid idToken"
            "when .authenticateWithGoogle() is called"
            "then should call dioWrapper with expected arguments",
            () {
              // setup
              final urilParts = HttpRequestUriPartsValue(
                apiUrlScheme: HttpConstants.HTTPS_PROTOCOL.value,
                apiBaseUrl: HttpConstants.BACKEND_BASE_URL.value,
                apiContextPath: HttpConstants.BACKEND_CONTEXT_PATH.value,
                apiEndpointPath:
                    HttpAuthConstants.BACKEND_ENDPOINT_PATH_AUTH_GOOGLE.value,
                queryParameters: null,
              );

              when(() => dioWrapper.post<Map<String, dynamic>>(
                    uriParts: any(named: "uriParts"),
                    bodyData: any(named: "bodyData"),
                  )).thenAnswer((_) async {
                return {
                  "ok": true,
                  "data": getTestAuthRemoteEntities(count: 1).first.toJson(),
                };
              });

              // given
              const idToken = "I am valid";

              // when
              authRemoteDataSource.authenticateWithGoogle(idToken);

              // then
              verify(() => dioWrapper.post<Map<String, dynamic>>(
                    uriParts: urilParts,
                    bodyData: {
                      "idToken": idToken,
                    },
                  ));

              // cleanup
            },
          );

          test(
            "given a valid idToken"
            "when .authenticateWithGoogle() is called"
            "then should result in jwt token stored in secure storage - this is access token",
            () async {
              // setup
              // TODO interceptor should do this - maybe we just test that it is called or something?

              // TODO also, maybe dont save jwt token in secure storage on each reques
              // maybe just do it when user logs in, then wait until it expires. once it expires, backend will possibly access refresh token
              // it will then
              // 1. send new jwt token in cookie as usual
              // 2. send new refresh token in another cookie?
              // on flutter side, we can check if refresh token exists, and if it does, save that in secure storage on each time it exists?
              // TODO but dont do it for now

              // given

              // when

              // then

              // cleanup
            },
          );

          test(
            "given a valid idToken"
            "when .authenticateWithGoogle() is called"
            "then should result in jwt token stored in secure storage - this is refresh token",
            () async {
              // setup

              // given

              // when

              // then

              // cleanup
            },
          );
        },
      );

      group(
        ".verifyGoogleSignIn()",
        () {
          const idToken = "idToken";

          setUp(() {
            when(() => googleSignInWrapper.signInAndGetIdToken())
                .thenAnswer((_) async => idToken);
          });

          test(
            "given an instance of $AuthRemoteDataSource"
            "when .verifyGoogleSignIn() is called"
            "then should return expected result",
            () async {
              // setup

              // given

              // when
              final result = await authRemoteDataSource.verifyGoogleSignIn();

              // then
              expect(result, equals(idToken));

              // cleanup
            },
          );
        },
      );
    },
  );
}

class _FakeHttpRequestUriPartsValue extends Fake
    implements HttpRequestUriPartsValue {}

class _MockGoogleSignInWrapper extends Mock implements GoogleSignInWrapper {}

class _MockDioWrapper extends Mock implements DioWrapper {}


// TODO plan

/* 
- we have logic to ping google sign in which returns token id to the controller 
- we have logic that that accepts the token id and sends it in a request to the server
- once the response arrives to the app, its business as usual - we get usualy response as with all other login flows















 */
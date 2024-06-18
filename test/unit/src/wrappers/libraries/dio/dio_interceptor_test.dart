import 'dart:io';

import 'package:dio/dio.dart';
import 'package:five_on_4_mobile/src/features/auth/utils/constants/auth_response_constants.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/dio/dio_interceptor.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/flutter_secure_storage/flutter_secure_storage_wrapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  final flutterSecureStorageWrapper = _MockFlutterSecureStorageWrapper();

  final responseHandler = _MockResponseInterceptorHandler();

  // tested class
  final dioInterceptor = DioInterceptor(
    flutterSecureStorageWrapper: flutterSecureStorageWrapper,
  );

  tearDown(() {
    reset(flutterSecureStorageWrapper);
    reset(responseHandler);
  });

  group(
    "$DioInterceptor",
    () {
      // group(
      //   ".onResponse()",
      //   () {

      //     // should store access token in secure storage when response from server contains access token

      //     // should not store access token in secure storage when response from server does not contain access token

      //   },
      // );

      group(".onResponse()", () {
        // should store access token in secure storage when response from server contains access token
        test(
          "given Response coming from server contains access token"
          "when .onResponse() is called"
          "then should store access token in secure storage",
          () async {
            // setup
            const accessToken = "accessToken";

            when(() => flutterSecureStorageWrapper.storeAccessToken(any()))
                .thenAnswer((_) async {});

            // given
            final response = Response(
                requestOptions:
                    RequestOptions(path: "https://www.example.com/"),
                headers: Headers()
                  ..add(
                    AuthResponseConstants.ACCESS_JWT_HEADER_KEY.value,
                    accessToken,
                  )
                // TODO why list here? list is generated with the above too
                // headers: Headers.fromMap(
                //   {
                //     AuthResponseConstants.ACCESS_JWT_HEADER_KEY.value:
                //         "accessToken",
                //   },
                // ),
                );

            // when
            await dioInterceptor.onResponse(
              response,
              responseHandler,
            );

            // then
            verify(() =>
                    flutterSecureStorageWrapper.storeAccessToken(accessToken))
                .called(1);

            print("hello");

            // cleanup
          },
        );

        // should not store access token in secure storage when response from server does not contain access token
        test(
          "given Response coming from server does not contain access token"
          "when .onResponse() is called"
          "then should not store access token in secure storage (not overwrite with null)",
          () async {
            // setup
            // when(() => flutterSecureStorageWrapper.storeAccessToken(any()))
            //     .thenAnswer((_) async {});

            // given
            final response = Response(
              requestOptions: RequestOptions(path: "https://www.example.com/"),
              headers: Headers(),
            );

            // when
            await dioInterceptor.onResponse(
              response,
              responseHandler,
            );

            // then
            verifyNever(
                () => flutterSecureStorageWrapper.storeAccessToken(any()));

            // cleanup
          },
        );

        // should store refresh token cookie in secure storage when response from server contains refresh token cookie
        test(
          "given Response coming from server contains refresh token cookie"
          "when .onResponse() is called"
          "then should store refresh token cookie in secure storage",
          () async {
            // setup
            final testRefreshCookie = Cookie.fromSetCookieValue(
              "refreshToken=token; HttpOnly; Secure; Path=/",
            );

            when(() =>
                    flutterSecureStorageWrapper.storeRefreshTokenCookie(any()))
                .thenAnswer((_) async {});

            // given
            final response = Response(
              requestOptions: RequestOptions(path: "https://www.example.com/"),
              headers: Headers()
                ..add(
                  HttpHeaders.setCookieHeader,
                  testRefreshCookie.toString(),
                ),
            );

            // when
            await dioInterceptor.onResponse(
              response,
              responseHandler,
            );

            // then
            verify(() => flutterSecureStorageWrapper.storeRefreshTokenCookie(
                  testRefreshCookie.toString(),
                )).called(1);

            // cleanup
          },
        );

        // should not store refresh token cookie in secure storage when response from server does not contain refresh token cookie
        test(
          "given <pre-condition to the test>"
          "when <behavior we are specifying>"
          "then should <state we expect to happen>",
          () async {
            // setup
            final someCookie = Cookie.fromSetCookieValue(
              "someCookie=someValue; HttpOnly; Secure; Path=/",
            );

            when(() =>
                    flutterSecureStorageWrapper.storeRefreshTokenCookie(any()))
                .thenAnswer((_) async {});

            // given
            final response = Response(
              requestOptions: RequestOptions(path: "https://www.example.com/"),
              headers: Headers()
                ..add(
                  HttpHeaders.setCookieHeader,
                  someCookie.toString(),
                ),
            );

            // when
            await dioInterceptor.onResponse(
              response,
              responseHandler,
            );

            // then
            verifyNever(
                () => flutterSecureStorageWrapper.storeRefreshTokenCookie(
                      any(),
                    ));

            // cleanup
          },
        );

        // should delete access token from secure storage when response coming from logout endpoint
        test(
          "given response is coming from logout endpoint"
          "when .onResponse() is called"
          "then should delete access token from secure storage",
          () async {
            // setup
            when(() => flutterSecureStorageWrapper.clearAccessToken())
                .thenAnswer((_) async {});
            when(() => flutterSecureStorageWrapper.clearRefreshTokenCookie())
                .thenAnswer((_) async {});

            // given
            final response = Response(
              requestOptions:
                  RequestOptions(path: "https://www.example.com/auth/logout"),
              headers: Headers(),
            );

            // when
            await dioInterceptor.onResponse(
              response,
              responseHandler,
            );

            // then
            verify(() => flutterSecureStorageWrapper.clearAccessToken())
                .called(1);

            // cleanup
          },
        );

        // should NOT delete access token from secure storage when response coming from non-logout endpoint
        test(
          "given response is coming from non-logout endpoint"
          "when .onResponse() is called"
          "then should NOT delete access token from secure storage",
          () async {
            // setup
            when(() => flutterSecureStorageWrapper.clearAccessToken())
                .thenAnswer((_) async {});
            when(() => flutterSecureStorageWrapper.clearRefreshTokenCookie())
                .thenAnswer((_) async {});

            // given
            final response = Response(
              requestOptions: RequestOptions(path: "https://www.example.com/"),
              headers: Headers(),
            );

            // when
            await dioInterceptor.onResponse(
              response,
              responseHandler,
            );

            // then
            verifyNever(() => flutterSecureStorageWrapper.clearAccessToken());

            // cleanup
          },
        );

        // should delete refresh token cookie from secure storage when response coming from logout endpoint
        test(
          "given response is coming from logout endpoint"
          "when .onResponse() is called"
          "then should delete refresh token cookie from secure storage",
          () async {
            // setup
            when(() => flutterSecureStorageWrapper.clearAccessToken())
                .thenAnswer((_) async {});
            when(() => flutterSecureStorageWrapper.clearRefreshTokenCookie())
                .thenAnswer((_) async {});

            // given
            final response = Response(
              requestOptions:
                  RequestOptions(path: "https://www.example.com/auth/logout"),
              headers: Headers(),
            );

            // when
            await dioInterceptor.onResponse(
              response,
              responseHandler,
            );

            // then
            verify(() => flutterSecureStorageWrapper.clearRefreshTokenCookie())
                .called(1);

            // cleanup
          },
        );

        // should NOT delete refresh token cookie from secure storage when response coming from non-logout endpoint
        test(
          "given response is coming from non-logout endpoint"
          "when .onResponse() is called"
          "then should NOT delete refresh token cookie from secure storage",
          () async {
            // setup
            when(() => flutterSecureStorageWrapper.clearAccessToken())
                .thenAnswer((_) async {});
            when(() => flutterSecureStorageWrapper.clearRefreshTokenCookie())
                .thenAnswer((_) async {});

            // given
            final response = Response(
              requestOptions: RequestOptions(path: "https://www.example.com/"),
              headers: Headers(),
            );

            // when
            await dioInterceptor.onResponse(
              response,
              responseHandler,
            );

            // then
            verifyNever(
                () => flutterSecureStorageWrapper.clearRefreshTokenCookie());

            // cleanup
          },
        );
      });
    },
  );
}

class _MockFlutterSecureStorageWrapper extends Mock
    implements FlutterSecureStorageWrapper {}

class _MockResponseInterceptorHandler extends Mock
    implements ResponseInterceptorHandler {}







// TODO old




// TODO come back to this
// import 'dart:io';

// import 'package:dio/dio.dart';
// import 'package:five_on_4_mobile/src/features/auth/utils/constants/auth_response_constants.dart';
// import 'package:five_on_4_mobile/src/wrappers/libraries/dio/dio_interceptor.dart';
// import 'package:five_on_4_mobile/src/wrappers/libraries/flutter_secure_storage/flutter_secure_storage_wrapper.dart';
// import 'package:five_on_4_mobile/src/wrappers/local/cookies_handler/cookies_handler_wrapper.dart';
// import 'package:five_on_4_mobile/src/wrappers/local/env_vars_wrapper.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';

// void main() {
//   // dependencies
//   final envVarsWrapper = _MockEnvVarsWrapper();
//   final cookiesHandlerWrapper = _MockCookiesHandlerWrapper();
//   final flutterSecureStorageWrapper = _MockFlutterSecureStorageWrapper();

//   // handlers
//   final requestHandler = _MockRequestInterceptorHandler();
//   final responseHandler = _MockResponseInterceptorHandler();

//   final dioInterceptor = DioInterceptor(
//     envVarsWrapper: envVarsWrapper,
//     cookiesHandlerWrapper: cookiesHandlerWrapper,
//     flutterSecureStorageWrapper: flutterSecureStorageWrapper,
//   );

//   setUpAll(() {
//     registerFallbackValue(_FakeRequestOptions());
//   });

//   tearDown(() {
//     reset(envVarsWrapper);
//     reset(cookiesHandlerWrapper);
//     reset(flutterSecureStorageWrapper);
//     reset(requestHandler);
//     reset(responseHandler);
//   });

//   group(
//     "$DioInterceptor",
//     () {
//       group(
//         ".onRequest()",
//         () {
//           // TODO test when going to refresh token endpoint, should include refresh token cookie in request
//           test(
//             "given RequestOptions and access token is stored in secure storage"
//             "when .onRequest() is called"
//             "then should include accessToken in RequestOptions' authorization header passed to RequestInterceptorHandler",
//             () async {
//               // setup
//               const accessToken = "accessToken";

//               // given
//               final requestOptions = RequestOptions(
//                 path: "https://www.example.com/",
//               );
//               when(() => flutterSecureStorageWrapper.getAccessToken())
//                   .thenAnswer((_) async => accessToken);

//               // when
//               await dioInterceptor.onRequest(
//                 requestOptions,
//                 requestHandler,
//               );

//               // then
//               final captured =
//                   verify(() => requestHandler.next(captureAny())).captured;
//               final actualRequestOptions = captured[0] as RequestOptions;
//               final actualAuthorizationHeader =
//                   actualRequestOptions.headers[HttpHeaders.authorizationHeader];

//               expect(actualAuthorizationHeader, equals("Bearer $accessToken"));

//               // cleanup
//             },
//           );

//           /* should include null access token in authorization header */
//           test(
//             "given RequestOptions and access token is not stored in secure storage"
//             "when .onRequest() is called"
//             "then should not include accessToken in RequestOptions' authorization header passed to RequestInterceptorHandler",
//             () async {
//               // setup

//               // given
//               final requestOptions = RequestOptions(
//                 path: "https://www.example.com/",
//               );
//               when(() => flutterSecureStorageWrapper.getAccessToken())
//                   .thenAnswer((_) async => null);

//               // when
//               await dioInterceptor.onRequest(
//                 requestOptions,
//                 requestHandler,
//               );

//               // then
//               final captured =
//                   verify(() => requestHandler.next(captureAny())).captured;
//               final actualRequestOptions = captured[0] as RequestOptions;
//               final actualAuthorizationHeader =
//                   actualRequestOptions.headers[HttpHeaders.authorizationHeader];

//               expect(actualAuthorizationHeader, isNull);

//               // cleanup
//             },
//           );
//         },
//       );

//       group(".onResponse()", () {
//         // should store access token in secure storage when response from server contains access token
//         test(
//           "given Response coming from server contains access token"
//           "when .onResponse() is called"
//           "then should store access token in secure storage",
//           () async {
//             // setup
//             const accessToken = "accessToken";

//             when(() => flutterSecureStorageWrapper.storeAccessToken(any()))
//                 .thenAnswer((_) async {});

//             // given
//             final response = Response(
//                 requestOptions:
//                     RequestOptions(path: "https://www.example.com/"),
//                 headers: Headers()
//                   ..add(
//                     AuthResponseConstants.ACCESS_JWT_HEADER_KEY.value,
//                     accessToken,
//                   )
//                 // TODO why list here? list is generated with the above too
//                 // headers: Headers.fromMap(
//                 //   {
//                 //     AuthResponseConstants.ACCESS_JWT_HEADER_KEY.value:
//                 //         "accessToken",
//                 //   },
//                 // ),
//                 );

//             // when
//             await dioInterceptor.onResponse(
//               response,
//               responseHandler,
//             );

//             // then
//             verify(() =>
//                     flutterSecureStorageWrapper.storeAccessToken(accessToken))
//                 .called(1);

//             print("hello");

//             // cleanup
//           },
//         );

//         // should not store access token in secure storage when response from server does not contain access token
//         test(
//           "given Response coming from server does not contain access token"
//           "when .onResponse() is called"
//           "then should not store access token in secure storage (not overwrite with null)",
//           () async {
//             // setup
//             // when(() => flutterSecureStorageWrapper.storeAccessToken(any()))
//             //     .thenAnswer((_) async {});

//             // given
//             final response = Response(
//               requestOptions: RequestOptions(path: "https://www.example.com/"),
//               headers: Headers(),
//             );

//             // when
//             await dioInterceptor.onResponse(
//               response,
//               responseHandler,
//             );

//             // then
//             verifyNever(
//                 () => flutterSecureStorageWrapper.storeAccessToken(any()));

//             // cleanup
//           },
//         );

//         // should store refresh token cookie in secure storage when response from server contains refresh token cookie
//         test(
//           "given Response coming from server contains refresh token cookie"
//           "when .onResponse() is called"
//           "then should store refresh token cookie in secure storage",
//           () async {
//             // setup
//             final testRefreshCookie = Cookie.fromSetCookieValue(
//               "refreshToken=token; HttpOnly; Secure; Path=/",
//             );

//             when(() =>
//                     flutterSecureStorageWrapper.storeRefreshTokenCookie(any()))
//                 .thenAnswer((_) async {});

//             // given
//             final response = Response(
//               requestOptions: RequestOptions(path: "https://www.example.com/"),
//               headers: Headers()
//                 ..add(
//                   HttpHeaders.setCookieHeader,
//                   testRefreshCookie.toString(),
//                 ),
//             );

//             // when
//             await dioInterceptor.onResponse(
//               response,
//               responseHandler,
//             );

//             // then
//             verify(() => flutterSecureStorageWrapper.storeRefreshTokenCookie(
//                   testRefreshCookie.toString(),
//                 )).called(1);

//             // cleanup
//           },
//         );

//         // should not store refresh token cookie in secure storage when response from server does not contain refresh token cookie
//         test(
//           "given <pre-condition to the test>"
//           "when <behavior we are specifying>"
//           "then should <state we expect to happen>",
//           () async {
//             // setup
//             final someCookie = Cookie.fromSetCookieValue(
//               "someCookie=someValue; HttpOnly; Secure; Path=/",
//             );

//             when(() =>
//                     flutterSecureStorageWrapper.storeRefreshTokenCookie(any()))
//                 .thenAnswer((_) async {});

//             // given
//             final response = Response(
//               requestOptions: RequestOptions(path: "https://www.example.com/"),
//               headers: Headers()
//                 ..add(
//                   HttpHeaders.setCookieHeader,
//                   someCookie.toString(),
//                 ),
//             );

//             // when
//             await dioInterceptor.onResponse(
//               response,
//               responseHandler,
//             );

//             // then
//             verifyNever(
//                 () => flutterSecureStorageWrapper.storeRefreshTokenCookie(
//                       any(),
//                     ));

//             // cleanup
//           },
//         );

//         // should delete access token from secure storage when response coming from logout endpoint
//         test(
//           "given response is coming from logout endpoint"
//           "when .onResponse() is called"
//           "then should delete access token from secure storage",
//           () async {
//             // setup
//             when(() => flutterSecureStorageWrapper.clearAccessToken())
//                 .thenAnswer((_) async {});
//             when(() => flutterSecureStorageWrapper.clearRefreshTokenCookie())
//                 .thenAnswer((_) async {});

//             // given
//             final response = Response(
//               requestOptions:
//                   RequestOptions(path: "https://www.example.com/auth/logout"),
//               headers: Headers(),
//             );

//             // when
//             await dioInterceptor.onResponse(
//               response,
//               responseHandler,
//             );

//             // then
//             verify(() => flutterSecureStorageWrapper.clearAccessToken())
//                 .called(1);

//             // cleanup
//           },
//         );

//         // should NOT delete access token from secure storage when response coming from non-logout endpoint
//         test(
//           "given response is coming from non-logout endpoint"
//           "when .onResponse() is called"
//           "then should NOT delete access token from secure storage",
//           () async {
//             // setup
//             when(() => flutterSecureStorageWrapper.clearAccessToken())
//                 .thenAnswer((_) async {});
//             when(() => flutterSecureStorageWrapper.clearRefreshTokenCookie())
//                 .thenAnswer((_) async {});

//             // given
//             final response = Response(
//               requestOptions: RequestOptions(path: "https://www.example.com/"),
//               headers: Headers(),
//             );

//             // when
//             await dioInterceptor.onResponse(
//               response,
//               responseHandler,
//             );

//             // then
//             verifyNever(() => flutterSecureStorageWrapper.clearAccessToken());

//             // cleanup
//           },
//         );

//         // should delete refresh token cookie from secure storage when response coming from logout endpoint
//         test(
//           "given response is coming from logout endpoint"
//           "when .onResponse() is called"
//           "then should delete refresh token cookie from secure storage",
//           () async {
//             // setup
//             when(() => flutterSecureStorageWrapper.clearAccessToken())
//                 .thenAnswer((_) async {});
//             when(() => flutterSecureStorageWrapper.clearRefreshTokenCookie())
//                 .thenAnswer((_) async {});

//             // given
//             final response = Response(
//               requestOptions:
//                   RequestOptions(path: "https://www.example.com/auth/logout"),
//               headers: Headers(),
//             );

//             // when
//             await dioInterceptor.onResponse(
//               response,
//               responseHandler,
//             );

//             // then
//             verify(() => flutterSecureStorageWrapper.clearRefreshTokenCookie())
//                 .called(1);

//             // cleanup
//           },
//         );

//         // should NOT delete refresh token cookie from secure storage when response coming from non-logout endpoint
//         test(
//           "given response is coming from non-logout endpoint"
//           "when .onResponse() is called"
//           "then should NOT delete refresh token cookie from secure storage",
//           () async {
//             // setup
//             when(() => flutterSecureStorageWrapper.clearAccessToken())
//                 .thenAnswer((_) async {});
//             when(() => flutterSecureStorageWrapper.clearRefreshTokenCookie())
//                 .thenAnswer((_) async {});

//             // given
//             final response = Response(
//               requestOptions: RequestOptions(path: "https://www.example.com/"),
//               headers: Headers(),
//             );

//             // when
//             await dioInterceptor.onResponse(
//               response,
//               responseHandler,
//             );

//             // then
//             verifyNever(
//                 () => flutterSecureStorageWrapper.clearRefreshTokenCookie());

//             // cleanup
//           },
//         );
//       });
//     },
//   );
// }

// class _MockEnvVarsWrapper extends Mock implements EnvVarsWrapper {}

// class _MockCookiesHandlerWrapper extends Mock
//     implements CookiesHandlerWrapper {}

// class _MockFlutterSecureStorageWrapper extends Mock
//     implements FlutterSecureStorageWrapper {}

// class _MockRequestInterceptorHandler extends Mock
//     implements RequestInterceptorHandler {}

// class _MockResponseInterceptorHandler extends Mock
//     implements ResponseInterceptorHandler {}

// class _FakeRequestOptions extends Fake implements RequestOptions {}

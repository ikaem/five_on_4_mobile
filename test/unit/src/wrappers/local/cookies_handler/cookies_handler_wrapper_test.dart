import 'package:dio/dio.dart';
import 'package:five_on_4_mobile/src/wrappers/local/cookies_handler/cookies_handler_wrapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  final cookiesHandlerWrapper = CookiesHandlerWrapper();
  group('$CookiesHandlerWrapper', () {
    group(".handleRequestCookie", () {
      test(
        "given no cookies are found in the headers"
        "when handleRequestCookie() is called"
        "then should return false",
        () async {
          // setup
          final headers = Headers();
          headers.add("nothing", "no");

          // when
          final isSuccess =
              await cookiesHandlerWrapper.handleFoundRequestCookie(
            headers: headers,
            cookieName: "someCookie",
            onCookieFound: (String cookie) async {},
          );

          // then
          expect(isSuccess, equals(false));
        },
      );
      test(
        "given a cookie with provided cookie name is not found"
        "when handleFoundRequestCookie() is called"
        "then should return false",
        () async {
          // setup
          final headers = Headers();
          headers.add("set-cookie", "random=someValue; HttpOnly; Secure");

          // given
          const nonExistingCookie = "notExistingCookie";

          // when
          final isSuccess =
              await cookiesHandlerWrapper.handleFoundRequestCookie(
            headers: headers,
            cookieName: nonExistingCookie,
            onCookieFound: (String cookie) async {},
          );

          // then
          expect(isSuccess, equals(false));
        },
      );

      test(
        "given a cookie with provided cookie name is not found"
        "when handleFoundRequestCookie() is called"
        "then should not call the provided onCookieFound() callback",
        () async {
          // setup
          final headers = Headers();
          headers.add("nothing", "no");
          headers.add("set-cookie", "random=someValue; HttpOnly; Secure");

          final onCookieFoundCallback = _OnCookieFoundCallback();

          when(() => onCookieFoundCallback(any())).thenAnswer((_) async {});

          // given
          const nonExistingCookie = "notExistingCookie";

          // when
          await cookiesHandlerWrapper.handleFoundRequestCookie(
            headers: headers,
            cookieName: nonExistingCookie,
            onCookieFound: onCookieFoundCallback,
          );

          // then
          verifyNever(() => onCookieFoundCallback(any()));
        },
      );

      test(
        "given a cookie with provided cookie name exists in the headers"
        "when handleFoundRequestCookie() is called"
        "then should return true",
        () async {
          // setup
          const existingCookieName = "existingCookie";
          final headers = Headers();

          headers.add(
              "set-cookie", "$existingCookieName=someValue; HttpOnly; Secure");

          // when
          final isSuccess =
              await cookiesHandlerWrapper.handleFoundRequestCookie(
            headers: headers,
            cookieName: existingCookieName,
            onCookieFound: (String cookie) async {},
          );

          // then
          expect(isSuccess, equals(true));
        },
      );

      test(
        "given a cookie with provided cookie name exists in the headers"
        "when handleFoundRequestCookie() is called"
        "then should call the provided onCookieFound() callback",
        () async {
          // setup
          const existingCookieName = "existingCookie";
          const cookieString =
              "$existingCookieName=someValue; Max-Age=1200; Secure; HttpOnly";

          final headers = Headers();

          final onCookieFoundCallback = _OnCookieFoundCallback();
          when(() => onCookieFoundCallback(any())).thenAnswer((_) async {});

          // given
          headers.add("set-cookie", cookieString);

          // when
          await cookiesHandlerWrapper.handleFoundRequestCookie(
            headers: headers,
            cookieName: existingCookieName,
            // onCookieFound: (String cookie) async {},
            onCookieFound: onCookieFoundCallback,
          );

          // then
          verify(() => onCookieFoundCallback(cookieString)).called(1);
        },
      );

      test(
        "given the provided onCookieFound() callback throws an error"
        "when handleFoundRequestCookie() is called"
        "then should return false",
        () async {
          // setup
          const existingCookieName = "existingCookie";
          const cookieString =
              "$existingCookieName=someValue; Max-Age=1200; Secure; HttpOnly";

          final headers = Headers();
          headers.add("set-cookie", cookieString);

          final onCookieFoundCallback = _OnCookieFoundCallback();

          // given
          when(() => onCookieFoundCallback(any())).thenThrow(Exception());

          // when
          final isSuccess =
              await cookiesHandlerWrapper.handleFoundRequestCookie(
            headers: headers,
            cookieName: existingCookieName,
            onCookieFound: onCookieFoundCallback,
          );

          // then
          expect(isSuccess, equals(false));
        },
      );
    });
  });
}

class _OnCookieFoundCallback extends Mock {
  // TODO this cannot have implementation when mock
  Future<void> call(String cookie);
  // void call(String cookie);
}

// class _MockOnChangedCallbackWrapper extends Mock {
//   void call(String value);
// }

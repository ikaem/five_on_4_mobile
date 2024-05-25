import 'dart:io';

import 'package:dio/dio.dart';
import 'package:five_on_4_mobile/src/wrappers/local/cookies_handler/cookies_handler_wrapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  const cookiesHandlerWrapper = CookiesHandlerWrapper();

  group('$CookiesHandlerWrapper', () {
    group(
      ".getRequestOptionsWithCookieInHeaders()",
      () {
        final getCookie = _GetCookieCallbackWrapper();

        late RequestOptions options;

        setUp(() {
          options = RequestOptions(
            path: "/",
            method: "GET",
          );
        });
        // should call getCookie() callback
        test(
          "given .getCookie() callback is provided"
          "when .getRequestOptionsWithCookieInHeaders() is called "
          "then call getCookie() callback",
          () {
            // setup

            // given
            when(() => getCookie()).thenAnswer((_) async => "cookie");

            // when
            cookiesHandlerWrapper.getRequestOptionsWithCookieInHeaders(
              requestOptions: options,
              getCookie: getCookie,
            );

            // then
            verify(() => getCookie()).called(1);

            // cleanup
          },
        );

        // if no cookie is retrieved, should return same request options
        test(
          "given .getCookie() callback returns null"
          "when .getRequestOptionsWithCookieInHeaders() is called "
          "then should return provided RequestOptions",
          () async {
            // setup

            // given
            when(() => getCookie()).thenAnswer((_) async => null);

            // when
            final result = await cookiesHandlerWrapper
                .getRequestOptionsWithCookieInHeaders(
              requestOptions: options,
              getCookie: getCookie,
            );

            // then
            expect(result, equals(options));

            // cleanup
          },
        );

        // if error when retrieving cookie, should log something - not sure how to test this
        // if error when retrieving cookie, should return same request options
        test(
          "given .getCookie() callback throws"
          "when .getRequestOptionsWithCookieInHeaders() is called "
          "then should return provided RequestOptions",
          () async {
            // setup

            // given
            when(() => getCookie()).thenThrow(Exception());

            // when
            final result = await cookiesHandlerWrapper
                .getRequestOptionsWithCookieInHeaders(
              requestOptions: options,
              getCookie: getCookie,
            );

            // then
            expect(result, equals(options));

            // cleanup
          },
        );

        // if invalid cookie is retrieved, should return same request options

        // if valid cookie is retrieved, and no cookies in options, should return options with this only cookie

        // if valid cookie is retrieved, and cookies in options, should return options with this cookie added to the list

        // if valid cookie is retrieved, and cookies in options, and this cookie is already in the list, should return options with updated cookie added to the list

        // if valid cookie is retrieved, and invalid cookies in options, should return options with this cookie added to the list and all invalid cookies removed

        // if valid cookie, should always return different instance of options
      },
    );

    group(
      ".handleStoreResponseCookie",
      () {},
    );
  });
}

class _StoreCookieCallbackWrapper extends Mock {
  Future<void> call(String cookie);
}

class _GetCookieCallbackWrapper extends Mock {
  Future<String?> call();
}

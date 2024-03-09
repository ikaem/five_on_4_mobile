// TODO sourcing intercepotor solution form here
// https://dhruvnakum.xyz/networking-in-flutter-interceptors

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:five_on_4_mobile/src/features/core/utils/constants/http_constants.dart';
import 'package:five_on_4_mobile/src/wrappers/local/env_vars_wrapper.dart';

// TODO cookies as per https://stackoverflow.com/a/77069921

// TODO as per https://medium.com/readytowork-org/dio-interceptors-in-flutter-e813f08c2017

// TODO could possibly create interceptor logic that would redirect requests to local server

class DioInterceptor extends Interceptor {
  const DioInterceptor({
    required EnvVarsWrapper envVarsWrapper,
  }) : _envVarsWrapper = envVarsWrapper;

  final EnvVarsWrapper _envVarsWrapper;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    //
    final requestApiAuthority = options.uri.authority;
    final shouldRedirectToLocalApi =
        requestApiAuthority == HttpConstants.BACKEND_BASE_URL.value &&
            _envVarsWrapper.shouldUseLocalServer;
    if (shouldRedirectToLocalApi) {
      final localApiOptions = _getRedirectToLocalApiOptions(options: options);

      handler.next(localApiOptions);
      return;
    }

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // final headers = response.headers.value("set-cookie");

    // const cookie = Cookie

    // TODO extract to function
    // TODO make sure that if no cookies are included, this still passes

    Map<String, Cookie> cookies = {};

    final rawCookiesString = response.headers.value("set-cookie") ?? "";
    // TODO make sure to use that regex
    final regex = RegExp('(?:[^,]|, )+');

    Iterable<Match> rawCookies = regex.allMatches(rawCookiesString).toList();
    final firstRawCookie = rawCookies.first;
    // this will be entire match - the actual cookie string
    final matchedGroup = firstRawCookie.group(0)!;

// TODO this could throw if invalid cookie or something - handle it in try
    final cookie = Cookie.fromSetCookieValue(matchedGroup);

    final cookieName = cookie.name;
    final cookieValue = cookie.value;

    // TODO this should be added to secure storage
    final cookieString = cookie.toString();

    cookies[cookieName] = cookie;

    // test
    // TODO: implement onResponse
    // super.onResponse(response, handler);
    // TODO this if this is last in chain
    handler.resolve(response);
    // handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // TODO we can reuse this to send for refresh token in future if we get 401, and then possibly retry the request
    // TODO: implement onError
    // super.onError(err, handler);
    handler.next(err);
  }
}

RequestOptions _getRedirectToLocalApiOptions({
  required RequestOptions options,
}) {
  const localApiPath = "http://10.0.2.2:4000";

  final localApiOptions = options.copyWith(
    path: localApiPath + options.uri.path,
  );

  return localApiOptions;
}

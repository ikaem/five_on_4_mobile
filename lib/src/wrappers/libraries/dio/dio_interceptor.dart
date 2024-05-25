// TODO sourcing intercepotor solution form here
// https://dhruvnakum.xyz/networking-in-flutter-interceptors

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:five_on_4_mobile/src/features/core/utils/constants/http_constants.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/flutter_secure_storage/flutter_secure_storage_wrapper.dart';
import 'package:five_on_4_mobile/src/wrappers/local/cookies_handler/cookies_handler_wrapper.dart';
import 'package:five_on_4_mobile/src/wrappers/local/env_vars_wrapper.dart';

// TODO cookies as per https://stackoverflow.com/a/77069921

// TODO as per https://medium.com/readytowork-org/dio-interceptors-in-flutter-e813f08c2017

// TODO could possibly create interceptor logic that would redirect requests to local server

class DioInterceptor extends Interceptor {
  const DioInterceptor({
    required EnvVarsWrapper envVarsWrapper,
    required CookiesHandlerWrapper cookiesHandlerWrapper,
    required FlutterSecureStorageWrapper flutterSecureStorageWrapper,
  })  : _envVarsWrapper = envVarsWrapper,
        _cookiesHandlerWrapper = cookiesHandlerWrapper,
        _flutterSecureStorageWrapper = flutterSecureStorageWrapper;

  final EnvVarsWrapper _envVarsWrapper;
  final CookiesHandlerWrapper _cookiesHandlerWrapper;
  final FlutterSecureStorageWrapper _flutterSecureStorageWrapper;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final requestOptionsWithUpdatedCookies =
        await _cookiesHandlerWrapper.getRequestOptionsWithCookieInHeaders(
      requestOptions: options,
      getCookie: () => _flutterSecureStorageWrapper.getAccessCookie(),
    );

    final optionsWithRedirectedApi = _getApiRedirectedOptions(
      options: requestOptionsWithUpdatedCookies,
      shouldUseLocalServer: _envVarsWrapper.shouldUseLocalServer,
    );

    final previousCookie = optionsWithRedirectedApi.headers["cookie"];

    // TODO test only
    // optionsWithRedirectedApi.headers["cookie"] =
    //     "jwt_token=someValue; HttpOnly; Secure";

    return handler.next(optionsWithRedirectedApi);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    final isAccessTokenStored =
        await _cookiesHandlerWrapper.handleStoreResponseCookie(
      response: response,
      // TODO store it somewhere as constant
      cookieName: "jwt_token",
      storeCookie: _flutterSecureStorageWrapper.storeAccessCookie,
    );

    if (!isAccessTokenStored) {
      // TODO log this
    }
    // final headers = response.headers.value("set-cookie");

    // const cookie = Cookie

    // TODO extract to function
    // TODO make sure that if no cookies are included, this still passes

//     Map<String, Cookie> cookies = {};

//     final rawCookiesString = response.headers.value("set-cookie") ?? "";
//     // TODO make sure to use that regex
//     final regex = RegExp('(?:[^,]|, )+');

//     Iterable<Match> rawCookies = regex.allMatches(rawCookiesString).toList();
//     final firstRawCookie = rawCookies.first;
//     // this will be entire match - the actual cookie string
//     final matchedGroup = firstRawCookie.group(0)!;

// // TODO this could throw if invalid cookie or something - handle it in try
//     final cookie = Cookie.fromSetCookieValue(matchedGroup);

//     final cookieName = cookie.name;
//     final cookieValue = cookie.value;

//     // TODO this should be added to secure storage
//     final cookieString = cookie.toString();

//     cookies[cookieName] = cookie;

    // test
    // TODO: implement onResponse
    // super.onResponse(response, handler);
    // TODO this if this is last in chain

    // final cookies = response.headers.value("set-cookie");
    // final what = response.headers.map;

    // final cookies = response.headers["set-cookie"];

    // for (final key in what.keys) {
    //   print("key: $key, value: ${what[key]}");
    // }

    // const cookiesHandlerWrapper = CookiesHandlerWrapper();
    // final cookies =
    //     cookiesHandlerWrapper.getCookiesFromResponse(response: response);

    return handler.resolve(response);
    // handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // TODO we can reuse this to send for refresh token in future if we get 401, and then possibly retry the request
    // TODO: implement onError
    // super.onError(err, handler);
    handler.next(err);
  }

  RequestOptions _getApiRedirectedOptions({
    required RequestOptions options,
    required bool shouldUseLocalServer,
  }) {
    final requestApiAuthority = options.uri.authority;
    final shouldRedirectToLocalApi =
        requestApiAuthority == HttpConstants.BACKEND_BASE_URL.value &&
            shouldUseLocalServer;

    if (!shouldRedirectToLocalApi) {
      return options;
    }

    final localApiOptions = _getRedirectToLocalApiOptions(options: options);
    return localApiOptions;
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
}

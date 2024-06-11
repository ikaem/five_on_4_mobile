// TODO sourcing intercepotor solution form here
// https://dhruvnakum.xyz/networking-in-flutter-interceptors

import 'package:dio/dio.dart';

class DioInterceptor extends Interceptor {
  const DioInterceptor();

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    return handler.next(options);
    // TODO this is also legit , it would be the same
    // super.onRequest(requestOptionsWithUpatedAuthHeader, handler);
  }

  @override
  Future<void> onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    return handler.resolve(response);
    // TODO this is also legit , it would be the same
    // super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // TODO test all of these
    // handler.resolve(err.response!);
    // handler.next(err);

    // TODO this is also legit , it would be the same
    super.onError(err, handler);
  }
}









// OLD TODO come back to this


// // TODO sourcing intercepotor solution form here
// // https://dhruvnakum.xyz/networking-in-flutter-interceptors

// import 'dart:developer';
// import 'dart:io';

// import 'package:dio/dio.dart';
// import 'package:five_on_4_mobile/src/features/auth/utils/constants/auth_response_constants.dart';
// import 'package:five_on_4_mobile/src/features/auth/utils/constants/http_auth_constants.dart';
// import 'package:five_on_4_mobile/src/wrappers/libraries/flutter_secure_storage/flutter_secure_storage_wrapper.dart';
// import 'package:five_on_4_mobile/src/wrappers/local/cookies_handler/cookies_handler_wrapper.dart';
// import 'package:five_on_4_mobile/src/wrappers/local/env_vars_wrapper.dart';

// // TODO cookies as per https://stackoverflow.com/a/77069921

// // TODO as per https://medium.com/readytowork-org/dio-interceptors-in-flutter-e813f08c2017

// // TODO could possibly create interceptor logic that would redirect requests to local server

// class DioInterceptor extends Interceptor {
//   const DioInterceptor({
//     required EnvVarsWrapper envVarsWrapper,
//     required CookiesHandlerWrapper cookiesHandlerWrapper,
//     required FlutterSecureStorageWrapper flutterSecureStorageWrapper,
//   })  : _envVarsWrapper = envVarsWrapper,
//         _cookiesHandlerWrapper = cookiesHandlerWrapper,
//         _flutterSecureStorageWrapper = flutterSecureStorageWrapper;

//   final EnvVarsWrapper _envVarsWrapper;
//   final CookiesHandlerWrapper _cookiesHandlerWrapper;
//   final FlutterSecureStorageWrapper _flutterSecureStorageWrapper;

//   @override
//   Future<void> onRequest(
//       RequestOptions options, RequestInterceptorHandler handler) async {
//     final accessToken = await _flutterSecureStorageWrapper.getAccessToken();

//     final requestOptionsWithUpatedAuthHeader =
//         _getRequestOptionsWithUpdatedAuthHeader(options, accessToken);

//     return handler.next(requestOptionsWithUpatedAuthHeader);
//     // TODO this is also legit , it would be the same
//     // super.onRequest(requestOptionsWithUpatedAuthHeader, handler);
//   }

//   RequestOptions _getRequestOptionsWithUpdatedAuthHeader(
//     RequestOptions options,
//     String? accessToken,
//   ) {
//     final requestOptionsWithUpatedAuthHeader =
//         options.copyWith(headers: <String, dynamic>{
//       ...options.headers,
//       if (accessToken != null)
//         HttpHeaders.authorizationHeader: "Bearer $accessToken",
//     });
//     return requestOptionsWithUpatedAuthHeader;
//   }

//   @override
//   Future<void> onResponse(
//       Response response, ResponseInterceptorHandler handler) async {
//     final requestUriPath = response.requestOptions.uri.path;

//     final isLogoutRequest =
//         requestUriPath == HttpAuthConstants.BACKEND_ENDPOINT_PATH_LOGOUT.value;
//     if (isLogoutRequest) {
//       return await _handleLogoutResponse(handler, response);
//     }

//     final accessToken = response.headers
//         .value(AuthResponseConstants.ACCESS_JWT_HEADER_KEY.value);
//     if (accessToken != null) {
//       await _handleStoreAccessTokenFromResponse(accessToken);
//     }

//     // TODO for now we know we will get only one cookie
//     // TODO do research how to split the string of cookins coming from backend to be able to handle multiple cookies
//     final cookiesString = response.headers.value(HttpHeaders.setCookieHeader);
//     if (cookiesString != null) {
//       await _handleStoreRefreshTokenCookieFromResponse(cookiesString);
//     }

//     return handler.resolve(response);
//     // TODO this is ok too - it works
//     // super.onResponse(response, handler);
//   }

//   Future<void> _handleStoreRefreshTokenCookieFromResponse(
//       String cookiesString) async {
//     try {
//       // TODO this parses the cookie string into a cookie object - only the cookie that is from set-cookie header
//       // it means it will have all values
//       // TODO delegate this to cookies handler
//       final cookie = Cookie.fromSetCookieValue(cookiesString);
//       if (cookie.name != "refreshToken") return;

//       final cookieString = cookie.toString();
//       await _flutterSecureStorageWrapper.storeRefreshTokenCookie(cookieString);
//     } catch (e) {
//       // TODO log this
//       log("Error parsing cookie string: $e");
//     }
//   }

//   Future<void> _handleStoreAccessTokenFromResponse(String accessToken) async {
//     await _flutterSecureStorageWrapper.storeAccessToken(accessToken);
//   }

//   Future<void> _handleLogoutResponse(
//     ResponseInterceptorHandler handler,
//     Response<dynamic> response,
//   ) async {
//     await _flutterSecureStorageWrapper.clearAccessToken();
//     await _flutterSecureStorageWrapper.clearRefreshTokenCookie();

//     return handler.resolve(response);
//   }

//   @override
//   void onError(DioException err, ErrorInterceptorHandler handler) {
//     // TODO: implement onError
//     // TODO maybe for now just log things
//     super.onError(err, handler);
//   }

//   // --------------------------------------- //

// // TODO dont delete this yet!!! THERE IS STUF FOR REDERECTION HERE BASED ON DEV ENV OR SUCH
//   // RequestOptions _getApiRedirectedOptions({
//   //   required RequestOptions options,
//   //   required bool shouldUseLocalServer,
//   // }) {
//   //   final requestApiAuthority = options.uri.authority;
//   //   final shouldRedirectToLocalApi =
//   //       requestApiAuthority == HttpConstants.BACKEND_BASE_URL.value &&
//   //           shouldUseLocalServer;

//   //   if (!shouldRedirectToLocalApi) {
//   //     return options;
//   //   }

//   //   final localApiOptions = _getRedirectToLocalApiOptions(options: options);
//   //   return localApiOptions;
//   // }

//   // RequestOptions _getRedirectToLocalApiOptions({
//   //   required RequestOptions options,
//   // }) {
//   //   const localApiPath = "http://10.0.2.2:4000";

//   //   final localApiOptions = options.copyWith(
//   //     path: localApiPath + options.uri.path,
//   //   );

//   //   return localApiOptions;
//   // }
// }

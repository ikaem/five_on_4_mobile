// TODO for now we will first try to see how does stuff propagate

// some sources
// https://stackoverflow.com/questions/77439254/flutter-dio-refresh-token-loop

// https://stackoverflow.com/questions/76228296/dio-queuedinterceptor-to-handle-refresh-token-with-multiple-requests

// https://stackoverflow.com/questions/76228296/dio-queuedinterceptor-to-handle-refresh-token-with-multiple-requests

// https://www.google.com/search?client=firefox-b-d&q=flutter+dio+interceptor+refresh+token

import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:five_on_4_mobile/src/features/auth/utils/constants/http_auth_constants.dart';
import 'package:five_on_4_mobile/src/features/core/domain/values/http_request_value.dart';
import 'package:five_on_4_mobile/src/features/core/utils/constants/http_constants.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/flutter_secure_storage/flutter_secure_storage_wrapper.dart';
import 'package:five_on_4_mobile/src/wrappers/local/cookies_handler/cookies_handler_wrapper.dart';
import 'package:isar/isar.dart';

class RefreshTokenDioInterceptor extends Interceptor {
  RefreshTokenDioInterceptor({
    required Dio dio,
    required FlutterSecureStorageWrapper secureStorageWrapper,
    required CookiesHandlerWrapper cookiesHandlerWrapper,
  })  : _dio = dio,
        _secureStorageWrapper = secureStorageWrapper,
        _cookiesHandlerWrapper = cookiesHandlerWrapper;

  // TODO will need to logout somehow as well?
  // TODO or i can throw specific error that will make controller always logout - every controller - if 401 reaches controller, let it logout - and we can reject immediatelly from here if 401 from refresyh token request
  final Dio _dio;
  final FlutterSecureStorageWrapper _secureStorageWrapper;
  final CookiesHandlerWrapper _cookiesHandlerWrapper;

  final bool _isRefreshing = false;

  final List<({RequestOptions requestOptions, ErrorInterceptorHandler handler})>
      _requestsQueue = [];

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    // for now, only situation that matters is the no access token is valid

    // but lets reject if the error is from refresh token request
    final isRefreshTokenRequest = err.requestOptions.uri.path ==
            HttpAuthConstants.BACKEND_ENDPOINT_PATH_REFRESH_TOKEN.value &&
        err.response?.statusCode == 400; // for some reason i made this 400
    if (isRefreshTokenRequest) {
      // we dont care about this - controller should handle and logout
      // TODO this seems to cause uncaught exeption
      return handler.reject(err);
      // return handler.next(err);
      // return super.onError(err, handler);
      // return handler.resolve(err.response!);
    }

    // ok, now we are now in refresh token request error
    final refreshToken = await _secureStorageWrapper.getRefreshTokenCookie();
    log("refreshTokenFromStorage: $refreshToken");

    final HttpRequestUriPartsValue refreshTokenRequestArgs =
        HttpRequestUriPartsValue(
      apiUrlScheme: HttpConstants.HTTPS_PROTOCOL.value,
      apiBaseUrl: HttpConstants.BACKEND_BASE_URL.value,
      apiContextPath: HttpConstants.BACKEND_CONTEXT_PATH.value,
      apiEndpointPath:
          HttpAuthConstants.BACKEND_ENDPOINT_PATH_REFRESH_TOKEN.value,
      queryParameters: null,
    );

    final requestOptions = RequestOptions(
      // path: "https://swapi.dev/api/people/1/",
      path: refreshTokenRequestArgs.uri.toString(),
      method: "post",
      headers: {
        // "cookie": "refreshToken=$refreshToken",
        HttpHeaders.cookieHeader: refreshToken,
      },
      // TODO should set cookie here
    );

    final response = await _dio.fetch(requestOptions);

    print("response");

    // TODO should not resolve this response - should resolve original request response - so need to make it again
    // handler.resolve(response);
  }

  bool _checkIsExpiredAccessTokenRequest(DioException err) {
    final responseData = err.response?.data;
    return err.response?.statusCode == 401 &&
        responseData["ok"] == false &&
        responseData["message"] == "Expired access token.";
  }

// ------------ FIRST ATTEMPT ---------------
//   @override
//   void onError(DioException err, ErrorInterceptorHandler handler) async {
//     // check if error is from logout request
//     // if error from logout request, we dont care about it - just pass it to the next interceptor
//     final isLogoutRequest =
//         // err.requestOptions.uri.path == "/logout";
//         err.requestOptions.uri.path ==
//             HttpAuthConstants.BACKEND_ENDPOINT_PATH_LOGOUT.value;
//     if (isLogoutRequest) {
//       // TODO abstract this - function - resetRefreshingAndEmptyQueue
//       // set that we are not refreshing anymore
//       _isRefreshing = false;
//       // just in case, empty queue
//       _requestsQueue.clear();
//       return handler.next(err);
//     }

//     final refreshToken = await _secureStorageWrapper.getRefreshTokenCookie();
//     log("refreshTokenFromStorage: $refreshToken");

//     // if this is error from request to refresh token, reject it
//     final isRefreshTokenRequest =
//         // err.requestOptions.uri.path == "/refresh-token";
//         err.requestOptions.uri.path ==
//             HttpAuthConstants.BACKEND_ENDPOINT_PATH_REFRESH_TOKEN.value;
//     if (isRefreshTokenRequest) {
//       // TODO we dont care about this
//       // return handler.next(err);
//       // we can probably reject it here
//       // whatever controller called this, its duty is to logout
//       // we should set that we are not refreshing anymore, and reject - so that logout request can be made
//       _isRefreshing = false;
//       // empty queue
//       _requestsQueue.clear();
//       return handler.reject(err);
//     }

//     // now we know we are not in logout request, and not in refresh token request
//     // check if it is expired access token request
//     final responseData = err.response?.data;
//     final isExpiredAccessTokenRequest = err.response?.statusCode == 401 &&
//         responseData["ok"] == false &&
//         responseData["message"] == "Expired access token.";
//     // now we know
//     if (!isExpiredAccessTokenRequest) {
//       // TODO we dont care about this
//       return handler.next(err);
//     }

//     // now we are in the case of expired access token
//     // check if we already enter phase of refreshing
//     if (_isRefreshing) {
//       // we are already refreshing, so we should reject this request
//       // add this request to the queue of requests that are waiting for refresh token
//       // not sure what should be done here
//       _requestsQueue.add((
//         requestOptions: err.requestOptions,
//         handler: handler,
//       ));
//     }

//     // now we are in the case of expired access token
//     // check if this is repeated request to refresh token

//     // ok, now we can make a request to refresh token

//     // we need refresh token for secure storage

//     // and we need cookie wrapper to generate cookie from refresh token and store in the request

//     final HttpRequestUriPartsValue refreshTokenRequestArgs =
//         HttpRequestUriPartsValue(
//       apiUrlScheme: HttpConstants.HTTPS_PROTOCOL.value,
//       apiBaseUrl: HttpConstants.BACKEND_BASE_URL.value,
//       apiContextPath: HttpConstants.BACKEND_CONTEXT_PATH.value,
//       apiEndpointPath:
//           HttpAuthConstants.BACKEND_ENDPOINT_PATH_REFRESH_TOKEN.value,
//       queryParameters: null,
//     );

//     // TODO not sure what this is? is it a proper whole cookie value?

//     // TODO move this logic to cookie handler wrapper - to generate headers with refresh token in it - it should copy all in header, and then add cookie header with refresh token - it there is anything in there - it should append to it?

//     // TODO dont forget to test all of this

//     // final refreshTokenRequestOptions = RequestOptions(
//     //     // path:
//     //     );

//     // print("refreshTokenRequestOptions: $refreshTokenRequestOptions");

//     // TODO make sure not to retry refresh token request - if it goes to this endpoint, and we are here in error - just reject it
// // TODO lets try to send request anywhere - to see if we can resolve this

// // should generate request headers with cookie - how does it look like?
// // should have "cookie" with list of cookies i guess?

// // final header

//     final requestOptions = RequestOptions(
//       // path: "https://swapi.dev/api/people/1/",
//       path: refreshTokenRequestArgs.uri.toString(),
//       method: "post",
//       headers: {
//         // "cookie": "refreshToken=$refreshToken",
//         HttpHeaders.cookieHeader: refreshToken,
//       },
//       // TODO should set cookie here
//     );

//     // TODO usually dont await queued requests - so we dont wait too long - use .then()
//     final response = await _dio.fetch(requestOptions);

//     // if response is success
//     if (response.statusCode == 200) {
//       // TODO we should set new access token in secure storage
//       // we should set new refresh token cookie in secure storage
//       // TODO we should set that we are not refreshing anymore
//       // TODO we should resolve all requests in the queue
//       // for (var element in _requestsQueue) {

//       //   _dio.fetch(element).then((value) {
//       //     // TODO we should resolve this request
//       //     element.
//       //   });

//       // }
//     }

//     handler.resolve(response);

//     // TODO i would like error to reach this interceptor first
//     // TODO: implement onError
//     // super.onError(err, handler);

// // TODO test only
//     // final response = Response(requestOptions: err.requestOptions, data: {
//     //   "ok": true,
//     // });

//     // handler.resolve(response);

//     // TODO this will pass it to the next interceptor
//     // handler.next(err);

//     // TODO this will reject automatically - no propagatiuon to next interceptor
//     // handler.reject(err);
//   }
}

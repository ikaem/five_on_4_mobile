// TODO for now we will first try to see how does stuff propagate

// some sources
// https://stackoverflow.com/questions/77439254/flutter-dio-refresh-token-loop

// https://stackoverflow.com/questions/76228296/dio-queuedinterceptor-to-handle-refresh-token-with-multiple-requests

// https://stackoverflow.com/questions/76228296/dio-queuedinterceptor-to-handle-refresh-token-with-multiple-requests

// https://www.google.com/search?client=firefox-b-d&q=flutter+dio+interceptor+refresh+token

import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/use_cases/sign_out/sign_out_use_case.dart';
import 'package:five_on_4_mobile/src/features/auth/utils/constants/http_auth_constants.dart';
import 'package:five_on_4_mobile/src/features/core/domain/values/http_request_value.dart';
import 'package:five_on_4_mobile/src/features/core/utils/constants/http_constants.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/flutter_secure_storage/flutter_secure_storage_wrapper.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/get_it/get_it_wrapper.dart';
import 'package:five_on_4_mobile/src/wrappers/local/cookies_handler/cookies_handler_wrapper.dart';
import 'package:isar/isar.dart';

// TODO this needs testing

// TODO maybe dont need extension
extension DioExceptionExtension on DioException {
  void then({
    // required void Function(DioException e) onLogoutResponseError,
    // required void Function(DioException e) onRefreshTokenResponseError,
    // required void Function(DioException e) onAuthorizationResponseError,
    // required void Function(DioException e) onOtherResponseError,
    required void Function() onLogoutResponseError,
    required void Function() onRefreshTokenResponseError,
    required void Function() onAuthorizationResponseError,
    required void Function() onOtherResponseError,
  }) {
    // check if require is logout request
    final isLogoutRequest = requestOptions.uri.path ==
        HttpAuthConstants.BACKEND_ENDPOINT_PATH_LOGOUT.value;

    final isRefreshTokenRequest = requestOptions.uri.path ==
        HttpAuthConstants.BACKEND_ENDPOINT_PATH_REFRESH_TOKEN
            .value; // maybe some other conditions would be good here

    final isAuthorizationError = response?.statusCode == 401;

    if (isLogoutRequest) {
      onLogoutResponseError();
      return;
    }

    if (isRefreshTokenRequest) {
      onRefreshTokenResponseError();
      return;
    }

    if (!isAuthorizationError) {
      onOtherResponseError();
      return;
    }

    onAuthorizationResponseError();
  }
}

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
  // TODO this is not even used here
  final CookiesHandlerWrapper _cookiesHandlerWrapper;

  bool _isRefreshing = false;

  final List<
      ({
        RequestOptions requestOptions,
        ErrorInterceptorHandler handler,
      })> _requestsQueue = [];

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // TODO maybe extension is not good here - maybe would be better to hanve a private methdo for htis here
    return err.then(
      onLogoutResponseError: () async =>
          _handleLogoutResponseError(handler, err),
      onRefreshTokenResponseError: () async =>
          _handleRefreshTokenResponseError(handler, err),
      onAuthorizationResponseError: () async =>
          _handleAuthorizationResponseError(handler, err),
      onOtherResponseError: () async => _handleOthenResponseError(handler, err),
    );
  }

  // TODO TEMP ONLY
  Future<void> _handleLogoutResponseError(
      ErrorInterceptorHandler handler, DioException e) async {
    log("Request to logout failed - probably already logged out - Returning without action on error");
    // maybe necessary to resolve the request, otherwise it will not be resolved by controllers that called use case to logout
    // TODO researcg function maybe to handle logout from the interceptor - so we dont use usecase - because use case is made specificcally to be called from controlelrs
    // TODO check if e.response! will always be non-null
    // TODO make sure everything from secure storage is removed on logout
    return handler.resolve(e.response!);
  }

  Future<void> _handleRefreshTokenResponseError(
    ErrorInterceptorHandler handler,
    DioException e,
  ) async {
    // TODO temp using use case - avoid it because it is hidden. eaither provide logic somehow, or make function througgh wrappers - so it can logout on its own
    log("Request to refresh token failed - probably expired refresh token - Logging out and resolving request");
    // TODO this is temp - figure out a better way so there is no hidden magic here
    final SignOutUseCase signOutUseCase = GetItWrapper.get<SignOutUseCase>();

    try {
      await signOutUseCase();
    } catch (e) {
      log("Error while trying to logout, BUT still logged out: $e");
    }

    // TODO i am not sure about this - maybe we should or maybe we should not resolve it - try it
    // TODO shorten times of valid access token and refresh token so this can be tested
    // return handler.resolve(e.response!);
    // TODO return fiture.value to be explicit
    return Future.value();
  }

  Future<void> _handleOthenResponseError(
    ErrorInterceptorHandler handler,
    DioException e,
  ) async {
    // just forward to next interceptor
    return handler.next(e);
  }

  Future<void> _handleAuthorizationResponseError(
    ErrorInterceptorHandler handler,
    DioException e,
  ) async {
    final refreshToken = await _secureStorageWrapper.getRefreshTokenCookie();
    log("refreshTokenFromStorage: $refreshToken");
    if (refreshToken == null) {
      // we dont have refresh token - we should logout - above handler will handle it
      return handler.reject(e);
    }

    if (!_isRefreshing) {
      // here we should
      // 1. set that we are refreshing
      // 2. add this request to the queue of requests that are waiting for refresh token
      // 3. make request to refresh token
      // 4. if success, set that we are not refreshing anymore, and resolve all requests in the queue

      // 1.
      _isRefreshing = true;
      // 2.
      _requestsQueue.add((
        requestOptions: e.requestOptions,
        handler: handler,
      ));

      // 3.
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
        path: refreshTokenRequestArgs.uri.toString(),
        method: "post",
        headers: {
          HttpHeaders.cookieHeader: refreshToken,
        },
      );

      final refreshTokenResponse = await _dio.fetch(requestOptions);
      if (refreshTokenResponse.statusCode != 200) {
        // TODO not sure if this should be done here - maybe in actual logout handler
        _isRefreshing = false;
        // TODO will need to clear the queue
        _requestsQueue.clear();
        // we should logout - above handler will handle it
        return handler.reject(e);
      }

      // 4.
      for (var element in _requestsQueue) {
        // TODO not awaiting - because we dont want to wait for all of them to finish - we want to resolve them as soon as they finish
        final response = _dio.fetch(element.requestOptions).then((response) {
          element.handler.resolve(response);
        }).catchError(
          (e) {
            // TODO not sure if this should be handled better
            log("Error while trying to resolve request in queue of RefreshTokenDioInterceptor: $e");
          },
        );
      }
      _isRefreshing = false;
      _requestsQueue.clear();
    } else {
      // here we were refreshing
      // add this request to the queue of requests that are waiting for refresh token
      _requestsQueue.add((
        requestOptions: e.requestOptions,
        handler: handler,
      ));
    }
  }

//
//
//
//
//
//
//
// TODO ---------- THIS IS SECOND ATTEMPT --------------
//   @override
//   Future<void> onError(
//       DioException err, ErrorInterceptorHandler handler) async {
// // if logout request, just ignore errors for now - resolve it - maybe even return?
//     final isLogoutRequest = err.requestOptions.uri.path ==
//         HttpAuthConstants.BACKEND_ENDPOINT_PATH_LOGOUT.value;
//     if (isLogoutRequest) {
//       // return handler.resolve(err.response!);
//       log("Request to logout failed - probably already logged out - Returning without action on error");
//       // TODO if we dont do this, controllers will not get the response
//       handler.resolve(err.response!);
//       return;
//       // TODO maybe return?
//     }

//     // for now, only situation that matters is the no access token is valid

//     // but lets reject if the error is from refresh token request
//     final isRefreshTokenRequest = err.requestOptions.uri.path ==
//             HttpAuthConstants.BACKEND_ENDPOINT_PATH_REFRESH_TOKEN.value &&
//         err.response?.statusCode == 400; // for some reason i made this 400
//     if (isRefreshTokenRequest) {
//       // we dont care about this - controller should handle and logout
//       // TODO this seems to cause uncaught exeption - not sure what will handle it
//       // maybe somehow we would need to logout from here - maybe can just access logout use case
//       // return handler.reject(err);
//       log("Request to refresh token failed - probably expired refresh token - Logging out and resolving request");
//       final SignOutUseCase signOutUseCase = GetItWrapper.get<SignOutUseCase>();

//       try {
//         await signOutUseCase();
//       } catch (e) {
//         log("Error while trying to logout, BUT still logged out: $e");
//       }
//       // TODO not sure what should be resolved here?
//       // return handler.resolve(err.response!);
//       // TODO this is ok to return because nothing is awaiting for this response
//       return;
//       // return handler.resolve(response);
//       // return handler.next(err);
//       // return super.onError(err, handler);
//       // return handler.resolve(err.response!);
//     }

//     // dont care about specific reason why 401 - just want to try to refresh token if 401
//     final isAuthorizationError = err.response?.statusCode == 401;
//     if (!isAuthorizationError) {
//       // if not authorization error, pass it to the next interceptor
//       return handler.next(err);
//     }

//     // now we can try to refresh token request
//     // ok, now we are now in refresh token request error
//     final refreshToken = await _secureStorageWrapper.getRefreshTokenCookie();
//     log("refreshTokenFromStorage: $refreshToken");

//     if (refreshToken == null) {
//       // we dont have refresh token - we should logout
//       return handler.reject(err);
//     }

//     final HttpRequestUriPartsValue refreshTokenRequestArgs =
//         HttpRequestUriPartsValue(
//       apiUrlScheme: HttpConstants.HTTPS_PROTOCOL.value,
//       apiBaseUrl: HttpConstants.BACKEND_BASE_URL.value,
//       apiContextPath: HttpConstants.BACKEND_CONTEXT_PATH.value,
//       apiEndpointPath:
//           HttpAuthConstants.BACKEND_ENDPOINT_PATH_REFRESH_TOKEN.value,
//       queryParameters: null,
//     );

//     final requestOptions = RequestOptions(
//       path: refreshTokenRequestArgs.uri.toString(),
//       method: "post",
//       headers: {
//         HttpHeaders.cookieHeader: refreshToken,
//       },
//       // TODO should set cookie here
//     );

//     final refreshTokenResponse = await _dio.fetch(requestOptions);

//     if (refreshTokenResponse.statusCode != 200) {
//       // TODO this should never be reached either - because we should logout above
//       // TODO test it by giving incorrect refresh token
//       // !!!!!!!!!! THIS COULD BE REACHED IF WE RESOLVE FAILED REFRESH TOKEN REQUEST FROM ABOVE
//       handler.reject(err);
//     }

//     // now we are fine - we can make original request again
//     final originalRequestResponse = await _dio.fetch(err.requestOptions);

//     // final accessToken =
//     //     originalRequestResponse.headers[HttpHeaders.authorizationHeader];

//     // const refreshTokenCookie = "";

//     // we can always resolve this it seems - because we are in error handler - interceptor onErorr should be able to take over - because response wont resolve if there is error
//     handler.resolve(originalRequestResponse);

//     print("response");

//     // lets check if this response is ok? if it is not, lets just reject previous request

//     // TODO should not resolve this response - should resolve original request response - so need to make it again
//     // handler.resolve(response);
//   }

  bool _checkIsExpiredAccessTokenRequest(DioException err) {
    final responseData = err.response?.data;
    return err.response?.statusCode == 401 &&
        responseData["ok"] == false &&
        responseData["message"] == "Expired access token.";
  }

//
//
//
//
//
//
//
//
//
//
//
//
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

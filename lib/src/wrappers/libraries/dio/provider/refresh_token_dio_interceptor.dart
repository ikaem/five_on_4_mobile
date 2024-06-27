// TODO for now we will first try to see how does stuff propagate

// some sources
// https://stackoverflow.com/questions/77439254/flutter-dio-refresh-token-loop

// https://stackoverflow.com/questions/76228296/dio-queuedinterceptor-to-handle-refresh-token-with-multiple-requests

// https://stackoverflow.com/questions/76228296/dio-queuedinterceptor-to-handle-refresh-token-with-multiple-requests

// https://www.google.com/search?client=firefox-b-d&q=flutter+dio+interceptor+refresh+token

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

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // check if it is expired access token request
    final responseData = err.response?.data;
    final isExpiredAccessTokenRequest = err.response?.statusCode == 401 &&
        responseData["ok"] == false &&
        responseData["message"] == "Expired access token.";

    if (!isExpiredAccessTokenRequest) {
      // TODO we dont care about this
      return handler.next(err);
    }

    // now we are in the case of expired access token
    // check if this is repeated request to refresh token
    final isRefreshTokenRequest =
        err.requestOptions.uri.path == "/refresh-token";
    if (isRefreshTokenRequest) {
      // TODO we dont care about this
      // return handler.next(err);
      // we can probably reject it here
      // whatever controller called this, its duty is to logout
      return handler.reject(err);
    }

    // ok, now we can make a request to refresh token

    // we need refresh token for secure storage

    // and we need cookie wrapper to generate cookie from refresh token and store in the request

    final HttpRequestUriPartsValue refreshTokenRequestArgs =
        HttpRequestUriPartsValue(
      apiUrlScheme: HttpConstants.HTTPS_PROTOCOL.value,
      apiBaseUrl: HttpConstants.BACKEND_BASE_URL.value,
      apiContextPath: HttpConstants.BACKEND_CONTEXT_PATH.value,
      apiEndpointPath:
          HttpAuthConstants.BACKEND_ENDPOINT_PATH_REFRESH_TOKEN.value,
      queryParameters: null,
    );

    // TODO move this logic to cookie handler wrapper - to generate headers with refresh token in it - it should copy all in header, and then add cookie header with refresh token - it there is anything in there - it should append to it?

    // TODO dont forget to test all of this

    final refreshTokenRequestOptions = RequestOptions(
        // path:
        );

    // TODO make sure not to retry refresh token request - if it goes to this endpoint, and we are here in error - just reject it
// TODO lets try to send request anywhere - to see if we can resolve this

// should generate request headers with cookie - how does it look like?
// should have "cookie" with list of cookies i guess?

    final requestOptions = RequestOptions(
      path: "https://swapi.dev/api/people/1/",
      method: "GET",
      // TODO should set cookie here
    );

    // TODO usually dont await queued requests - so we dont wait too long - use .then()
    final response = await _dio.fetch(requestOptions);

    handler.resolve(response);

    // TODO i would like error to reach this interceptor first
    // TODO: implement onError
    // super.onError(err, handler);

// TODO test only
    // final response = Response(requestOptions: err.requestOptions, data: {
    //   "ok": true,
    // });

    // handler.resolve(response);

    // TODO this will pass it to the next interceptor
    // handler.next(err);

    // TODO this will reject automatically - no propagatiuon to next interceptor
    // handler.reject(err);
  }
}

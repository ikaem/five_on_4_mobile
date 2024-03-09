// TODO sourcing intercepotor solution form here
// https://dhruvnakum.xyz/networking-in-flutter-interceptors

import 'package:dio/dio.dart';
import 'package:five_on_4_mobile/src/features/core/utils/constants/http_constants.dart';

// TODO as per https://medium.com/readytowork-org/dio-interceptors-in-flutter-e813f08c2017

// TODO could possibly create interceptor logic that would redirect requests to local server

class DioInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    // TODO will need to insert auth token into header or something from here
    // TODO leave for reference
    // final routeAuthority = options.uri.authority;
    // if (routeAuthority == WeatherConstants.baseUrl) {
    //   final String googleServicesApiKey = ValueFromEnv.weatherApiKey;
    //   ;

    //   final RequestOptions updatedOptions = options.copyWith(
    //     queryParameters: {
    //       "key": googleServicesApiKey,
    //     },
    //   );

    //   handler.next(updatedOptions);
    //   return;
    // }

    // handler.next(options);
    // super.onRequest(options, handler);
    // handler.resolve(response)
    final requestApiAuthority = options.uri.authority;
    final shouldRedirectToLocalApi =
        requestApiAuthority == HttpConstants.BACKEND_BASE_URL.value;
    if (shouldRedirectToLocalApi) {
      final localApiOptions = _getRedirectToLocalApiOptions(options: options);

      handler.next(localApiOptions);
      return;
    }

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // TODO: implement onResponse
    // super.onResponse(response, handler);
    handler.resolve(response);
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

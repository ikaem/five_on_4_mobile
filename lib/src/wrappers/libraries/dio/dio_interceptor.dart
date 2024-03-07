// TODO sourcing intercepotor solution form here
// https://dhruvnakum.xyz/networking-in-flutter-interceptors

import 'package:dio/dio.dart';

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

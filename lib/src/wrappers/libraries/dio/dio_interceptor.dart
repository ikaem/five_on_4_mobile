// TODO sourcing intercepotor solution form here
// https://dhruvnakum.xyz/networking-in-flutter-interceptors

import 'package:dio/dio.dart';

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
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // TODO: implement onResponse
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // TODO: implement onError
    super.onError(err, handler);
  }
}

// TODO maaaybe somehow need to test this

import 'package:dio/dio.dart';
import 'package:five_on_4_mobile/src/features/core/utils/constants/http_constants.dart';

class LocalApiDioInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // we know we are in local environment because this would not be added in interceptors otherwise
    // TODO maybe this would work as well
    // super.onRequest(options, handler);

    // TODO this could possibly be done with flavors too
    // TODO create task to use flavors for this - if nothing, to practice using flavors

    final updatedOptions = _getApiRedirectedOptions(
      options: options,
      // shouldUseLocalServer: shouldUseLocalServer,
    );

    return handler.next(updatedOptions);
  }

  RequestOptions _getApiRedirectedOptions({
    required RequestOptions options,
    // required bool shouldUseLocalServer,
  }) {
    final requestApiAuthority = options.uri.authority;

    // TODO make sure only to redirect requests to our own api - other api requests should not be redirected
    final shouldRedirectToLocalApi =
        requestApiAuthority == HttpConstants.BACKEND_BASE_URL.value;

    if (!shouldRedirectToLocalApi) {
      return options;
    }

    final localApiOptions = _getRedirectToLocalApiOptions(options: options);
    return localApiOptions;
  }

  RequestOptions _getRedirectToLocalApiOptions({
    required RequestOptions options,
  }) {
    // TODO not sure why i have this here
    const localApiPath = "http://10.0.2.2:8080";

    final localApiOptions = options.copyWith(
      path: localApiPath + options.uri.path,
    );

    return localApiOptions;
  }
}


/* 

    final newUri = options.uri.replace(path: localApiPath);

    final localApiOptions = options.copyWith(
      path: newUri.toString(),
      // TODO path is not good here
    );

 */
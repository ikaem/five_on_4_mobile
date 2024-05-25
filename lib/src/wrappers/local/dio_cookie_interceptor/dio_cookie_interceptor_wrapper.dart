// TODO test
import 'package:dio/src/dio_exception.dart';
import 'package:dio/src/dio_mixin.dart';
import 'package:dio/src/options.dart';
import 'package:dio/src/response.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

// TODO maybe it does not need to be in local if we pass it cookie jar instance
class DioCookieInterceptorWrapper extends CookieManager {
  // TODO we can create cookie jar in constructor body, or we can pass it
  DioCookieInterceptorWrapper(super.cookieJar);

  // TODO THIS IS not needed

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // final cj = cookieJar;
    // final uri = options.uri;

    // final cookies = await cj.loadForRequest(uri);
    // TODO: implement onRequest
    // super.onRequest(options, handler);
    handler.next(options);
    // TODO if this is last interceptor in chain

    // not this, this actually resolves with response, and we want to pass it on
    // handler.resolve(
    //   Response(
    //     requestOptions: options,
    //   ),
    //   true,
    // );
  }

  @override
  Future<void> onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    // TODO: implement onResponse
    final cj = cookieJar;
    final cookies = await cj.loadForRequest(
      response.requestOptions.uri,
    );
    // super.onResponse(response, handler);
    // handler.resolve(response);
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // TODO: implement onError
    super.onError(err, handler);
  }
}

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:five_on_4_mobile/src/features/core/domain/values/http_request_value.dart';
import 'package:five_on_4_mobile/src/features/core/utils/constants/http_methods_constants.dart';
import 'package:five_on_4_mobile/src/wrappers/local/dio_cookie_interceptor/dio_cookie_interceptor_wrapper.dart';

/* 

void main() async {
  final dio = Dio();
  final cookieJar = CookieJar();
  dio.interceptors.add(CookieManager(cookieJar));
  // First request, and save cookies (CookieManager do it).
  await dio.get("https://dart.dev");
  // Print cookies
  print(await cookieJar.loadForRequest(Uri.parse("https://dart.dev")));
  // Second request with the cookies
  await dio.get('https://dart.dev');
}






 */

class DioWrapper {
  DioWrapper({
    required Interceptor interceptor,
  }) {
    // test cookie jar manager interceptor
    final cookieJar = CookieJar();
    // final cookieManagerInterceptor = CookieManager(cookieJar);
    final dioCookieInterceptorWrapper = DioCookieInterceptorWrapper(cookieJar);

    final dio = Dio();
    // dio.interceptors.add(dioCookieInterceptorWrapper);
    dio.interceptors.add(interceptor);
    // TODO test

    _dio = dio;
  }

// TODO we could pass instance of dio here, so we can test this wrapper
  late final Dio _dio;

  Future<T> get<T>({
    required HttpRequestUriPartsValue uriParts,
  }) async {
    final uri = Uri(
      // port: uriParts.port,
      scheme: uriParts.apiUrlScheme,
      host: uriParts.apiBaseUrl,
      path: '${uriParts.apiContextPath}/${uriParts.apiEndpointPath}',
      queryParameters: uriParts.queryParameters,
    );

    final args = HttpRequestArgsValue(
      uri: uri,
      method: HttpMethodConstants.get,
    );

    final response = await _makeRequest<T>(
      args: args,
    );

    final data = response.data;

    if (data == null) {
      throw Exception(response.statusMessage ?? 'Data not found');
    }

    return data;
  }

  Future<T> post<T>({
    required HttpRequestUriPartsValue uriParts,
    Object? bodyData,
  }) async {
    // TODO could create function or extension on Uri to create uri
    final uri = Uri(
      scheme: uriParts.apiUrlScheme,
      host: uriParts.apiBaseUrl,
      path: '${uriParts.apiContextPath}/${uriParts.apiEndpointPath}',
      queryParameters: uriParts.queryParameters,
    );

    final args = HttpRequestArgsValue(
      uri: uri,
      method: HttpMethodConstants.post,
      data: bodyData,
    );

    final response = await _makeRequest<T>(
      args: args,
    );

    final data = response.data;

    if (data == null) {
      // TODO not sure if this is even needed
      throw Exception(response.statusMessage ?? 'Data not found');
    }

    return data;
  }

  Future<T> delete<T>({
    required HttpRequestUriPartsValue uriParts,
    Object? bodyData,
  }) async {
    // TODO could create function or extension on Uri to create uri
    final uri = Uri(
      scheme: uriParts.apiUrlScheme,
      host: uriParts.apiBaseUrl,
      path: '${uriParts.apiContextPath}/${uriParts.apiEndpointPath}',
      queryParameters: uriParts.queryParameters,
    );

    final args = HttpRequestArgsValue(
      uri: uri,
      method: HttpMethodConstants.delete,
      data: bodyData,
    );

    final response = await _makeRequest<T>(
      args: args,
    );

    final data = response.data;

    if (data == null) {
      // TODO not sure if this is even needed
      throw Exception(response.statusMessage ?? 'Data not found');
    }

    return data;
  }

  Future<Response<T>> _makeRequest<T>({
    required HttpRequestArgsValue args,
  }) async {
    try {
      final response = await _dio.requestUri<T>(
        args.uri,
        // Uri.parse("localhost:3000/matches"),
        data: args.data,
        options: Options(
          method: args.method.name,
        ),
      );

      if (response.statusCode != 200) {
        // TODO temp
        // ignore: only_throw_errors
        throw 'Invalid response';
      }

      return response;
    } catch (e) {
      final fallbackMesage = 'Failed to make request: $e';

      if (e is DioException) {
        throw Exception(e.response?.statusMessage ?? fallbackMesage);
      }

      throw Exception(fallbackMesage);
    }
  }
}

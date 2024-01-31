import 'package:dio/dio.dart';
import 'package:five_on_4_mobile/src/features/core/domain/values/http_request_value.dart';
import 'package:five_on_4_mobile/src/features/core/utils/constants/http_methods_constants.dart';

class DioWrapper {
  DioWrapper({
    required Interceptor interceptor,
  }) {
    _dio.interceptors.add(interceptor);
  }

  final Dio _dio = Dio();

  Future<T> get<T>({
    required HttpRequestUriPartsValue uriParts,
  }) async {
    final uri = Uri(
      port: uriParts.port,
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

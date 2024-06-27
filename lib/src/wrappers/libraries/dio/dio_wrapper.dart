import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:five_on_4_mobile/src/features/core/domain/exceptions/http_exceptions.dart';
import 'package:five_on_4_mobile/src/features/core/domain/values/http_request_value.dart';
import 'package:five_on_4_mobile/src/features/core/utils/constants/http_methods_constants.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/dio/dio_interceptor.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/flutter_secure_storage/flutter_secure_storage_wrapper.dart';
import 'package:five_on_4_mobile/src/wrappers/local/env_vars_wrapper.dart';

// errors throwing solution
// https://github.com/cfug/dio/issues/2056

class DioWrapper {
  DioWrapper({
    required Interceptor interceptor,
    required Dio dio,
  }) {
    dio.interceptors.add(interceptor);

    _dio = dio;
  }

  factory DioWrapper.createDefault({
    required FlutterSecureStorageWrapper flutterSecureStorageWrapper,
    required EnvVarsWrapper envVarsWrapper,
  }) {
    // TODO maybe even add some base options here
    final dio = Dio();
    final interceptor = DioInterceptor(
      flutterSecureStorageWrapper: flutterSecureStorageWrapper,
      envVarsWrapper: envVarsWrapper,
    );

    return DioWrapper(
      interceptor: interceptor,
      dio: dio,
    );
  }

  late final Dio _dio;

  // Future<T> get<T>({
  //   required HttpRequestUriPartsValue uriParts,
  // }) async {
  //   final uri = Uri(
  //     // port: uriParts.port,
  //     scheme: uriParts.apiUrlScheme,
  //     host: uriParts.apiBaseUrl,
  //     path: '${uriParts.apiContextPath}/${uriParts.apiEndpointPath}',
  //     queryParameters: uriParts.queryParameters,
  //   );

  //   final args = HttpRequestArgsValue(
  //     uri: uri,
  //     method: HttpMethodConstants.GET,
  //   );

  //   final data = await _makeRequest<T>(
  //     args: args,
  //   );

  //   return data;
  // }

  // Future<T> post<T>({
  //   required HttpRequestUriPartsValue uriParts,
  //   Object? bodyData,
  // }) async {
  //   // TODO could create function or extension on Uri to create uri
  //   final uri = Uri(
  //     scheme: uriParts.apiUrlScheme,
  //     host: uriParts.apiBaseUrl,
  //     path: '${uriParts.apiContextPath}/${uriParts.apiEndpointPath}',
  //     queryParameters: uriParts.queryParameters,
  //   );

  //   final args = HttpRequestArgsValue(
  //     uri: uri,
  //     method: HttpMethodConstants.POST,
  //     data: bodyData,
  //   );

  //   final data = await _makeRequest<T>(
  //     args: args,
  //   );

  //   return data;
  // }

  // Future<T> delete<T>({
  //   required HttpRequestUriPartsValue uriParts,
  //   Object? bodyData,
  // }) async {
  //   // TODO could create function or extension on Uri to create uri
  //   final uri = Uri(
  //     scheme: uriParts.apiUrlScheme,
  //     host: uriParts.apiBaseUrl,
  //     path: '${uriParts.apiContextPath}/${uriParts.apiEndpointPath}',
  //     queryParameters: uriParts.queryParameters,
  //   );

  //   final args = HttpRequestArgsValue(
  //     uri: uri,
  //     method: HttpMethodConstants.DELETE,
  //     data: bodyData,
  //   );

  //   final data = await _makeRequest<T>(
  //     args: args,
  //   );

  //   return data;
  // }

  Future<HttpResponseValue<T>> makeRequest<T extends Map>({
    required HttpRequestUriPartsValue uriParts,
    required HttpMethodConstants method,
    Object? bodyData,
  }) async {
    // final uri = Uri(
    //   scheme: uriParts.apiUrlScheme,
    //   host: uriParts.apiBaseUrl,
    //   path: '${uriParts.apiContextPath}/${uriParts.apiEndpointPath}',
    //   queryParameters: uriParts.queryParameters,
    // );

    final uri = uriParts.uri;

    final args = HttpRequestArgsValue(
      uri: uri,
      method: method,
      data: bodyData,
    );

    final data = await _makeRequest<T>(
      args: args,
    );

    final responseValue = HttpResponseValue<T>(
      payload: data,
    );

    return responseValue;
  }

  Future<T> _makeRequest<T>({
    required HttpRequestArgsValue args,
  }) async {
    try {
      final response = await _dio.requestUri<T>(
        args.uri,
        data: args.data,
        options: Options(
          method: args.method.value,
        ),
      );

      final data = response.data;
      // TODO not sure if we should do this - maybe we should just return the response
      // TODO but if we build a response from backend, there will always be a data field on it i think
      if (data == null) {
        throw HttpNoResponseDataException(
            contextMessage: response.requestOptions.toString());
      }

      return data;
    } catch (e) {
      log("Error making request: $e");

      rethrow;
    }
  }
}

// TODO move to values
class HttpResponseValue<T extends Map> {
  HttpResponseValue({
    required this.payload,
  });

  final T payload;

  bool get isOk => payload["ok"] == true;
  String get message => payload["message"];
}

// OLD

// import 'dart:developer';

// import 'package:cookie_jar/cookie_jar.dart';
// import 'package:dio/dio.dart';
// import 'package:dio_cookie_manager/dio_cookie_manager.dart';
// import 'package:five_on_4_mobile/src/features/core/domain/exceptions/http_exceptions.dart';
// import 'package:five_on_4_mobile/src/features/core/domain/values/http_request_value.dart';
// import 'package:five_on_4_mobile/src/features/core/utils/constants/http_methods_constants.dart';
// import 'package:five_on_4_mobile/src/wrappers/local/dio_cookie_interceptor/dio_cookie_interceptor_wrapper.dart';

// /*

// void main() async {
//   final dio = Dio();
//   final cookieJar = CookieJar();
//   dio.interceptors.add(CookieManager(cookieJar));
//   // First request, and save cookies (CookieManager do it).
//   await dio.get("https://dart.dev");
//   // Print cookies
//   print(await cookieJar.loadForRequest(Uri.parse("https://dart.dev")));
//   // Second request with the cookies
//   await dio.get('https://dart.dev');
// }

//  */

// class DioWrapper {
//   DioWrapper({
//     required Interceptor interceptor,
//     required Dio dio,
//   }) {
//     // final dio = Dio();
//     // dio.interceptors.add(dioCookieInterceptorWrapper);
//     dio.interceptors.add(interceptor);
//     // TODO test

//     _dio = dio;
//   }

//   late final Dio _dio;

//   Future<T> get<T>({
//     required HttpRequestUriPartsValue uriParts,
//   }) async {
//     final uri = Uri(
//       // port: uriParts.port,
//       scheme: uriParts.apiUrlScheme,
//       host: uriParts.apiBaseUrl,
//       path: '${uriParts.apiContextPath}/${uriParts.apiEndpointPath}',
//       queryParameters: uriParts.queryParameters,
//     );

//     final args = HttpRequestArgsValue(
//       uri: uri,
//       method: HttpMethodConstants.get,
//     );

//     final data = await _makeRequest<T>(
//       args: args,
//     );

//     // if (data == null) {
//     //   throw Exception(response.statusMessage ?? 'Data not found');
//     // }

//     return data;
//   }

//   Future<T> post<T>({
//     required HttpRequestUriPartsValue uriParts,
//     Object? bodyData,
//   }) async {
//     // TODO could create function or extension on Uri to create uri
//     final uri = Uri(
//       scheme: uriParts.apiUrlScheme,
//       host: uriParts.apiBaseUrl,
//       path: '${uriParts.apiContextPath}/${uriParts.apiEndpointPath}',
//       queryParameters: uriParts.queryParameters,
//     );

//     final args = HttpRequestArgsValue(
//       uri: uri,
//       method: HttpMethodConstants.post,
//       data: bodyData,
//     );

//     final data = await _makeRequest<T>(
//       args: args,
//     );

//     // if (data == null) {
//     //   // TODO not sure if this is even needed
//     //   throw Exception(response.statusMessage ?? 'Data not found');
//     // }

//     return data;
//   }

//   Future<T> delete<T>({
//     required HttpRequestUriPartsValue uriParts,
//     Object? bodyData,
//   }) async {
//     // TODO could create function or extension on Uri to create uri
//     final uri = Uri(
//       scheme: uriParts.apiUrlScheme,
//       host: uriParts.apiBaseUrl,
//       path: '${uriParts.apiContextPath}/${uriParts.apiEndpointPath}',
//       queryParameters: uriParts.queryParameters,
//     );

//     final args = HttpRequestArgsValue(
//       uri: uri,
//       method: HttpMethodConstants.delete,
//       data: bodyData,
//     );

//     final data = await _makeRequest<T>(
//       args: args,
//     );

//     // if (data == null) {
//     //   // TODO not sure if this is even needed
//     //   throw Exception(response.statusMessage ?? 'Data not found');
//     // }

//     return data;
//   }

//   Future<T> _makeRequest<T>({
//     required HttpRequestArgsValue args,
//   }) async {
//     try {
//       final response = await _dio.requestUri<T>(
//         args.uri,
//         // Uri.parse("localhost:3000/matches"),
//         data: args.data,
//         options: Options(
//           method: args.method.name,
//         ),
//       );

//       final data = response.data;
//       // TODO not sure if we should do this - maybe we should just return the response
//       // TODO but if we build a response from backend, there will always be a data field on it i think
//       if (data == null) {
//         // throw Exception("Data not found");
//         throw HttpNoResponseDataException(
//             contextMessage: response.requestOptions.toString());
//       }

//       return data;
//     } catch (e) {
//       // TODO get better logger
//       log("Error making request: $e");

//       rethrow;
//     }
//   }

//   // TODO old - but maybe good...
//   // Future<Response<T>> _makeRequest<T>({
//   //   required HttpRequestArgsValue args,
//   // }) async {
//   //   try {
//   //     final response = await _dio.requestUri<T>(
//   //       args.uri,
//   //       // Uri.parse("localhost:3000/matches"),
//   //       data: args.data,
//   //       options: Options(
//   //         method: args.method.name,
//   //       ),
//   //     );

//   //     if (response.statusCode != 200) {
//   //       // TODO temp
//   //       // ignore: only_throw_errors
//   //       // TODO will need more info here
//   //       throw 'Invalid response';
//   //     }

//   //     return response;
//   //   } catch (e) {
//   //     final fallbackMesage = 'Failed to make request: $e';

//   //     if (e is DioException) {
//   //       throw Exception(e.response?.statusMessage ?? fallbackMesage);
//   //     }

//   //     throw Exception(fallbackMesage);
//   //   }
//   // }
// }

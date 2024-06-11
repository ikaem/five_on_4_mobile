import 'package:equatable/equatable.dart';
import 'package:five_on_4_mobile/src/features/core/utils/constants/http_methods_constants.dart';
import 'package:flutter/material.dart';

@immutable
class HttpRequestUriPartsValue extends Equatable {
  const HttpRequestUriPartsValue({
    required this.apiUrlScheme,
    required this.apiBaseUrl,
    required this.apiContextPath,
    required this.apiEndpointPath,
    required this.queryParameters,
    // required this.port,
  });

  final String apiUrlScheme;
  final String apiBaseUrl;
  final String apiContextPath;
  final String apiEndpointPath;
  final Map<String, String>? queryParameters;
  // final int? port;

  @override
  List<Object?> get props => [
        apiUrlScheme,
        apiBaseUrl,
        apiContextPath,
        apiEndpointPath,
        queryParameters,
        // port,
      ];

  Uri get uri {
    return Uri(
      // port: port,
      scheme: apiUrlScheme,
      host: apiBaseUrl,
      path: '$apiContextPath/$apiEndpointPath',
      queryParameters: queryParameters,
    );
  }

  @override
  String toString() {
    return uri.toString();
  }
}

@immutable
class HttpRequestArgsValue {
  const HttpRequestArgsValue({
    required this.uri,
    required this.method,
    this.data,
  });

  final Uri uri;
  final HttpMethodConstants method;
  final Object? data;
}









// TODO olds
// import 'package:equatable/equatable.dart';
// import 'package:five_on_4_mobile/src/features/core/utils/constants/http_methods_constants.dart';
// import 'package:flutter/material.dart';

// @immutable
// class HttpRequestUriPartsValue extends Equatable {
//   const HttpRequestUriPartsValue({
//     required this.apiUrlScheme,
//     required this.apiBaseUrl,
//     required this.apiContextPath,
//     required this.apiEndpointPath,
//     required this.queryParameters,
//     // required this.port,
//   });

//   final String apiUrlScheme;
//   final String apiBaseUrl;
//   final String apiContextPath;
//   final String apiEndpointPath;
//   final Map<String, String>? queryParameters;
//   // final int? port;

//   @override
//   // TODO: implement props
//   List<Object?> get props => [
//         apiUrlScheme,
//         apiBaseUrl,
//         apiContextPath,
//         apiEndpointPath,
//         queryParameters,
//         // port,
//       ];
// }

// @immutable
// class HttpRequestArgsValue {
//   const HttpRequestArgsValue({
//     required this.uri,
//     required this.method,
//     this.data,
//   });

//   final Uri uri;
//   final HttpMethodConstants method;
//   final Object? data;
// }

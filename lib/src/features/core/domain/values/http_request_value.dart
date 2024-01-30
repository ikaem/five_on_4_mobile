import 'package:five_on_4_mobile/src/features/core/utils/constants/http_methods_constants.dart';
import 'package:flutter/material.dart';

@immutable
class HttpRequestUriPartsValue {
  const HttpRequestUriPartsValue({
    required this.apiUrlScheme,
    required this.apiBaseUrl,
    required this.apiContextPath,
    required this.apiEndpointPath,
    required this.queryParameters,
  });

  final String apiUrlScheme;
  final String apiBaseUrl;
  final String apiContextPath;
  final String apiEndpointPath;
  final Map<String, String>? queryParameters;
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

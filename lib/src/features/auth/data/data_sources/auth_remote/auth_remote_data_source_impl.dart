import 'dart:developer';

import 'package:five_on_4_mobile/src/features/auth/data/data_sources/auth_remote/auth_remote_data_source.dart';
import 'package:five_on_4_mobile/src/features/auth/data/entities/auth_remote/auth_remote_entity.dart';
import 'package:five_on_4_mobile/src/features/auth/data/entities/authenticated_player_remote/authenticated_player_remote_entity.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/exceptions/auth_exceptions.dart';
import 'package:five_on_4_mobile/src/features/auth/utils/constants/http_auth_constants.dart';
import 'package:five_on_4_mobile/src/features/core/domain/values/http_request_value.dart';
import 'package:five_on_4_mobile/src/features/core/utils/constants/http_constants.dart';
import 'package:five_on_4_mobile/src/features/core/utils/constants/http_methods_constants.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/dio/dio_wrapper.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/google_sign_in/google_sign_in_wrapper.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl({
    required GoogleSignInWrapper googleSignInWrapper,
    required DioWrapper dioWrapper,
  })  : _googleSignInWrapper = googleSignInWrapper,
        _dioWrapper = dioWrapper;

  final GoogleSignInWrapper _googleSignInWrapper;
  final DioWrapper _dioWrapper;

  @override
  Future<String> verifyGoogleSignIn() async {
    // final token = await _googleSignInWrapper.signInAndGetIdToken();
    // return token;
    throw UnimplementedError();
  }

  @override
  Future<AuthRemoteEntity> authenticateWithGoogle(String idToken) async {
    throw UnimplementedError();

    // TODO come back to this
    // final urilParts = HttpRequestUriPartsValue(
    //   apiUrlScheme: HttpConstants.HTTPS_PROTOCOL.value,
    //   apiBaseUrl: HttpConstants.BACKEND_BASE_URL.value,
    //   apiContextPath: HttpConstants.BACKEND_CONTEXT_PATH.value,
    //   apiEndpointPath:
    //       HttpAuthConstants.BACKEND_ENDPOINT_PATH_AUTH_GOOGLE.value,
    //   queryParameters: null,
    // );

    // final response = await _dioWrapper.post<Map<String, dynamic>>(
    //   uriParts: urilParts,
    //   bodyData: {
    //     "idToken": idToken,
    //   },
    // );

    // // TODO temp
    // if (response == null) {
    //   throw const AuthSomethingWentWrongException(
    //       contextMessage: ".authenticateWithGoogle()");
    // }

    // if (response["ok"] != true) {
    //   // TODO this will also need to be rethought
    //   throw Exception("Something went wrong with google sign in");
    // }

    // final authRemoteEntity = AuthRemoteEntity.fromJson(response["data"]);
    // return authRemoteEntity;
  }

  @override
  Future<AuthenticatedPlayerRemoteEntity?> getAuth() async {
    final uriParts = HttpRequestUriPartsValue(
      apiUrlScheme: HttpConstants.HTTPS_PROTOCOL.value,
      apiBaseUrl: HttpConstants.BACKEND_BASE_URL.value,
      apiContextPath: HttpConstants.BACKEND_CONTEXT_PATH.value,
      apiEndpointPath: HttpAuthConstants.BACKEND_ENDPOINT_PATH_GET_AUTH.value,
      queryParameters: null,
    );

    final response = await _dioWrapper.makeRequest<Map<String, dynamic>>(
      uriParts: uriParts,
      method: HttpMethodConstants.POST,
    );

    if (!response.isOk) {
      // TODO this should probably be submitted to crashlitcs or sentry or something
      log("Something went wrong with getAuth(): ${response.message}");
      return null;
    }

    final authenticatedPlayerRemoteEntity =
        AuthenticatedPlayerRemoteEntity.fromJson(response.payload["data"]);
    return authenticatedPlayerRemoteEntity;

    // make extension on this
    // TODO or make some kind of wrapper around response

    // TODO come back to this
    // final uriParts = HttpRequestUriPartsValue(
    //   apiUrlScheme: HttpConstants.HTTPS_PROTOCOL.value,
    //   apiBaseUrl: HttpConstants.BACKEND_BASE_URL.value,
    //   apiContextPath: HttpConstants.BACKEND_CONTEXT_PATH.value,
    //   apiEndpointPath: HttpAuthConstants.BACKEND_ENDPOINT_PATH_GET_AUTH.value,
    //   queryParameters: null,
    // );

    // final response = await _dioWrapper.get<Map<String, dynamic>>(
    //   uriParts: uriParts,
    // );

    // // TODO temp
    // if (response == null) {
    //   throw const AuthSomethingWentWrongException(contextMessage: ".getAuth()");
    // }

    // if (response["ok"] != true) {
    //   // TODO this will also need to be rethought
    //   throw const AuthSomethingWentWrongException(contextMessage: ".getAuth()");
    // }

    // final authenticatedPlayerRemoteEntity =
    //     AuthenticatedPlayerRemoteEntity.fromJson(response["data"]);
    // return authenticatedPlayerRemoteEntity;
  }
}

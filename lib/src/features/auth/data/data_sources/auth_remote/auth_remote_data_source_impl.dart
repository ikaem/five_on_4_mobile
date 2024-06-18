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
  Future<String> getGoogleSignInIdToken() async {
    final token = await _googleSignInWrapper.signInAndGetIdToken();
    return token;
  }

  @Deprecated("Replaced by getGoogleSignInIdToken()")
  @override
  Future<String> verifyGoogleSignIn() async {
    // final token = await _googleSignInWrapper.signInAndGetIdToken();
    // return token;
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() async {
    // TODO: implement signOut
    // it needs to:
    // 1. sign out of google
    await _googleSignInWrapper.signOut();
    // 2. sign out of the backend
    final uriParts = HttpRequestUriPartsValue(
      apiUrlScheme: HttpConstants.HTTPS_PROTOCOL.value,
      apiBaseUrl: HttpConstants.BACKEND_BASE_URL.value,
      apiContextPath: HttpConstants.BACKEND_CONTEXT_PATH.value,
      apiEndpointPath: HttpAuthConstants.BACKEND_ENDPOINT_PATH_LOGOUT.value,
      queryParameters: null,
    );
    final response = await _dioWrapper.makeRequest<Map<String, dynamic>>(
      uriParts: uriParts,
      method: HttpMethodConstants.POST,
    );

    if (!response.isOk) {
      // TODO this should probably be submitted to crashlitcs or sentry or something
      log("Something went wrong with signOut(): ${response.message}");
      throw const AuthExceptionSignoutFailed();
    }
    // TODO this should be done by the dio interceptor - because it has access to secure storage
    // 3. remove the access token from the local storage
    // 4. remove the refresh token from the local storage
    // throw UnimplementedError();
  }

  @override
  Future<AuthenticatedPlayerRemoteEntity> authenticateWithGoogle(
    String idToken,
  ) async {
    final uriParts = HttpRequestUriPartsValue(
      apiUrlScheme: HttpConstants.HTTPS_PROTOCOL.value,
      apiBaseUrl: HttpConstants.BACKEND_BASE_URL.value,
      apiContextPath: HttpConstants.BACKEND_CONTEXT_PATH.value,
      apiEndpointPath:
          HttpAuthConstants.BACKEND_ENDPOINT_PATH_AUTH_GOOGLE.value,
      queryParameters: null,
    );

    final response = await _dioWrapper.makeRequest<Map<String, dynamic>>(
      uriParts: uriParts,
      method: HttpMethodConstants.POST,
      bodyData: {
        // TODO is there constants for this somewhere
        "idToken": idToken,
      },
    );

    if (!response.isOk) {
      // TODO this should probably be submitted to crashlitcs or sentry or something
      log("Something went wrong with getAuth(): ${response.message}");

      throw const AuthExceptionFailedToAuthenticateWithGoogle();
      // return null;
      // TODO throwing so that info can propagate to the controller and inform the user
    }

    final authenticatedPlayerRemoteEntity =
        AuthenticatedPlayerRemoteEntity.fromJson(response.payload["data"]);
    return authenticatedPlayerRemoteEntity;
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
      // TODO maybe this should throw too
      return null;
    }

    final authenticatedPlayerRemoteEntity =
        AuthenticatedPlayerRemoteEntity.fromJson(response.payload["data"]);
    return authenticatedPlayerRemoteEntity;
  }
}

import 'package:five_on_4_mobile/src/features/auth/data/data_sources/auth_remote/auth_remote_data_source.dart';
import 'package:five_on_4_mobile/src/features/auth/data/entities/auth_remote/auth_remote_entity.dart';
import 'package:five_on_4_mobile/src/features/auth/utils/constants/http_auth_constants.dart';
import 'package:five_on_4_mobile/src/features/core/domain/values/http_request_value.dart';
import 'package:five_on_4_mobile/src/features/core/utils/constants/http_constants.dart';
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
    final token = await _googleSignInWrapper.signInAndGetIdToken();
    return token;
  }

  @override
  Future<AuthRemoteEntity> authenticateWithGoogle(String idToken) async {
    final urilParts = HttpRequestUriPartsValue(
      apiUrlScheme: HttpConstants.HTTPS_PROTOCOL.value,
      apiBaseUrl: HttpConstants.BACKEND_BASE_URL.value,
      apiContextPath: HttpConstants.BACKEND_CONTEXT_PATH.value,
      apiEndpointPath:
          HttpAuthConstants.BACKEND_ENDPOINT_PATH_AUTH_GOOGLE.value,
      queryParameters: null,
    );

    final response = await _dioWrapper.post<Map<String, dynamic>>(
      uriParts: urilParts,
      bodyData: {
        "idToken": idToken,
      },
    );

    if (response["ok"] != true) {
      throw Exception("Something went wrong with google sign in");
    }

    final authRemoteEntity = AuthRemoteEntity.fromJson(response["data"]);
    return authRemoteEntity;
  }
}

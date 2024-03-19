import 'package:five_on_4_mobile/src/features/auth/data/data_sources/auth_local/auth_local_data_source.dart';
import 'package:five_on_4_mobile/src/features/auth/data/data_sources/auth_status/auth_status_data_source.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/models/auth_data/auth_data_model.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/repository_interfaces/auth/auth_repository.dart';
import 'package:five_on_4_mobile/src/features/auth/utils/helpers/converters/auth_data_converter.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/flutter_secure_storage/flutter_secure_storage_wrapper.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/flutter_secure_storage/provider/flutter_secure_storage_wrapper_provider.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl({
    required AuthLocalDataSource authLocalDataSource,
    required AuthStatusDataSource authStatusDataSource,
    required FlutterSecureStorageWrapper flutterSecureStorageWrapper,
  })  : _authLocalDataSource = authLocalDataSource,
        _authStatusDataSource = authStatusDataSource,
        _flutterSecureStorageWrapper = flutterSecureStorageWrapper;

  final AuthLocalDataSource _authLocalDataSource;
  final AuthStatusDataSource _authStatusDataSource;
  final FlutterSecureStorageWrapper _flutterSecureStorageWrapper;

  @override
  Future<void> checkAuth() async {
    // 1. get auth id from secure storage
    final authId = await _flutterSecureStorageWrapper.getAuthId();
    if (authId == null) {
      _authStatusDataSource.setAuthDataStatus(null);
      return;
    }

    // 2. get auth data from db
    final authDataEntity = await _authLocalDataSource.getAuthEntity(authId);

    _authStatusDataSource.setAuthDataStatus(authDataEntity);
    // 3. set auth data status
    // final authDataEntity = await _authLocalDataSource.getAuthData();

    // _authStatusDataSource.setAuthDataStatus(authDataEntity);
  }

// TODO rename this
  @override
  Stream<bool> get authStatusStream {
    return _authStatusDataSource.authDataStatusStream
        .distinct()
        .map((authData) {
      final isLoggedIn = authData != null;
      return isLoggedIn;
    });
  }

  @override
  AuthDataModel? get auth {
    final authDataEntity = _authStatusDataSource.authDataStatus;
    if (authDataEntity == null) return null;

    final authDataModel =
        AuthDataConverter.toModelFromEntity(entity: authDataEntity);
    return authDataModel;
  }

  @override
  Future<void> loginWithGoogle() async {
    // TODO: implement loginWithGoogle
    throw UnimplementedError();
  }
}

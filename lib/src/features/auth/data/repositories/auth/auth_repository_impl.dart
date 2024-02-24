import 'package:five_on_4_mobile/src/features/auth/data/data_sources/auth_local/auth_local_data_source.dart';
import 'package:five_on_4_mobile/src/features/auth/data/data_sources/auth_status/auth_status_data_source.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/models/auth_data/auth_data_model.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/repository_interfaces/auth/auth_repository.dart';
import 'package:five_on_4_mobile/src/features/auth/utils/helpers/converters/auth_data_converter.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl({
    required AuthLocalDataSource authLocalDataSource,
    required AuthStatusDataSource authStatusDataSource,
  })  : _authLocalDataSource = authLocalDataSource,
        _authStatusDataSource = authStatusDataSource;

  final AuthLocalDataSource _authLocalDataSource;
  final AuthStatusDataSource _authStatusDataSource;

  @override
  Future<void> checkAuthDataStatus() async {
    final authDataEntity = await _authLocalDataSource.getAuthData();

    _authStatusDataSource.setAuthDataStatus(authDataEntity);
  }

  @override
  Stream<bool> get authDataStatusStream {
    return _authStatusDataSource.authDataStatusStream
        .distinct()
        .map((authData) {
      final isLoggedIn = authData != null;
      return isLoggedIn;
    });
  }

  @override
  AuthDataModel? get authDataStatus {
    final authDataEntity = _authStatusDataSource.authDataStatus;
    if (authDataEntity == null) return null;

    final authDataModel =
        AuthDataConverter.toModelFromEntity(entity: authDataEntity);
    return authDataModel;
  }
}

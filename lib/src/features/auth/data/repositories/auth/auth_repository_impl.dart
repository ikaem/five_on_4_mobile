import 'package:five_on_4_mobile/src/features/auth/data/data_sources/auth_local/auth_local_data_source.dart';
import 'package:five_on_4_mobile/src/features/auth/data/data_sources/auth_status/auth_status_data_source.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/models/auth_data/auth_data_model.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/repository_interfaces/auth/auth_repository.dart';
import 'package:five_on_4_mobile/src/features/auth/utils/helpers/converters/auth_data_converter.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl({
    required AuthLocalDataSource authDataSourceLocal,
    required AuthStatusDataSource authStatusDataSource,
  })  : _authDataSourceLocal = authDataSourceLocal,
        _authStatusDataSource = authStatusDataSource;

  final AuthLocalDataSource _authDataSourceLocal;
  final AuthStatusDataSource _authStatusDataSource;

  @override
  Future<void> checkAuthDataStatus() async {
    final authDataEntity = await _authDataSourceLocal.getAuthData();

    _authStatusDataSource.setAuthDataStatus(authDataEntity);
  }

  @override
  Stream<bool> get authDataStatusStream {
    return _authStatusDataSource.authDataStatusStream
        .distinct()
        .map((authData) => authData != null);
  }
}

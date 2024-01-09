import 'package:five_on_4_mobile/src/features/auth/data/data_sources/auth/auth_data_source_local.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/models/auth_data/auth_data_model.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/repository_interfaces/auth/auth_repository.dart';
import 'package:five_on_4_mobile/src/features/auth/utils/helpers/converters/auth_data_converter.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl({
    required AuthDataSourceLocal authDataSourceLocal,
  }) : _authDataSourceLocal = authDataSourceLocal;

  final AuthDataSourceLocal _authDataSourceLocal;

  @override
  Future<AuthDataModel?> getAuthData() async {
    final authDataEntity = await _authDataSourceLocal.getAuthData();
    if (authDataEntity == null) {
      return null;
    }

    final authDataModel =
        AuthDataConverter.toModelFromEntity(entity: authDataEntity);
    return authDataModel;
  }
}

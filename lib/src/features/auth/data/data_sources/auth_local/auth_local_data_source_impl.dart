import 'package:five_on_4_mobile/src/features/auth/data/data_sources/auth_local/auth_local_data_source.dart';
import 'package:five_on_4_mobile/src/features/auth/data/entities/auth_local/auth_local_entity.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/isar/isar_wrapper.dart';
import 'package:isar/isar.dart';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  const AuthLocalDataSourceImpl({
    required IsarWrapper isarWrapper,
  }) : _isarWrapper = isarWrapper;

  final IsarWrapper _isarWrapper;

  @override
  Future<AuthLocalEntity?> getAuthEntity(int authId) async {
    final authDataEntity = await _isarWrapper.db.authLocalEntitys
        .where()
        .idEqualTo(authId)
        .findFirst();
    return authDataEntity;
  }

  @override
  Future<int> storeAuthEntity(AuthLocalEntity authLocalEntity) async {
    final id = await _isarWrapper.db.writeTxn(() async {
      return await _isarWrapper.db.authLocalEntitys.put(authLocalEntity);
    });

    return id;
  }
}

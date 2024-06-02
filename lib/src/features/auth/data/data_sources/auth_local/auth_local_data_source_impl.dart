import 'package:drift/drift.dart';
import 'package:five_on_4_mobile/src/features/auth/data/data_sources/auth_local/auth_local_data_source.dart';
import 'package:five_on_4_mobile/src/features/auth/data/entities/auth_local/auth_local_entity.dart';
import 'package:five_on_4_mobile/src/features/auth/data/entities/authenticated_player_local/authenticated_player_local_entity.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/values/anthenticated_player_local_entity_value.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/drift/app_database.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/isar/isar_wrapper.dart';
import 'package:five_on_4_mobile/src/wrappers/local/database/database_wrapper.dart';
import 'package:isar/isar.dart';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  // const AuthLocalDataSourceImpl({
  //   required IsarWrapper isarWrapper,
  // }) : _isarWrapper = isarWrapper;

  // final IsarWrapper _isarWrapper;

  const AuthLocalDataSourceImpl({
    required DatabaseWrapper databaseWrapper,
  }) : _databaseWrapper = databaseWrapper;

  final DatabaseWrapper _databaseWrapper;

  @override
  Future<AuthLocalEntity?> getAuthEntity(int authId) async {
    return null;

    // final authDataEntity = await _isarWrapper.db.authLocalEntitys
    //     .where()
    //     .idEqualTo(authId)
    //     .findFirst();
    // return authDataEntity;
  }

  @override
  Future<int> storeAuthEntity(AuthLocalEntity authLocalEntity) async {
    return 1;
    // final id = await _isarWrapper.db.writeTxn(() async {
    //   return await _isarWrapper.db.authLocalEntitys.put(authLocalEntity);
    // });

    // return id;
  }

  @override
  Future<int> storeAuthenticatedPlayerEntity(
    AuthenticatedPlayerLocalEntityValue entityValue,
  ) async {
// TODO delete all existing authenticated players
    await _databaseWrapper.authenticatedPlayerRepo.deleteAll();

    final companion = AuthenticatedPlayerLocalEntityCompanion.insert(
      playerId: Value(entityValue.playerId),
      playerName: entityValue.playerName,
      playerNickname: entityValue.playerNickname,
    );

    final id =
        await _databaseWrapper.authenticatedPlayerRepo.insertOne(companion);

    return id;

    // final id = await _databaseWrapper.transaction(() async {
    //   return await _databaseWrapper.authenticatedPlayerRepo.insert(companion);
    // });
  }
}

import 'package:drift/drift.dart';
import 'package:five_on_4_mobile/src/features/auth/data/data_sources/auth_local/auth_local_data_source.dart';
import 'package:five_on_4_mobile/src/features/auth/data/entities/auth_local/auth_local_entity.dart';
import 'package:five_on_4_mobile/src/features/auth/data/entities/authenticated_player_local/authenticated_player_local_entity.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/exceptions/auth_exceptions.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/values/anthenticated_player_local_entity_value.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/drift/app_database.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/isar/isar_wrapper.dart';
import 'package:five_on_4_mobile/src/wrappers/local/database/database_wrapper.dart';
import 'package:isar/isar.dart';
import "package:drift/sqlite_keywords.dart";

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
  Future<void> deleteAuthenticatedPlayerEntities() async {
    await _databaseWrapper.authenticatedPlayerRepo.deleteAll();
  }

  @override
  Future<int> storeAuthenticatedPlayerEntity(
    AuthenticatedPlayerLocalEntityValue entityValue,
  ) async {
// TODO delete all existing authenticated players
// TODO this should probably go into transaction
    await _databaseWrapper.authenticatedPlayerRepo.deleteAll();

    // TODO this is also acceptable by the insertOne signature - maybe could be better because all items are required
    // final entityData = AuthenticatedPlayerLocalEntityData(
    //   playerId: entityValue.playerId,
    //   playerName: entityValue.playerName,
    //   playerNickname: entityValue.playerNickname,
    // );

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

  @override
  Stream<AuthenticatedPlayerLocalEntityData?>
      getAuthenticatedPlayerLocalEntityDataStream() {
    final stream =
        _databaseWrapper.db.authenticatedPlayerLocalEntity.select().watch();

    final singleValueStream = stream.map((event) {
      // return null;

      if (event.length > 1) {
        // throw Exception("Some expection -> more than 1 value inside");
        throw const AuthMultipleLocalAuthenticatedPlayersException();
        // return null;
        // return null;
        // TODO maybe even throw exception
      }

      if (event.isNotEmpty) {
        return event.first;
      }

      return null;
    });

    return singleValueStream;
  }

  // TODO this should get value, not directly data
  @override
  Future<AuthenticatedPlayerLocalEntityValue?>
      getAuthenticatedPlayerLocalEntity() async {
    final authenticatedPlayerLocalEntityData =
        await _databaseWrapper.authenticatedPlayerRepo.select().get();

    if (authenticatedPlayerLocalEntityData.length > 1) {
      throw const AuthMultipleLocalAuthenticatedPlayersException();
    }

    if (authenticatedPlayerLocalEntityData.isEmpty) {
      // return authenticatedPlayerLocalEntityData.first;
      return null;
    }

    // return null;
    final value = AuthenticatedPlayerLocalEntityValue(
      playerId: authenticatedPlayerLocalEntityData.first.playerId,
      playerName: authenticatedPlayerLocalEntityData.first.playerName,
      playerNickname: authenticatedPlayerLocalEntityData.first.playerNickname,
    );
    return value;
  }
}

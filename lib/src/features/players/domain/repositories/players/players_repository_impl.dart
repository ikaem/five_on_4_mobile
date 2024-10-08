import 'package:five_on_4_mobile/src/features/players/data/data_sources/players_local/players_local_data_source.dart';
import 'package:five_on_4_mobile/src/features/players/data/data_sources/players_remote/players_remote_data_source.dart';
import 'package:five_on_4_mobile/src/features/players/data/entities/player_remote/player_remote_entity.dart';
import 'package:five_on_4_mobile/src/features/players/domain/models/player/player_model.dart';
import 'package:five_on_4_mobile/src/features/players/domain/repositories/players/players_repository.dart';
import 'package:five_on_4_mobile/src/features/players/domain/values/player_local_entity_value.dart';
import 'package:five_on_4_mobile/src/features/players/domain/values/search_players_fluter_value.dart';
import 'package:five_on_4_mobile/src/features/players/utils/converters/players_converter.dart';

class PlayersRepositoryImpl implements PlayersRepository {
  const PlayersRepositoryImpl({
    required PlayersLocalDataSource playersLocalDataSource,
    required PlayersRemoteDataSource playersRemoteDataSource,
  })  : _playersLocalDataSource = playersLocalDataSource,
        _playersRemoteDataSource = playersRemoteDataSource;

  final PlayersLocalDataSource _playersLocalDataSource;
  final PlayersRemoteDataSource _playersRemoteDataSource;

  @override
  Future<PlayerModel> getPlayer({required int playerId}) async {
    final PlayerLocalEntityValue localEntityValue =
        await _playersLocalDataSource.getPlayer(
      playerId: playerId,
    );

    final model =
        PlayersConverter.toModelFromLocalEntityValue(localEntityValue);

    return model;
  }

  @override
  Future<List<PlayerModel>> getPlayers({required List<int> playerIds}) async {
    final localEntitiesValues = await _playersLocalDataSource.getPlayers(
      playerIds: playerIds,
    );

    final models = localEntitiesValues
        .map((e) => PlayersConverter.toModelFromLocalEntityValue(e))
        .toList();

    return models;
  }

  @override
  Future<List<int>> loadSearchedPlayers({
    required SearchPlayersFilterValue filter,
  }) async {
    final remoteEntities = await _playersRemoteDataSource.getSearchedPlayers(
      searchPlayersFilter: filter,
    );

// TODO create converter for this - make ticket to create all converters
    final localEntityValues = remoteEntities
        .map(
          (remoteEntity) => PlayerLocalEntityValue(
            id: remoteEntity.id,
            firstName: remoteEntity.firstName,
            lastName: remoteEntity.lastName,
            nickname: remoteEntity.nickname,
            avatarUrl: remoteEntity.avatarUrl,
          ),
        )
        .toList();

    final ids =
        _playersLocalDataSource.storePlayers(matchValues: localEntityValues);

    return ids;
  }

  // TODO should this also return int - just to be on safe side? or should it?
  @override
  Future<void> loadPlayer({required int playerId}) async {
    final PlayerRemoteEntity remoteEntity =
        await _playersRemoteDataSource.getPlayer(id: playerId);

    final PlayerLocalEntityValue localEntityValue = PlayerLocalEntityValue(
      id: remoteEntity.id,
      firstName: remoteEntity.firstName,
      lastName: remoteEntity.lastName,
      nickname: remoteEntity.nickname,
      avatarUrl: remoteEntity.avatarUrl,
    );

    await _playersLocalDataSource.storePlayer(playerValue: localEntityValue);
  }
}

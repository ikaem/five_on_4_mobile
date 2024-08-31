import 'package:equatable/equatable.dart';
import 'package:five_on_4_mobile/src/features/player_match_participation/data/data_sources/player_match_participation_local/player_match_participation_local_data_source.dart';
import 'package:five_on_4_mobile/src/features/player_match_participation/data/entities/player_match_participation_local/player_match_participation_local_entity.dart';
import 'package:five_on_4_mobile/src/features/player_match_participation/domain/values/player_match_participation_local_entity_value.dart';
import 'package:five_on_4_mobile/src/wrappers/local/database/database_wrapper.dart';

class PlayerMatchParticipationLocalDataSourceImpl
    implements PlayerMatchParticipationLocalDataSource {
  PlayerMatchParticipationLocalDataSourceImpl({
    required DatabaseWrapper databaseWrapper,
  }) : _databaseWrapper = databaseWrapper;

  final DatabaseWrapper _databaseWrapper;

  @override
  Future<int> storeParticipation({
    required PlayerMatchParticipationLocalEntityValue
        playerMatchParticipationValue,
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<List<int>> storeParticipations({
    required List<PlayerMatchParticipationLocalEntityValue>
        playerMatchParticipationValues,
  }) async {
    throw UnimplementedError();
  }
}

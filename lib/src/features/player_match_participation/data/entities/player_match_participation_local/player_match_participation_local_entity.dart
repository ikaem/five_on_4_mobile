import 'package:drift/drift.dart';
import 'package:five_on_4_mobile/src/features/matches/data/entities/match_local/match_local_entity.dart';
import 'package:five_on_4_mobile/src/features/players/data/entities/player_local/player_local_entity.dart';

class PlayerMatchParticipationLocalEntity extends Table {
  IntColumn get id => integer()();

  IntColumn get status => intEnum<PlayerMatchParticipationStatus>()();

  // refs
  IntColumn get playerId => integer().references(PlayerLocalEntity, #id)();
  IntColumn get matchId => integer().references(MatchLocalEntity, #id)();

  @override
  Set<Column> get primaryKey => {id};
}

// TODO move to somehwere else, not sure where yet
enum PlayerMatchParticipationStatus {
  pendingDecision, // 0
  arriving, // 1
  notArriving, // 2
  // TODO if any other are added, they need to be added at the end of list to account for indexes of each enum and avoid migration
  unknown, // 3
}

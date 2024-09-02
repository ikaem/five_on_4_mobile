import 'package:drift/drift.dart';
import 'package:five_on_4_mobile/src/features/matches/data/entities/match_local/match_local_entity.dart';
import 'package:five_on_4_mobile/src/features/players/data/entities/player_local/player_local_entity.dart';
import 'package:five_on_4_mobile/src/style/utils/constants/color_constants.dart';
import 'package:flutter/material.dart' hide Table, Column;

class PlayerMatchParticipationLocalEntity extends Table {
  IntColumn get id => integer()();

  IntColumn get status => intEnum<PlayerMatchParticipationStatus>()();
  // TODO this adds duplication between tables, but screw it. we need to know somehow name on participation
  // so at some point, if we allow changes of nickname, this would be a problem because we would need to update it on both backend and on each device. this is why we should not allow changes of nickname
  // alternatively, we could send entire player?
  // maybe as a field here, so we would then have full player info, but i dont know. lets consider that when we get there
  TextColumn get playerNickname => text().nullable()();

  // refs
  IntColumn get playerId => integer().references(PlayerLocalEntity, #id)();
  IntColumn get matchId => integer().references(MatchLocalEntity, #id)();

  @override
  Set<Column> get primaryKey => {id};

  @override
  // TODO: implement uniqueKeys
  List<Set<Column<Object>>>? get uniqueKeys => [
        // if a participation with same player and match already exists, we should be allowed to create a new one
        {
          playerId,
          matchId,
        }
      ];
}

// TODO move to somehwere else, not sure where yet
// TODO move to somehwere else, not sure where yet
enum PlayerMatchParticipationStatus {
  pendingDecision, // 0
  arriving, // 1
  notArriving, // 2
  // TODO if any other are added, they need to be added at the end of list to account for indexes of each enum and avoid migration
  unknown; // 3

// TODO maybe this should be in an extension
  String get formattedName {
    final formattedName = switch (this) {
      PlayerMatchParticipationStatus.pendingDecision => "Pending decision",
      PlayerMatchParticipationStatus.arriving => "Arriving",
      PlayerMatchParticipationStatus.notArriving => "Not arriving",
      PlayerMatchParticipationStatus.unknown => "Unknown",
    };

    return formattedName;
  }

  IconData get iconData {
    final icon = switch (this) {
      PlayerMatchParticipationStatus.pendingDecision => Icons.question_mark,
      PlayerMatchParticipationStatus.arriving => Icons.check,
      PlayerMatchParticipationStatus.notArriving => Icons.close,
      PlayerMatchParticipationStatus.unknown => Icons.warning,
    };

    return icon;
  }

  Color get iconColor {
    final color = switch (this) {
      PlayerMatchParticipationStatus.pendingDecision => ColorConstants.GREY,
      PlayerMatchParticipationStatus.arriving => ColorConstants.GREEN,
      PlayerMatchParticipationStatus.notArriving => ColorConstants.RED,
      PlayerMatchParticipationStatus.unknown => ColorConstants.GREY_DARK,
    };

    return color;
  }
}

// extension 

// TODO create some extension on this for nicely formatted string to render in UI
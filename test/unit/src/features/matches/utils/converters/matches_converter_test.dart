import 'package:five_on_4_mobile/src/features/matches/data/entities/match_remote/match_local/match_local_entity.dart';
import 'package:five_on_4_mobile/src/features/matches/data/entities/match_remote/match_remote_entity.dart';
import 'package:five_on_4_mobile/src/features/matches/utils/converters/matches_converter.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../../utils/data/test_entities.dart';

void main() {
  group(
    "MatchesConverter",
    () {
      group(
        ".fromRemoteEntityToLocalEntity",
        () {
          test(
            "given a [MatchRemoteEntity]"
            "when '.fromRemoteEntityToLocalEntity()' is called"
            "should return a [MatchLocalEntity]",
            () {
              final matchRemote = getTestMatchRemoteEntities(count: 1).first;

              final expectedMatchLocal = _testFromRemoteEntityToLocalEntity(
                matchRemote: matchRemote,
              );

              final result = MatchesConverter.fromRemoteEntityToLocalEntity(
                matchRemote: matchRemote,
              );

              expect(result, equals(expectedMatchLocal));
            },
          );
        },
      );
    },
  );
}

MatchLocalEntity _testFromRemoteEntityToLocalEntity({
  required MatchRemoteEntity matchRemote,
}) {
  final arrivingPlayers = matchRemote.arrivingPlayers.map((player) {
    return MatchLocalPlayerEntity(
      id: player.id,
      name: player.name,
      nickname: player.nickname,
      avatarUrl: player.avatarUri.toString(),
    );
  }).toList();

  final matchLocal = MatchLocalEntity(
    id: matchRemote.id,
    date: matchRemote.date,
    name: matchRemote.name,
    location: matchRemote.location,
    organizer: matchRemote.organizer,
    description: matchRemote.description,
    arrivingPlayers: arrivingPlayers,
  );

  return matchLocal;
}

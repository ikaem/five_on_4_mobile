// import 'package:five_on_4_mobile/src/features/matches/data/entities/match_local/match_local_entity.dart';
// import 'package:five_on_4_mobile/src/features/matches/data/entities/match_remote/match_remote_entity.dart';
// import 'package:five_on_4_mobile/src/features/matches/utils/converters/matches_converter.dart';
// import 'package:flutter_test/flutter_test.dart';

// import '../../../../../../utils/data/test_entities.dart';

// void main() {
//   group(
//     "MatchesConverter",
//     () {
//       group(
//         ".fromRemoteEntityToLocalEntity",
//         () {
//           test(
//             "given a [MatchRemoteEntity]"
//             "when '.fromRemoteEntityToLocalEntity()' is called"
//             "should return a [MatchLocalEntity]",
//             () {
//               final matchRemote = getTestMatchRemoteEntities(count: 1).first;

//               final expectedMatchLocal = _testFromRemoteEntityToLocalEntity(
//                 matchRemote: matchRemote,
//               );

//               final result = MatchesConverter.fromRemoteEntityToLocalEntity(
//                 matchRemote: matchRemote,
//               );

//               expect(result, equals(expectedMatchLocal));
//             },
//           );
//         },
//       );

//       group(
//         ".fromRemoteEntitiesToLocalEntities",
//         () {
//           test(
//             "given a list of [MatchRemoteEntity]"
//             "when '.fromRemoteEntitiesToLocalEntities()' is called"
//             "should return a list of [MatchLocalEntity]",
//             () {
//               final matchesRemote = getTestMatchRemoteEntities(count: 3);

//               final expectedMatchesLocal = matchesRemote
//                   .map(
//                     (m) => _testFromRemoteEntityToLocalEntity(
//                       matchRemote: m,
//                     ),
//                   )
//                   .toList();

//               final result = MatchesConverter.fromRemoteEntitiesToLocalEntities(
//                 matchesRemote: matchesRemote,
//               );

//               expect(result, equals(expectedMatchesLocal));
//             },
//           );
//         },
//       );
//     },
//   );
// }

// MatchLocalEntity _testFromRemoteEntityToLocalEntity({
//   required MatchRemoteEntity matchRemote,
// }) {
//   final arrivingPlayers = matchRemote.arrivingPlayers.map((player) {
//     return MatchLocalPlayerEntity(
//       playerId: player.id,
//       name: player.name,
//       nickname: player.nickname,
//       avatarUrl: player.avatarUri.toString(),
//     );
//   }).toList();

//   final matchLocal = MatchLocalEntity(
//     id: matchRemote.id,
//     date: matchRemote.date,
//     name: matchRemote.name,
//     location: matchRemote.location,
//     organizer: matchRemote.organizer,
//     description: matchRemote.description,
//     arrivingPlayers: arrivingPlayers,
//   );

//   return matchLocal;
// }

// TODO come back to this

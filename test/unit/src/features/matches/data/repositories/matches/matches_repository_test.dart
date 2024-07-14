import 'package:drift/drift.dart';
import 'package:five_on_4_mobile/src/features/matches/data/data_sources/matches_local/matches_local_data_source.dart';
import 'package:five_on_4_mobile/src/features/matches/data/data_sources/matches_remote/matches_remote_data_source.dart';
import 'package:five_on_4_mobile/src/features/matches/data/entities/match_remote/match_remote_entity.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/models/match/match_model.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/repositories/matches/matches_repository.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/repositories/matches/matches_repository_impl.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/values/match_create_data_value.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/values/match_local_entity_value.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/values/player_match_local_entities_overview_value.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/values/player_match_models_overview_value.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../../../utils/data/test_entities.dart';

void main() {
  final matchesLocalDataSource = _MockMatchesLocalDataSource();
  final matchesRemoteDataSource = _MockMatchesRemoteDataSource();

  // tested class
  final matchesRepository = MatchesRepositoryImpl(
    matchesLocalDataSource: matchesLocalDataSource,
    matchesRemoteDataSource: matchesRemoteDataSource,
  );

  setUpAll(
    () {
      registerFallbackValue(_FakeMatchCreateDataValue());
      registerFallbackValue(_FakeMatchLocalEntityValue());
      registerFallbackValue(_FakeSearchMatchesFilterValue());
    },
  );

  tearDown(() {
    reset(matchesLocalDataSource);
    reset(matchesRemoteDataSource);
  });

  group("$MatchesRepository", () {
    group(
      "createMatch()",
      () {
        const MatchCreateDataValue matchData = MatchCreateDataValue(
          name: "name",
          location: "location",
          organizer: "organizer",
          description: "description",
          invitedPlayers: [],
          dateTime: 1,
        );
// should return expected value
        test(
          "given match is created successfully"
          "when .createMatch() is called"
          "then should expected match id",
          () async {
            // setup
            const matchId = 1;

            // given
            when(
              () => matchesRemoteDataSource.createMatch(
                matchData: any(named: "matchData"),
              ),
            ).thenAnswer(
              (_) async => matchId,
            );

            // when
            final result = await matchesRepository.createMatch(
              matchData: matchData,
            );

            // then
            expect(result, equals(matchId));

            // cleanup
          },
        );

// should call remote data source with expected arguments
        test(
          "given match data is provided"
          "when .createMatch() is called"
          "then should call MatchesRemoteDataSource.createMatch() with expected arguments",
          () async {
            // setup
            when(
              () => matchesRemoteDataSource.createMatch(
                matchData: any(named: "matchData"),
              ),
            ).thenAnswer(
              (_) async => 1,
            );
            // given

            // when
            await matchesRepository.createMatch(
              matchData: matchData,
            );

            // then
            verify(
              () => matchesRemoteDataSource.createMatch(
                matchData: matchData,
              ),
            ).called(1);

            // cleanup
          },
        );
      },
    );

    group(
      ".getMatch()",
      () {
// given local source has match, should return expected value
        test(
          "given MatchesLocalDataSource.getMatch() returns match"
          "when .getMatch() is called"
          "then should return expected value",
          () async {
            // setup
            const localEntityValue = MatchLocalEntityValue(
              id: 1,
              dateAndTime: 1,
              title: "title",
              location: "location",
              description: "description",
            );

            // given
            when(
              () => matchesLocalDataSource.getMatch(
                matchId: any(named: "matchId"),
              ),
            ).thenAnswer(
              (_) async => localEntityValue,
            );

            // when
            final result = await matchesRepository.getMatch(
              matchId: 1,
            );

            // then
            final expectedModel = MatchModel(
              id: localEntityValue.id,
              dateAndTime: DateTime.fromMillisecondsSinceEpoch(
                localEntityValue.dateAndTime,
              ),
              title: localEntityValue.title,
              location: localEntityValue.location,
              description: localEntityValue.description,
            );

            expect(result, equals(expectedModel));

            // cleanup
          },
        );

// should rethrow if there is local data source throws expected expcetpion - TODO come back to this
      },
    );

    group(".getPlayerMatchesOverview()", () {
      // should return expected result

      test(
        "given MatchesLocalDataSource.getPlayerMatchesOverview returns expected values"
        "when .getPlayerMatchesOverview() is called"
        "then should return expected value",
        () async {
          // setup
          final localEntitiesValue = PlayerMatchLocalEntitiesOverviewValue(
            upcomingMatches: generateTestMatchLocalEntityCompanions(count: 3)
                .map(
                  (e) => MatchLocalEntityValue(
                    id: e.id.value,
                    dateAndTime: e.dateAndTime.value,
                    title: e.title.value,
                    location: e.location.value,
                    description: e.description.value,
                  ),
                )
                .toList(),
            todayMatches: generateTestMatchLocalEntityCompanions(count: 3)
                .map(
                  (e) => MatchLocalEntityValue(
                    id: e.id.value,
                    dateAndTime: e.dateAndTime.value,
                    title: e.title.value,
                    location: e.location.value,
                    description: e.description.value,
                  ),
                )
                .toList(),
            pastMatches: generateTestMatchLocalEntityCompanions(count: 3)
                .map(
                  (e) => MatchLocalEntityValue(
                    id: e.id.value,
                    dateAndTime: e.dateAndTime.value,
                    title: e.title.value,
                    location: e.location.value,
                    description: e.description.value,
                  ),
                )
                .toList(),
          );

          // given
          when(() => matchesLocalDataSource.getPlayerMatchesOverview(
                playerId: any(named: "playerId"),
              )).thenAnswer((invocation) async => localEntitiesValue);

          // when
          final result = await matchesRepository.getPlayerMatchesOverview(
            playerId: 1,
          );

          // then
          final expectedResult = PlayerMatchModelsOverviewValue(
            upcomingMatches: localEntitiesValue.upcomingMatches
                .map(
                  (e) => MatchModel(
                    id: e.id,
                    dateAndTime: DateTime.fromMillisecondsSinceEpoch(
                      e.dateAndTime,
                    ),
                    title: e.title,
                    location: e.location,
                    description: e.description,
                  ),
                )
                .toList(),
            todayMatches: localEntitiesValue.todayMatches
                .map(
                  (e) => MatchModel(
                    id: e.id,
                    dateAndTime: DateTime.fromMillisecondsSinceEpoch(
                      e.dateAndTime,
                    ),
                    title: e.title,
                    location: e.location,
                    description: e.description,
                  ),
                )
                .toList(),
            pastMatches: localEntitiesValue.pastMatches
                .map(
                  (e) => MatchModel(
                    id: e.id,
                    dateAndTime: DateTime.fromMillisecondsSinceEpoch(
                      e.dateAndTime,
                    ),
                    title: e.title,
                    location: e.location,
                    description: e.description,
                  ),
                )
                .toList(),
          );

          expect(result, equals(expectedResult));

          // cleanup
        },
      );
    });

    group(".loadSearchedMatches", () {
      test(
        "given SearchMatchesFilterValue is provided"
        "when .loadSearchedMatches() is called"
        "then should call MatchesRemoteDataSource.getSearchedMatches() with expected arguments",
        () async {
          // setup
          final testMatchRemoteEntities =
              generateTestMatchRemoteEntities(count: 3);

          when(() => matchesRemoteDataSource.getSearchedMatches(
                searchMatchesFilter: any(named: "searchMatchesFilter"),
              )).thenAnswer((_) async => testMatchRemoteEntities);
          when(() => matchesLocalDataSource.storeMatches(
                matchValues: any(named: "matchValues"),
              )).thenAnswer((invocation) async {});

          // given
          const searchMatchesFilter = SearchMatchesFilterValue(
            matchTitle: "title",
          );

          // when
          await matchesRepository.loadSearchedMatches(
            filter: searchMatchesFilter,
          );

          // then
          verify(
            () => matchesRemoteDataSource.getSearchedMatches(
              searchMatchesFilter: searchMatchesFilter,
            ),
          ).called(1);

          // cleanup
        },
      );

      test(
        "given remote match entities are successfully retrieved"
        "when .loadSearchedMatches() is called"
        "then should call MatchesLocalDataSource.storeMatches() with expected arguments",
        () async {
          // setup
          const SearchMatchesFilterValue searchMatchesFilter =
              SearchMatchesFilterValue(
            matchTitle: "title",
          );

          final testMatchRemoteEntities =
              generateTestMatchRemoteEntities(count: 3);

          when(() => matchesLocalDataSource.storeMatches(
                matchValues: any(named: "matchValues"),
              )).thenAnswer((invocation) async {});

          // given
          when(() => matchesRemoteDataSource.getSearchedMatches(
                searchMatchesFilter: any(named: "searchMatchesFilter"),
              )).thenAnswer((_) async => testMatchRemoteEntities);

          // when
          await matchesRepository.loadSearchedMatches(
            filter: searchMatchesFilter,
          );

          // then
          final expectedMatchLocalEntityValues = testMatchRemoteEntities
              .map(
                (e) => MatchLocalEntityValue(
                  id: e.id,
                  dateAndTime: e.dateAndTime,
                  title: e.title,
                  location: e.location,
                  description: e.description,
                ),
              )
              .toList();

          verify(
            () => matchesLocalDataSource.storeMatches(
              matchValues: expectedMatchLocalEntityValues,
            ),
          ).called(1);

          // cleanup
        },
      );
    });

    group(
      ".loadMatch()",
      () {
        // call remote source with expected arguments
        test(
          "given matchId is provided"
          "when .loadMatch() is called"
          "then should call MatchesRemoteDataSource.getMatch() with expected arguments",
          () async {
            // setup
            final testMatchRemoteEntity =
                generateTestMatchRemoteEntities(count: 1).first;

            when(() => matchesRemoteDataSource.getMatch(
                    matchId: any(named: "matchId")))
                .thenAnswer((_) async => testMatchRemoteEntity);
            when(() => matchesLocalDataSource.storeMatch(
                  matchValue: any(named: "matchValue"),
                )).thenAnswer((invocation) async => testMatchRemoteEntity.id);

            // given
            const matchId = 1;

            // when
            await matchesRepository.loadMatch(
              matchId: matchId,
            );

            // then
            verify(
              () => matchesRemoteDataSource.getMatch(
                matchId: matchId,
              ),
            ).called(1);

            // cleanup
          },
        );

        // call local source with expected arguments
        test(
          "given remote match entity is successfully retrieved"
          "when .loadMatch() is called"
          "then should call MatchesLocalDataSource.storeMatch() with expected arguments",
          () async {
            // setup
            final testMatchRemoteEntity =
                generateTestMatchRemoteEntities(count: 1).first;

            when(() => matchesRemoteDataSource.getMatch(
                    matchId: any(named: "matchId")))
                .thenAnswer((_) async => testMatchRemoteEntity);
            when(() => matchesLocalDataSource.storeMatch(
                  matchValue: any(named: "matchValue"),
                )).thenAnswer((invocation) async => testMatchRemoteEntity.id);

            // given
            const matchId = 1;

            // when
            await matchesRepository.loadMatch(
              matchId: matchId,
            );

            // then
            final expectedMatchLocalEntityValue = MatchLocalEntityValue(
              id: testMatchRemoteEntity.id,
              dateAndTime: testMatchRemoteEntity.dateAndTime,
              title: testMatchRemoteEntity.title,
              location: testMatchRemoteEntity.location,
              description: testMatchRemoteEntity.description,
            );

            verify(
              () => matchesLocalDataSource.storeMatch(
                matchValue: expectedMatchLocalEntityValue,
              ),
            ).called(1);

            // cleanup
          },
        );
      },
    );

    group(".loadPlayerMatchesOverview", () {
      // should call data remote source with expected arguments
      test(
        "given playerId is provided"
        "when .loadPlayerMatchesOverview() is called"
        "then should call MatchesRemoteDataSource.getPlayerMatchesOverview() with expected arguments",
        () async {
          // setup
          final testMatchesRemoteEntities =
              generateTestMatchRemoteEntities(count: 3);

          when(
            () => matchesRemoteDataSource.getPlayerMatchesOverview(
              playerId: any(named: "playerId"),
            ),
          ).thenAnswer(
            (_) async => testMatchesRemoteEntities,
          );
          when(
            () => matchesLocalDataSource.storeMatches(
              matchValues: any(named: "matchValues"),
            ),
          ).thenAnswer((invocation) async {});

          // given
          const playerId = 1;

          // when
          await matchesRepository.loadPlayerMatchesOverview(
            playerId: playerId,
          );

          // then
          verify(() => matchesRemoteDataSource.getPlayerMatchesOverview(
              playerId: playerId)).called(1);

          // cleanup
        },
      );

      // should call data local source with expected arguments
      test(
        "given remote match entities are successfully retrieved"
        "when .loadPlayerMatchesOverview() is called"
        "then should call MatchesLocalDataSource.storeMatches() with expected arguments",
        () async {
          // setup
          final testMatchesRemoteEntities =
              generateTestMatchRemoteEntities(count: 3);

          when(
            () => matchesRemoteDataSource.getPlayerMatchesOverview(
              playerId: any(named: "playerId"),
            ),
          ).thenAnswer(
            (_) async => testMatchesRemoteEntities,
          );
          when(
            () => matchesLocalDataSource.storeMatches(
              matchValues: any(named: "matchValues"),
            ),
          ).thenAnswer((invocation) async {});

          // given
          const playerId = 1;

          // when
          await matchesRepository.loadPlayerMatchesOverview(
            playerId: playerId,
          );

          // then
          final expectedMatchLocalEntityValues = testMatchesRemoteEntities
              .map((e) => MatchLocalEntityValue(
                    id: e.id,
                    dateAndTime: e.dateAndTime,
                    title: e.title,
                    location: e.location,
                    description: e.description,
                  ))
              .toList();

          verify(
            () => matchesLocalDataSource.storeMatches(
              matchValues: expectedMatchLocalEntityValues,
            ),
          ).called(1);

          // cleanup
        },
      );

// should
    });
  });
}

class _MockMatchesLocalDataSource extends Mock
    implements MatchesLocalDataSource {}

class _MockMatchesRemoteDataSource extends Mock
    implements MatchesRemoteDataSource {}

class _FakeMatchCreateDataValue extends Fake implements MatchCreateDataValue {}

// class _FakeMatchRemoteEntity extends Fake implements MatchRemoteEntity {}
class _FakeMatchLocalEntityValue extends Fake
    implements MatchLocalEntityValue {}

class _FakeSearchMatchesFilterValue extends Fake
    implements SearchMatchesFilterValue {}
// --------- TODO: OLD -------------

// import 'package:five_on_4_mobile/src/features/auth/data/data_sources/auth_status/auth_status_data_source.dart';
// import 'package:five_on_4_mobile/src/features/auth/domain/exceptions/auth_exceptions.dart';
// import 'package:five_on_4_mobile/src/features/matches/data/data_sources/matches_local/matches_local_data_source.dart';
// import 'package:five_on_4_mobile/src/features/matches/data/data_sources/matches_remote/matches_remote_data_source.dart';
// import 'package:five_on_4_mobile/src/features/matches/data/entities/match_local/match_local_entity.dart';
// import 'package:five_on_4_mobile/src/features/matches/data/repositories/matches/matches_repository_impl.dart';
// import 'package:five_on_4_mobile/src/features/matches/domain/values/match_create_data_value.dart';
// import 'package:five_on_4_mobile/src/features/matches/utils/converters/matches_converter.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';

// import '../../../../../../../utils/data/test_entities.dart';
// import '../../../../../../../utils/data/test_values.dart';
// import '../../../../../../../utils/matchers/throws_exception_with_message.dart';

// void main() {
//   final matchesLocalDataSource = _MockMatchesLocalDataSource();
//   final matchesRemoteDataSource = _MockMatchesRemoteDataSource();
//   final authStatusDataSource = _MockAuthStatusDataSource();

//   final testRemoteMatches = getTestMatchRemoteEntities();
//   final testLocalMatches = MatchesConverter.fromRemoteEntitiesToLocalEntities(
//       matchesRemote: testRemoteMatches);
//   final testModelMatches = MatchesConverter.fromLocalEntitiesToModels(
//     matchesLocal: testLocalMatches,
//   );

//   final matchesRepository = MatchesRepositoryImpl(
//     matchesLocalDataSource: matchesLocalDataSource,
//     matchesRemoteDataSource: matchesRemoteDataSource,
//     authStatusDataSource: authStatusDataSource,
//   );

//   setUpAll(
//     () {
//       registerFallbackValue(
//         _FakeMatchLocalEntity(),
//       );
//       registerFallbackValue(
//         _FakeMatchCreateDataValue(),
//       );
//     },
//   );

//   tearDown(() {
//     reset(matchesLocalDataSource);
//     reset(matchesRemoteDataSource);
//     reset(authStatusDataSource);
//   });

//   group(
//     "MatchesRepository",
//     () {
//       group(
//         ".createMatch()",
//         () {
//           test(
//             "given valid match data"
//             "when call .createMatch()"
//             "then should return expected match id",
//             () async {
//               final matchData = getTestMatchCreateValues(count: 1).first;

//               // Given
//               const matchId = 1;
//               when(
//                 () => matchesRemoteDataSource.createMatch(
//                   matchData: any(named: "matchData"),
//                 ),
//               ).thenAnswer(
//                 (_) async => matchId,
//               );

//               // When
//               final id = await matchesRepository.createMatch(
//                 matchData: matchData,
//               );

//               // Then
//               expect(id, equals(matchId));
//             },
//           );
//         },
//       );

//       group(
//         ".getMatch()",
//         () {
//           test(
//             "given a match id"
//             "when call .getMatch()"
//             "then should return expected result",
//             () async {
//               // setup
//               final matchLocalEntity = testLocalMatches.first;
//               final matchModel = MatchesConverter.fromLocalEntityToModel(
//                 matchLocal: matchLocalEntity,
//               );

//               when(
//                 () => matchesLocalDataSource.getMatch(
//                   matchId: any(named: "matchId"),
//                 ),
//               ).thenAnswer((invocation) async => matchLocalEntity);

//               // given
//               final matchId = matchLocalEntity.id;

//               // when
//               final result = await matchesRepository.getMatch(
//                 matchId: matchId,
//               );

//               // then
//               expect(result, equals(matchModel));
//             },
//           );

//           test(
//             "given a match id"
//             "when call .getMatch()"
//             "then should call local data source to retrieve the match",
//             () {
//               // setup
//               final matchLocalEntity = testLocalMatches.first;

//               when(
//                 () => matchesLocalDataSource.getMatch(
//                   matchId: any(named: "matchId"),
//                 ),
//               ).thenAnswer(
//                 (invocation) async => matchLocalEntity,
//               );

//               // given
//               final matchId = matchLocalEntity.id;

//               // when
//               matchesRepository.getMatch(matchId: matchId);

//               // then
//               verify(
//                 () => matchesLocalDataSource.getMatch(
//                   matchId: matchId,
//                 ),
//               ).called(1);
//             },
//           );
//         },
//       );
//       group(
//         ".loadMatch()",
//         () {
//           test(
//             "given a match id"
//             "when call .loadMatch()"
//             "then should ping remote data source to retrieve match",
//             () async {
//               final remoteEntityMatch = testRemoteMatches.first;

//               // given
//               final matchId = remoteEntityMatch.id;
//               when(
//                 () => matchesRemoteDataSource.getMatch(
//                   matchId: matchId,
//                 ),
//               ).thenAnswer(
//                 (_) async => remoteEntityMatch,
//               );

//               when(
//                 () => matchesLocalDataSource.saveMatch(
//                   match: any(named: "match"),
//                 ),
//               ).thenAnswer(
//                 (invocation) async => matchId,
//               );

//               // when
//               await matchesRepository.loadMatch(matchId: matchId);

//               // then
//               verify(
//                 () => matchesRemoteDataSource.getMatch(
//                   matchId: matchId,
//                 ),
//               ).called(1);
//             },
//           );

//           test(
//             "given a match id"
//             "when call .loadMatch()"
//             "then should ping local data source to store the match",
//             () async {
//               final remoteEntityMatch = testRemoteMatches.first;
//               final localEntityMatch =
//                   MatchesConverter.fromRemoteEntityToLocalEntity(
//                       matchRemote: remoteEntityMatch);

//               // given
//               final matchId = remoteEntityMatch.id;
//               when(
//                 () => matchesRemoteDataSource.getMatch(
//                   matchId: matchId,
//                 ),
//               ).thenAnswer(
//                 (_) async => remoteEntityMatch,
//               );

//               when(
//                 () => matchesLocalDataSource.saveMatch(
//                   match: any(named: "match"),
//                 ),
//               ).thenAnswer(
//                 (invocation) async => matchId,
//               );

//               // when
//               await matchesRepository.loadMatch(matchId: matchId);

//               // then
//               verify(
//                 () => matchesLocalDataSource.saveMatch(
//                   match: localEntityMatch,
//                 ),
//               ).called(1);
//             },
//           );

//           test(
//             "given a match is loaded"
//             "when .loadMatch() returns"
//             "then should return expected match id ",
//             () async {
//               final remoteEntityMatch = testRemoteMatches.first;

//               final matchId = remoteEntityMatch.id;
//               when(
//                 () => matchesRemoteDataSource.getMatch(
//                   matchId: matchId,
//                 ),
//               ).thenAnswer(
//                 (_) async => remoteEntityMatch,
//               );

//               when(
//                 () => matchesLocalDataSource.saveMatch(
//                   match: any(named: "match"),
//                 ),
//               ).thenAnswer(
//                 (invocation) async => matchId,
//               );

//               // given / when
//               final result =
//                   await matchesRepository.loadMatch(matchId: matchId);

//               // then
//               expect(result, equals(matchId));
//             },
//           );
//         },
//       );
//       group(
//         ".loadMyMatches",
//         () {
//           setUp(
//             () {
//               // remote data source
//               when(
//                 () => matchesRemoteDataSource.getPlayerInitialMatches(),
//               ).thenAnswer(
//                 (_) async => testRemoteMatches,
//               );

//               // local data source
//               when(
//                 () => matchesLocalDataSource.saveMatches(
//                   matches: any(named: "matches"),
//                 ),
//               ).thenAnswer(
//                 (invocation) async =>
//                     testRemoteMatches.map((e) => e.id).toList(),
//               );
//             },
//           );
//           test(
//             "given nothing in particular"
//             "when .loadMyMatches() is called"
//             "should ping remote data source to retrive matches",
//             () async {
//               await matchesRepository.loadMyMatches();

//               verify(
//                 () => matchesRemoteDataSource.getPlayerInitialMatches(),
//               ).called(1);
//             },
//           );

//           test(
//             "given nothing in particular"
//             "when .loadMyMatches() is called"
//             "should pass remote matches retrieved from remote data source to the local data source",
//             () async {
//               await matchesRepository.loadMyMatches();

//               verify(
//                 () => matchesLocalDataSource.saveMatches(
//                   matches: testLocalMatches,
//                 ),
//               ).called(1);
//             },
//           );
//         },
//       );
//     },
//   );

//   group(
//     ".getMyTodayMatches",
//     () {
//       test(
//         "given a logged in player exists "
//         "when getMyTodayMatches()"
//         "should return today's matches retrieved from the local data source",
//         () async {
//           when(
//             () => matchesLocalDataSource.getTodayMatchesForPlayer(
//               playerId: any(named: "playerId"),
//             ),
//           ).thenAnswer(
//             (invocation) async => testLocalMatches,
//           );
//           // auth status data source
//           when(
//             () => authStatusDataSource.playerId,
//           ).thenReturn(1);

//           final matches = await matchesRepository.getMyTodayMatches();

//           expect(matches, equals(testModelMatches));
//         },
//       );

//       // throw exception when no logged in player exists
//       test(
//         "given a logged in player DOES NOT exist "
//         "when getMyTodayMatches()"
//         "should throw AuthStatusNotLoggedInException",
//         () async {
//           // Given
//           when(
//             () => authStatusDataSource.playerId,
//           ).thenReturn(null);

//           // When & Then
//           expect(
//             () => matchesRepository.getMyTodayMatches(),
//             throwsExceptionWithMessage<AuthNotLoggedInException>(
//               "User is not logged in",
//             ),
//           );
//         },
//       );
//     },
//   );

//   group(
//     ".getMyPastMatches",
//     () {
//       test(
//         "given a logged in player exists "
//         "when getMyPastMatches()"
//         "should return past matches retrieved from the local data source",
//         () async {
//           when(
//             () => matchesLocalDataSource.getPastMatchesForPlayer(
//               playerId: any(named: "playerId"),
//             ),
//           ).thenAnswer(
//             (invocation) async => testLocalMatches,
//           );
//           // auth status data source
//           when(
//             () => authStatusDataSource.playerId,
//           ).thenReturn(1);

//           final matches = await matchesRepository.getMyPastMatches();

//           expect(matches, equals(testModelMatches));
//         },
//       );

//       // throw exception when no logged in player exists
//       test(
//         "given a logged in player DOES NOT exist "
//         "when getMyPastMatches()"
//         "should throw AuthStatusNotLoggedInException",
//         () async {
//           // auth status data source

//           // Given
//           when(
//             () => authStatusDataSource.playerId,
//           ).thenReturn(null);

//           // When & Then
//           expect(
//             () => matchesRepository.getMyPastMatches(),
//             throwsExceptionWithMessage<AuthNotLoggedInException>(
//               "User is not logged in",
//             ),
//           );
//         },
//       );
//     },
//   );

//   group(
//     ".getMyUpcomingMatches",
//     () {
//       test(
//         "given a logged in player exists "
//         "when getMyUpcomingMatches()"
//         "should return upcoming matches retrieved from the local data source",
//         () async {
//           when(
//             () => matchesLocalDataSource.getUpcomingMatchesForPlayer(
//               playerId: any(named: "playerId"),
//             ),
//           ).thenAnswer(
//             (invocation) async => testLocalMatches,
//           );
//           // auth status data source
//           when(
//             () => authStatusDataSource.playerId,
//           ).thenReturn(1);

//           final matches = await matchesRepository.getMyUpcomingMatches();

//           expect(matches, equals(testModelMatches));
//         },
//       );

//       // throw exception when no logged in player exists
//       test(
//         "given a logged in player DOES NOT exist "
//         "when getMyUpcomingMatches()"
//         "should throw AuthStatusNotLoggedInException",
//         () async {
//           // auth status data source

//           // Given
//           when(
//             () => authStatusDataSource.playerId,
//           ).thenReturn(null);

//           // When & Then
//           expect(
//             () => matchesRepository.getMyUpcomingMatches(),
//             // throwsAuthExceptionWithMessage(
//             //   "User is not logged in",
//             // ),
//             throwsExceptionWithMessage<AuthNotLoggedInException>(
//               "User is not logged in",
//             ),
//           );
//         },
//       );
//     },
//   );
// }

// class _FakeMatchLocalEntity extends Fake implements MatchLocalEntity {}

// class _FakeMatchCreateDataValue extends Fake implements MatchCreateDataValue {}

// class _MockMatchesLocalDataSource extends Mock
//     implements MatchesLocalDataSource {}

// class _MockMatchesRemoteDataSource extends Mock
//     implements MatchesRemoteDataSource {}

// class _MockAuthStatusDataSource extends Mock implements AuthStatusDataSource {}

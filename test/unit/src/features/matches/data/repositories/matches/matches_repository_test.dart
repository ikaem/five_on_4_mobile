import 'package:five_on_4_mobile/src/features/auth/data/data_sources/auth_status/auth_status_data_source.dart';
import 'package:five_on_4_mobile/src/features/matches/data/data_sources/matches_local/matches_local_data_source.dart';
import 'package:five_on_4_mobile/src/features/matches/data/data_sources/matches_remote/matches_remote_data_source.dart';
import 'package:five_on_4_mobile/src/features/matches/data/entities/match_remote/match_local/match_local_entity.dart';
import 'package:five_on_4_mobile/src/features/matches/data/repositories/matches/matches_repository_impl.dart';
import 'package:five_on_4_mobile/src/features/matches/utils/converters/matches_converter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../../../utils/data/test_entities.dart';
import '../../../../../../../utils/matchers/throws_auth_exception_with_message.dart';

void main() {
  final matchesLocalDataSource = _MockMatchesLocalDataSource();
  final matchesRemoteDataSource = _MockMatchesRemoteDataSource();
  final authStatusDataSource = _MockAuthStatusDataSource();

  final testRemoteMatches = getTestMatchRemoteEntities();
  final testLocalMatches = MatchesConverter.fromRemoteEntitiesToLocalEntities(
      matchesRemote: testRemoteMatches);
  final testModelMatches = MatchesConverter.fromLocalEntitiesToModels(
    matchesLocal: testLocalMatches,
  );

  final matchesRepository = MatchesRepositoryImpl(
    matchesLocalDataSource: matchesLocalDataSource,
    matchesRemoteDataSource: matchesRemoteDataSource,
    authStatusDataSource: authStatusDataSource,
  );

  setUpAll(
    () {
      registerFallbackValue(
        _FakeMatchLocalEntity(),
      );
    },
  );

  tearDown(() {
    reset(matchesLocalDataSource);
    reset(matchesRemoteDataSource);
    reset(authStatusDataSource);
  });

  group(
    "MatchesRepository",
    () {
      group(
        ".loadMatch",
        () {
          test(
            "given a match id"
            "when call .loadMatch()"
            "then should ping remote data source to retrieve match",
            () async {
              final remoteEntityMatch = testRemoteMatches.first;

              // given
              final matchId = remoteEntityMatch.id;
              when(
                () => matchesRemoteDataSource.getMatch(
                  matchId: matchId,
                ),
              ).thenAnswer(
                (_) async => remoteEntityMatch,
              );

              // when
              await matchesRepository.loadMatch(matchId: matchId);

              // then
              verify(
                () => matchesRemoteDataSource.getMatch(
                  matchId: matchId,
                ),
              ).called(1);
            },
          );

          test(
            "given a match id"
            "when call .loadMatch()"
            "then should ping local data source to store the match",
            () async {
              final remoteEntityMatch = testRemoteMatches.first;
              final localEntityMatch =
                  MatchesConverter.fromRemoteEntityToLocalEntity(
                      matchRemote: remoteEntityMatch);

              // given
              final matchId = remoteEntityMatch.id;
              when(
                () => matchesRemoteDataSource.getMatch(
                  matchId: matchId,
                ),
              ).thenAnswer(
                (_) async => remoteEntityMatch,
              );

              when(
                () => matchesLocalDataSource.saveMatch(
                  match: any(named: "match"),
                ),
              ).thenAnswer(
                (invocation) async => matchId,
              );

              // when
              await matchesRepository.loadMatch(matchId: matchId);

              // then
              verify(
                () => matchesLocalDataSource.saveMatch(
                  match: localEntityMatch,
                ),
              ).called(1);
            },
          );
        },
      );
      group(
        ".loadMyMatches",
        () {
          setUp(
            () {
              // remote data source
              when(
                () => matchesRemoteDataSource.getPlayerInitialMatches(),
              ).thenAnswer(
                (_) async => testRemoteMatches,
              );

              // local data source
              when(
                () => matchesLocalDataSource.saveMatches(
                  matches: any(named: "matches"),
                ),
              ).thenAnswer(
                (invocation) async =>
                    testRemoteMatches.map((e) => e.id).toList(),
              );
            },
          );
          test(
            "given nothing in particular"
            "when .loadMyMatches() is called"
            "should ping remote data source to retrive matches",
            () async {
              await matchesRepository.loadMyMatches();

              verify(
                () => matchesRemoteDataSource.getPlayerInitialMatches(),
              ).called(1);
            },
          );

          test(
            "given nothing in particular"
            "when .loadMyMatches() is called"
            "should pass remote matches retrieved from remote data source to the local data source",
            () async {
              await matchesRepository.loadMyMatches();

              verify(
                () => matchesLocalDataSource.saveMatches(
                  matches: testLocalMatches,
                ),
              ).called(1);
            },
          );
        },
      );
    },
  );

  group(
    ".getMyTodayMatches",
    () {
      test(
        "given a logged in player exists "
        "when getMyTodayMatches()"
        "should return today's matches retrieved from the local data source",
        () async {
          when(
            () => matchesLocalDataSource.getTodayMatchesForPlayer(
              playerId: any(named: "playerId"),
            ),
          ).thenAnswer(
            (invocation) async => testLocalMatches,
          );
          // auth status data source
          when(
            () => authStatusDataSource.playerId,
          ).thenReturn(null);

          final matches = await matchesRepository.getMyTodayMatches();

          expect(matches, equals(testModelMatches));
        },
      );

      // throw exception when no logged in player exists
      test(
        "given a logged in player DOES NOT exist "
        "when getMyTodayMatches()"
        "should throw AuthStatusNotLoggedInException",
        () async {
          // auth status data source

          // Given
          when(
            () => authStatusDataSource.playerId,
          ).thenReturn(1);

          // When & Then
          expect(
            () => matchesRepository.getMyTodayMatches(),
            throwsAuthExceptionWithMessage(
              "User is not logged in",
            ),
          );
        },
      );
    },
  );

  group(
    ".getMyPastMatches",
    () {
      test(
        "given a logged in player exists "
        "when getMyPastMatches()"
        "should return past matches retrieved from the local data source",
        () async {
          when(
            () => matchesLocalDataSource.getPastMatchesForPlayer(
              playerId: any(named: "playerId"),
            ),
          ).thenAnswer(
            (invocation) async => testLocalMatches,
          );
          // auth status data source
          when(
            () => authStatusDataSource.playerId,
          ).thenReturn(1);

          final matches = await matchesRepository.getMyPastMatches();

          expect(matches, equals(testModelMatches));
        },
      );

      // throw exception when no logged in player exists
      test(
        "given a logged in player DOES NOT exist "
        "when getMyPastMatches()"
        "should throw AuthStatusNotLoggedInException",
        () async {
          // auth status data source

          // Given
          when(
            () => authStatusDataSource.playerId,
          ).thenReturn(null);

          // When & Then
          expect(
            () => matchesRepository.getMyPastMatches(),
            throwsAuthExceptionWithMessage(
              "User is not logged in",
            ),
          );
        },
      );
    },
  );

  group(
    ".getMyUpcomingMatches",
    () {
      test(
        "given a logged in player exists "
        "when getMyUpcomingMatches()"
        "should return upcoming matches retrieved from the local data source",
        () async {
          when(
            () => matchesLocalDataSource.getUpcomingMatchesForPlayer(
              playerId: any(named: "playerId"),
            ),
          ).thenAnswer(
            (invocation) async => testLocalMatches,
          );
          // auth status data source
          when(
            () => authStatusDataSource.playerId,
          ).thenReturn(1);

          final matches = await matchesRepository.getMyUpcomingMatches();

          expect(matches, equals(testModelMatches));
        },
      );

      // throw exception when no logged in player exists
      test(
        "given a logged in player DOES NOT exist "
        "when getMyUpcomingMatches()"
        "should throw AuthStatusNotLoggedInException",
        () async {
          // auth status data source

          // Given
          when(
            () => authStatusDataSource.playerId,
          ).thenReturn(null);

          // When & Then
          expect(
            () => matchesRepository.getMyUpcomingMatches(),
            throwsAuthExceptionWithMessage(
              "User is not logged in",
            ),
          );
        },
      );
    },
  );
}

class _FakeMatchLocalEntity extends Fake implements MatchLocalEntity {}

class _MockMatchesLocalDataSource extends Mock
    implements MatchesLocalDataSource {}

class _MockMatchesRemoteDataSource extends Mock
    implements MatchesRemoteDataSource {}

class _MockAuthStatusDataSource extends Mock implements AuthStatusDataSource {}

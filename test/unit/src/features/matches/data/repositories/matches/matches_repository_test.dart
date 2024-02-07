import 'package:five_on_4_mobile/src/features/auth/data/data_sources/auth_status/auth_status_data_source.dart';
import 'package:five_on_4_mobile/src/features/matches/data/data_sources/matches_local/matches_local_data_source.dart';
import 'package:five_on_4_mobile/src/features/matches/data/data_sources/matches_remote/matches_remote_data_source.dart';
import 'package:five_on_4_mobile/src/features/matches/data/repositories/matches/matches_repository_impl.dart';
import 'package:five_on_4_mobile/src/features/matches/utils/converters/matches_converter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../../../utils/data/test_entities.dart';

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

  tearDown(() {
    reset(matchesLocalDataSource);
    reset(matchesRemoteDataSource);
    reset(authStatusDataSource);
  });

  group(
    "MatchesRepository",
    () {
      group(
        ".loadMyMatches",
        () {
          setUp(
            () {
              // remote data source
              when(
                () => matchesRemoteDataSource.getMyFollowingMatches(),
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
                () => matchesRemoteDataSource.getMyFollowingMatches(),
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
          ).thenReturn(1);

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
          when(
            () => authStatusDataSource.playerId,
          ).thenReturn(null);

          final matches = await matchesRepository.getMyTodayMatches();
        },
      );
    },
  );
}

class _MockMatchesLocalDataSource extends Mock
    implements MatchesLocalDataSource {}

class _MockMatchesRemoteDataSource extends Mock
    implements MatchesRemoteDataSource {}

class _MockAuthStatusDataSource extends Mock implements AuthStatusDataSource {}

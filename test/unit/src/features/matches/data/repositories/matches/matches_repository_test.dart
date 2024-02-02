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

  final testMatches = getTestMatchRemoteEntities();

  final matchesRepository = MatchesRepositoryImpl(
    matchesLocalDataSource: matchesLocalDataSource,
    matchesRemoteDataSource: matchesRemoteDataSource,
  );

  setUp(() {
    // remote data source
    when(
      () => matchesRemoteDataSource.getMyFollowingMatches(),
    ).thenAnswer(
      (_) async => testMatches,
    );

    // local data source
    when(() =>
            matchesLocalDataSource.saveMatches(matches: any(named: "matches")))
        .thenAnswer(
            (invocation) async => testMatches.map((e) => e.id).toList());
  });

  tearDown(() {
    reset(matchesLocalDataSource);
    reset(matchesRemoteDataSource);
  });

  group(
    "MatchesRepository",
    () {
      group(
        ".loadMyMatches",
        () {
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
              final convertedMatchLocalEntities =
                  MatchesConverter.fromRemoteEntitiesToLocalEntities(
                      matchesRemote: testMatches);

              await matchesLocalDataSource.saveMatches(
                matches: convertedMatchLocalEntities,
              );

              verify(
                () => matchesLocalDataSource.saveMatches(
                  matches: convertedMatchLocalEntities,
                ),
              ).called(1);
            },
          );
        },
      );
    },
  );
}

class _MockMatchesLocalDataSource extends Mock
    implements MatchesLocalDataSource {}

class _MockMatchesRemoteDataSource extends Mock
    implements MatchesRemoteDataSource {}

import 'package:five_on_4_mobile/src/features/matches/data/data_sources/matches_local/matches_local_data_source.dart';
import 'package:five_on_4_mobile/src/features/matches/data/data_sources/matches_remote/matches_remote_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../../../utils/data/test_entities.dart';

void main() {
  final matchesLocalDataSource = _MockMatchesLocalDataSource();
  final matchesRemoteDataSource = _MockMatchesRemoteDataSource();

  final matchesRepository = MatchesRepository(
    matchesLocalDataSource: matchesLocalDataSource,
    matchesRemoteDataSource: matchesRemoteDataSource,
  );

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
              final testMatches = getTestMatchRemoteEntities();
              when(
                () => matchesRemoteDataSource.getMyFollowingMatches(),
              ).thenAnswer(
                (_) async => testMatches,
              );

              await matchesRepository.loadMyMatches();

              verify(
                () => matchesRemoteDataSource.getMyFollowingMatches(),
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

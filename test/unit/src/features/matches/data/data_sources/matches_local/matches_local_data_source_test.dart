import 'package:five_on_4_mobile/src/wrappers/libraries/isar/isar_wrapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  final isarWrapper = _MockIsarWrapper();

  final matchesLocalDataSource = MatchesLocalDataSourceImpl(
    isarWrapper: isarWrapper,
  );

  group(
    "MatchesLocalDataSource",
    () {
      group(
        ".saveMatches()",
        () {
          test(
            "given a list of [MatchLocalEntity]s"
            "when '.saveMatches() is called"
            "should save the matches to the database",
            () async {
              final testMatches = getTestMatchLocalEntities(count: 3);
              final ids = testMatches.map((match) => match.id).toList();

              when(
                () => isarWrapper.putEntities(
                  entities: any(named: "entities"),
                ),
              ).thenAnswer(
                (invocation) => ids,
              );

              await matchesLocalDataSource.saveMatches(matches: testMatches);

              verify(
                () => isarWrapper.putEntities(
                  entities: testMatches,
                ),
              ).called(1);
            },
          );
        },
      );
    },
  );
}

class _MockIsarWrapper extends Mock implements IsarWrapper {}

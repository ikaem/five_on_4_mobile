import 'package:five_on_4_mobile/src/features/matches/domain/repositories/matches/matches_repository.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/get_match/get_match_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../../../utils/data/test_models.dart';

void main() {
  final matchesRepository = _MockMatchesRepository();
  final getMatchUseCase = GetMatchUseCase(
    matchesRepository: matchesRepository,
  );

  final match = getTestMatchModel();

  setUp(() {
    when(
      () => matchesRepository.getMatch(
        matchId: any(named: "matchId"),
      ),
    ).thenAnswer(
      (_) async => match,
    );
  });

  tearDown(() {
    reset(matchesRepository);
  });

  group(
    "$GetMatchUseCase",
    () {
      group(
        ".call()",
        () {
          test(
            "given a matchId"
            "when when call() is called"
            "then should return expected value",
            () async {
              final result = await getMatchUseCase(
                matchId: match.id,
              );

              expect(
                result,
                match,
              );
            },
          );

          test(
            "given a matchId"
            "when call() is called"
            "should call repository to get match",
            () async {
              await getMatchUseCase(
                matchId: match.id,
              );

              verify(
                () => matchesRepository.getMatch(
                  matchId: match.id,
                ),
              ).called(1);
            },
          );
        },
      );
    },
  );
}

class _MockMatchesRepository extends Mock implements MatchesRepository {}

import 'package:five_on_4_mobile/src/features/matches/domain/repository_interfaces/matches_repository.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/load_match/load_match_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  final matchesRepository = _MockMatchesRepository();
  final loadMatchUseCase = LoadMatchUseCase(
    matchesRepository: matchesRepository,
  );

  const matchId = 1;

  setUp(() {
    when(
      () => matchesRepository.loadMatch(
        matchId: any(named: "matchId"),
      ),
    ).thenAnswer(
      (_) async => matchId,
    );
  });

  tearDown(() {
    reset(matchesRepository);
  });

  group(
    "LoadMatchUseCase",
    () {
      group(
        ".call()",
        () {
          test(
            "given a matchId"
            "when when call() is called"
            "then should return expected value",
            () async {
              final result = await loadMatchUseCase(
                matchId: matchId,
              );

              expect(
                result,
                matchId,
              );
            },
          );

          test(
            "given a matchId"
            "when call() is called"
            "should call repository to load match",
            () async {
              await loadMatchUseCase(
                matchId: matchId,
              );

              verify(
                () => matchesRepository.loadMatch(
                  matchId: matchId,
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

import 'package:five_on_4_mobile/src/features/matches/domain/repositories/matches/matches_repository.dart';
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
          // TODO not needed most likely
          // test(
          //   "given a matchId"
          //   "when when call() is called"
          //   // "then should return expected value",
          //   "then should call MatchesRepository.loadMatch() with expected arguments",
          //   () async {
          //     final result = await loadMatchUseCase(
          //       matchId: matchId,
          //     );

          //     expect(
          //       result,
          //       matchId,
          //     );
          //   },
          // );

          test(
            "given a matchId"
            "when call() is called"
            "then should call MatchesRepository.loadMatch() with expected arguments",
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

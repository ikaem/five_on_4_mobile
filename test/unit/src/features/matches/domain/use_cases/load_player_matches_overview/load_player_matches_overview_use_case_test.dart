import 'package:five_on_4_mobile/src/features/matches/domain/repositories/matches/matches_repository.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/load_player_matches_overview/load_player_matches_overview_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  final matchesRepository = _MockMatchesRepository();

  // tested class
  final useCase = LoadPlayerMatchesOverviewUseCase(
    matchesRepository: matchesRepository,
  );

  tearDown(() {
    reset(matchesRepository);
  });

  group("$LoadPlayerMatchesOverviewUseCase", () {
    group(".call()", () {
      test(
        "given playerId"
        "when .call() is called"
        "then should call MatchesRepository.loadPlayerMatchesOverview()",
        () async {
          // setup

          // given
          when(
            () => matchesRepository.loadPlayerMatchesOverview(
              playerId: any(named: "playerId"),
            ),
          ).thenAnswer(
            (_) async {},
          );

          // when
          await useCase.call(
            playerId: 1,
          );

          // then
          verify(
            () => matchesRepository.loadPlayerMatchesOverview(
              playerId: 1,
            ),
          ).called(1);

          // cleanup
        },
      );
    });
  });
}

class _MockMatchesRepository extends Mock implements MatchesRepository {}

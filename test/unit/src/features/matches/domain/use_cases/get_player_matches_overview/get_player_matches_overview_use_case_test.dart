import 'package:five_on_4_mobile/src/features/matches/domain/models/match/match_model.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/repositories/matches/matches_repository.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/get_player_matches_overview/get_player_matches_overview_use_case.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/values/player_match_models_overview_value.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../../../utils/data/test_entities.dart';

void main() {
  final matchesRepository = _MockMatchesRepository();

// tested class
  final useCase =
      GetPlayerMatchesOverviewUseCase(matchesRepository: matchesRepository);

  tearDown(() {
    reset(matchesRepository);
  });

  group("$GetPlayerMatchesOverviewUseCase", () {
    group(".call()", () {
      test(
        "given MatchesRepository returns PlayerMatchModelOverviewValue"
        "when .call() is called"
        "then should return expected value",
        () async {
          // setup
          final playerMatchModelsOverview = PlayerMatchModelsOverviewValue(
            upcomingMatches: generateTestMatchRemoteEntities(count: 3)
                .map(
                  (e) => MatchModel(
                    id: e.id,
                    title: e.title,
                    dateAndTime:
                        DateTime.fromMillisecondsSinceEpoch(e.dateAndTime),
                    location: e.location,
                    description: e.description,
                  ),
                )
                .toList(),
            todayMatches: generateTestMatchRemoteEntities(count: 3)
                .map(
                  (e) => MatchModel(
                    id: e.id,
                    title: e.title,
                    dateAndTime:
                        DateTime.fromMillisecondsSinceEpoch(e.dateAndTime),
                    location: e.location,
                    description: e.description,
                  ),
                )
                .toList(),
            pastMatches: generateTestMatchRemoteEntities(count: 3)
                .map(
                  (e) => MatchModel(
                    id: e.id,
                    title: e.title,
                    dateAndTime:
                        DateTime.fromMillisecondsSinceEpoch(e.dateAndTime),
                    location: e.location,
                    description: e.description,
                  ),
                )
                .toList(),
          );

          // given
          when(
            () => matchesRepository.getPlayerMatchesOverview(
              playerId: any(named: "playerId"),
            ),
          ).thenAnswer(
            (_) async => playerMatchModelsOverview,
          );

          // when
          final result = await useCase.call(
            playerId: 1,
          );

          // then
          expect(
            result,
            equals(playerMatchModelsOverview),
          );

          // cleanup
        },
      );
    });
  });
}

class _MockMatchesRepository extends Mock implements MatchesRepository {}

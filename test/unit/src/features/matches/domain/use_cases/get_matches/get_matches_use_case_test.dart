import 'package:five_on_4_mobile/src/features/matches/domain/models/match/match_model.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/repositories/matches/matches_repository.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/get_matches/get_matches_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  final MatchesRepository matchesRepository = _MockMatchesRepository();

  // tested class
  final GetMatchesUseCase useCase = GetMatchesUseCase(
    matchesRepository: matchesRepository,
  );

  tearDown(() {
    reset(matchesRepository);
  });

  group("$GetMatchesUseCase", () {
    group(".call()", () {
      test(
        "given MatchesRepository returns a list of MatchModel"
        "when .call() is called with matchIds"
        "then should return expected result",
        () async {
          // setup
          final matchModels = List.generate(
              3,
              (i) => MatchModel(
                    id: i + 1,
                    title: "title",
                    dateAndTime: DateTime.now(),
                    location: "location",
                    description: "description",
                  ));

          final matchIds = matchModels.map((e) => e.id).toList();

          // given
          when(
            () => matchesRepository.getMatches(
              matchIds: any(named: "matchIds"),
            ),
          ).thenAnswer(
            (_) async => matchModels,
          );

          // when
          final matches = await useCase(
            matchIds: matchIds,
          );

          // then
          expect(matches, matchModels);

          // cleanup
        },
      );

      test(
        "given .call() is called"
        "when MatchModels are returned"
        "then should have called MatchesRepository.getMatches() with expected arguments",
        () async {
          // setup
          final matchIds = [1, 2, 3];

          when(
            () => matchesRepository.getMatches(
              matchIds: any(named: "matchIds"),
            ),
          ).thenAnswer(
            (_) async => [],
          );

          // given
          await useCase(
            matchIds: matchIds,
          );

          // when

          // then
          verify(
            () => matchesRepository.getMatches(
              matchIds: matchIds,
            ),
          ).called(1);

          // cleanup
        },
      );
    });
  });
}

class _MockMatchesRepository extends Mock implements MatchesRepository {}

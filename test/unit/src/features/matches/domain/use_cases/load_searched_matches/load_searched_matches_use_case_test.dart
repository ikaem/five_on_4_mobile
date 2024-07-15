// TODO there is a big question whether really all results of a search should always be loaded into db?

import 'package:five_on_4_mobile/src/features/matches/data/data_sources/matches_remote/matches_remote_data_source.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/models/match/match_model.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/repositories/matches/matches_repository.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/load_searched_matches/load_searched_matches_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  final MatchesRepository matchesRepository = _MockMatchesRepository();

  // tested class
  final LoadSearchedMatchesUseCase useCase = LoadSearchedMatchesUseCase(
    matchesRepository: matchesRepository,
  );

  setUpAll(() {
    registerFallbackValue(_FakeSearchMatchesFilterValue());
  });

  tearDown(() {
    reset(matchesRepository);
  });

  group("$LoadSearchedMatchesUseCase", () {
    group(".call()", () {
      test(
        "given a SearchMatchesFilterValue"
        "when .call() is called"
        "then should return expected matche ids",
        () async {
          // setup
          final matchModesl = List.generate(
              3,
              (i) => MatchModel(
                    id: i + 1,
                    title: "title",
                    dateAndTime: DateTime.now(),
                    location: "location",
                    description: "description",
                  ));

          when(
            () => matchesRepository.loadSearchedMatches(
              filter: any(named: "filter"),
            ),
          ).thenAnswer(
            (_) async => matchModesl.map((e) => e.id).toList(),
          );

          // given
          const filter = SearchMatchesFilterValue(
            matchTitle: "title",
          );

          // when
          final ids = await useCase(
            filter: filter,
          );

          // then
          expect(ids, matchModesl.map((e) => e.id).toList());

          // cleanup
        },
      );

      test(
        "given a SearchMatchesFilterValue"
        "when .call() is called"
        "then should call MatchesRepository.loadSearchedMatches() with expected arguments",
        () async {
          // setup
          when(
            () => matchesRepository.loadSearchedMatches(
              filter: any(named: "filter"),
            ),
          ).thenAnswer(
            (_) async => [],
          );

          // given
          const filter = SearchMatchesFilterValue(
            matchTitle: "title",
          );

          // when
          await useCase(
            filter: filter,
          );

          // then
          verify(
            () => matchesRepository.loadSearchedMatches(
              filter: filter,
            ),
          ).called(1);

          // cleanup
        },
      );
    });
  });
}

class _MockMatchesRepository extends Mock implements MatchesRepository {}

class _FakeSearchMatchesFilterValue extends Fake
    implements SearchMatchesFilterValue {}

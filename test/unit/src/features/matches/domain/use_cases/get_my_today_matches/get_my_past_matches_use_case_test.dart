import 'package:five_on_4_mobile/src/features/matches/domain/repository_interfaces/matches_repository.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/get_my_past_matches/get_my_past_matches_use_case.dart';
import 'package:five_on_4_mobile/src/features/matches/utils/converters/matches_converter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../../../utils/data/test_entities.dart';

void main() {
  final matchesRepository = _MockMatchesRepository();
  final getMyPastMatchesUseCase = GetMyPastMatchesUseCase(
    matchesRepository: matchesRepository,
  );

  final testMatches = MatchesConverter.fromLocalEntitiesToModels(
    matchesLocal: getTestMatchLocalEntities(),
  );

  setUp(() {
    when(
      () => matchesRepository.getMyPastMatches(),
    ).thenAnswer(
      (_) async => testMatches,
    );
  });

  tearDown(() {
    reset(matchesRepository);
  });

  group(
    "GetMyPastMatchesUseCase",
    () {
      group(
        ".call()",
        () {
          test(
            "given use case is instantiated "
            "when call() is called"
            "should return expected matches",
            () async {
              final result = await getMyPastMatchesUseCase();

              expect(result, testMatches);
            },
          );

          // test repo is used
          test(
            "given use case is instantiated "
            "when call() is called"
            "then should call matches repository ",
            () async {
              await getMyPastMatchesUseCase();

              verify(
                () => matchesRepository.getMyPastMatches(),
              ).called(1);
            },
          );
        },
      );
    },
  );
}

class _MockMatchesRepository extends Mock implements MatchesRepository {}

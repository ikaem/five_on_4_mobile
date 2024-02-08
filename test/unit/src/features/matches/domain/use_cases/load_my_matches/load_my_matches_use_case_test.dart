import 'package:five_on_4_mobile/src/features/matches/domain/repository_interfaces/matches_repository.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/load_my_matches/load_my_matches_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  final matchesRepository = _MockMatchesRepository();
  final loadMyMatchesUseCase = LoadMyMatchesUseCase(
    matchesRepository: matchesRepository,
  );

  setUp(() {
    when(
      () => matchesRepository.loadMyMatches(),
    ).thenAnswer(
      (_) async {},
    );
  });

  tearDown(() {
    reset(matchesRepository);
  });

  group(
    "LoadMyMatchesUseCase",
    () {
      group(
        ".call()",
        () {
          test(
            "given nothing in particular"
            "when call() is called"
            "should call repository to load matches",
            () async {
              await loadMyMatchesUseCase();

              verify(
                () => matchesRepository.loadMyMatches(),
              ).called(1);
            },
          );
        },
      );
      // test repo is used
    },
  );
}

class _MockMatchesRepository extends Mock implements MatchesRepository {}

import 'package:five_on_4_mobile/src/features/matches/domain/repository_interfaces/matches_repository.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/create_match/create_match_use_case.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/values/match_create_data_value.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  final matchesRepository = _MockMatchesRepository();

  setUpAll(() {
    registerFallbackValue(_FakeMatchCreateDataValue());
  });

  tearDown(() {
    reset(matchesRepository);
  });

  group(
    "$CreateMatchUseCase",
    () {
      group(
        ".call()",
        () {
          test(
            "given match data is provided "
            "when call() is called "
            "then should return expected value",
            () async {
              // setup
              const matchId = 1;

              when(() => matchesRepository.createMatch(
                    matchData: any(named: "matchData"),
                  )).thenAnswer(
                (_) async => matchId,
              );

              // Given
              const matchData = MatchCreateDataValue(
                name: "name",
                location: "location",
                organizer: "organizer",
                description: "description",
                invitedPlayers: [],
              );

              // When
              final result = await matchesRepository.createMatch(
                matchData: matchData,
              );

              // Then
              expect(result, matchId);
            },
          );

          // should call matches repository with expected values
          test(
            "given match data is provided "
            "when call() is called "
            "then should call matches repository with expected values",
            () async {
              // setup
              const matchId = 1;

              when(() => matchesRepository.createMatch(
                    matchData: any(named: "matchData"),
                  )).thenAnswer(
                (_) async => matchId,
              );

              // Given
              const matchData = MatchCreateDataValue(
                name: "name",
                location: "location",
                organizer: "organizer",
                description: "description",
                invitedPlayers: [],
              );

              // When
              await matchesRepository.createMatch(
                matchData: matchData,
              );

              // Then
              verify(
                () => matchesRepository.createMatch(
                  matchData: matchData,
                ),
              ).called(1);
            },
          );
        },
      );
    },
  );
}

class _FakeMatchCreateDataValue extends Fake implements MatchCreateDataValue {}

class _MockMatchesRepository extends Mock implements MatchesRepository {}

// class _MockAuthRepository extends Mock implements AuthRepository {}

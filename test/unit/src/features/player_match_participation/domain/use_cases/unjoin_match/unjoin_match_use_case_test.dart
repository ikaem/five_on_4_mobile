import 'package:five_on_4_mobile/src/features/player_match_participation/domain/repositories/player_match_participation_repository.dart';
import 'package:five_on_4_mobile/src/features/player_match_participation/domain/use_cases/join_match/join_match_use_case.dart';
import 'package:five_on_4_mobile/src/features/player_match_participation/domain/use_cases/unjoin_match/unjoin_match_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  final playerMatchParticipationRepository =
      _MockPlayerMatchParticipationRepository();

  // tested class
  final useCase = UnjoinMatchUseCase(
    playerMatchParticipationRepository: playerMatchParticipationRepository,
  );

  tearDown(() {
    reset(playerMatchParticipationRepository);
  });

  group(
    "$UnjoinMatchUseCase",
    () {
      group(
        ".call()",
        () {
          test(
            "given [matchId] and [playerId] "
            "when [.call()] is called "
            "then should return expected value",
            () async {
              // setup
              const participationId = 1;

              when(() => playerMatchParticipationRepository.unjoinMatch(
                    matchId: any(named: "matchId"),
                    playerId: any(named: "playerId"),
                  )).thenAnswer(
                (_) async => participationId,
              );

              // given
              const matchId = 1;
              const playerId = 1;

              // when
              final result = await useCase.call(
                matchId: matchId,
                playerId: playerId,
              );

              // then
              expect(result, equals(participationId));

              // cleanup
            },
          );

          test(
            "given match is unjoined successfully"
            "when [.call()] is called"
            "then should call [PlayerMatchParticipationRepository.unjoinMatch()] with expected arguments",
            () async {
              // setup
              const matchId = 1;
              const playerId = 1;

              // given
              when(
                () => playerMatchParticipationRepository.unjoinMatch(
                  matchId: any(named: "matchId"),
                  playerId: any(named: "playerId"),
                ),
              ).thenAnswer(
                (_) async => 1,
              );

              // when
              await useCase.call(
                matchId: matchId,
                playerId: playerId,
              );

              // then
              verify(
                () => playerMatchParticipationRepository.unjoinMatch(
                  matchId: matchId,
                  playerId: playerId,
                ),
              ).called(1);

              // cleanup
            },
          );
        },
      );
    },
  );
}

class _MockPlayerMatchParticipationRepository extends Mock
    implements PlayerMatchParticipationRepository {}

import 'package:five_on_4_mobile/src/features/players/domain/repositories/players/players_repository.dart';
import 'package:five_on_4_mobile/src/features/players/domain/use_cases/load_player/load_player_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main(List<String> args) {
  final playersRepository = _MockPlayersRepository();

  final loadPlayerUseCase = LoadPlayerUseCase(
    playersRepository: playersRepository,
  );

  tearDown(() {
    reset(playersRepository);
  });

  group(
    "$LoadPlayerUseCase",
    () {
      group(
        ".call()",
        () {
          test(
            "given a [playerId]"
            "when [.call()] is called"
            "then should call [PlayersRepository.loadPlayer()] with expected arguments",
            () async {
              const playerId = 1;

              await loadPlayerUseCase(
                playerId: playerId,
              );

              verify(
                () => playersRepository.loadPlayer(
                  playerId: playerId,
                ),
              ).called(1);
            },
          );
        },
      );
    },
  );
}

class _MockPlayersRepository extends Mock implements PlayersRepository {}

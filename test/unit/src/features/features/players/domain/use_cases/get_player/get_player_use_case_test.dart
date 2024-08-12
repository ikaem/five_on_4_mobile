import 'package:five_on_4_mobile/src/features/players/domain/models/player/player_model.dart';
import 'package:five_on_4_mobile/src/features/players/domain/repositories/players/players_repository.dart';
import 'package:five_on_4_mobile/src/features/players/domain/use_cases/get_player/get_player_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  final PlayersRepository playersRepository = _MockPlayersRepository();

  final GetPlayerUseCase useCase = GetPlayerUseCase(
    playersRepository: playersRepository,
  );

  tearDown(() {
    reset(playersRepository);
  });

  group(
    "$GetPlayerUseCase",
    () {
      group(
        ".call()",
        () {
          test(
            "given [PlayersRepository.getPlayer()] returns a [PlayerModel]"
            "when [.call()] is called"
            "then should return expected result",
            () async {
              // setup
              final playerModel = PlayerModel(
                avatarUri: Uri.parse("https://example.com/avatar"),
                id: 1,
                name: "name",
                nickname: "nickname",
              );

              // given
              when(
                () => playersRepository.getPlayer(
                  playerId: any(named: "playerId"),
                ),
              ).thenAnswer(
                (_) async => playerModel,
              );

              // when
              final player = await useCase(
                playerId: playerModel.id,
              );

              // then
              expect(player, equals(playerModel));

              // cleanup
            },
          );

          test(
            "given [PlayersRepository.getPlayer()] throws"
            "when [.call()] is called"
            "then should throw",
            () async {
              // setup
              final exception = Exception("error");

              // given
              when(
                () => playersRepository.getPlayer(
                  playerId: any(named: "playerId"),
                ),
              ).thenThrow(exception);

              // when / then
              expect(
                () async => await useCase(
                  playerId: 1,
                ),
                throwsA(predicate((e) =>
                    e is Exception && e.toString() == exception.toString())),
              );

              // cleanup
            },
          );

          test(
            "given [.call()] is called"
            "when examine call to [PlayersRepository.getPlayer()]"
            "then should have called [PlayersRepository.getPlayer()] with expected arguments",
            () async {
              // setup
              final playerModel = PlayerModel(
                avatarUri: Uri.parse("https://example.com/avatar"),
                id: 1,
                name: "name",
                nickname: "nickname",
              );

              when(
                () => playersRepository.getPlayer(
                  playerId: any(named: "playerId"),
                ),
              ).thenAnswer(
                (_) async => playerModel,
              );

              // given
              await useCase(
                playerId: 1,
              );

              // when / then
              verify(
                () => playersRepository.getPlayer(
                  playerId: playerModel.id,
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

class _MockPlayersRepository extends Mock implements PlayersRepository {}

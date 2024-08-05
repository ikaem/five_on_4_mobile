import 'package:five_on_4_mobile/src/features/matches/domain/repositories/matches/matches_repository.dart';
import 'package:five_on_4_mobile/src/features/players/domain/models/player/player_model.dart';
import 'package:five_on_4_mobile/src/features/players/domain/repositories/players/players_repository.dart';
import 'package:five_on_4_mobile/src/features/players/domain/use_cases/get_players/get_players_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  final PlayersRepository playersRepository = _MockPlayersRepository();

  // tested class
  final GetPlayersUseCase useCase = GetPlayersUseCase(
    playersRepository: playersRepository,
  );

  tearDown(() {
    reset(playersRepository);
  });

  group(
    "$GetPlayersUseCase",
    () {
      group(
        ".call()",
        () {
          test(
            "given [PlayersRepository.getPlayers()] returns a list of [PlayerModel]"
            "when [.call()] is called"
            "then should return expected result",
            () async {
              // setup
              final playerModels = List.generate(
                3,
                (i) => PlayerModel(
                  avatarUri: Uri.parse("https://example.com/avatar"),
                  id: i + 1,
                  name: "name",
                  nickname: "nickname",
                ),
              );

              // given
              when(
                () => playersRepository.getPlayers(
                  playerIds: any(named: "playerIds"),
                ),
              ).thenAnswer(
                (_) async => playerModels,
              );

              // when
              final players = await useCase(
                playerIds: playerModels.map((e) => e.id).toList(),
              );

              // then
              expect(players, equals(playerModels));

              // cleanup
            },
          );

          test(
            "given [.call()] is called"
            "when examine call to [PlayersRepository.getPlayers()]"
            "then should have called [PlayersRepository.getPlayers()] with expected arguments",
            () async {
              // setup
              final playerIds = [1, 2, 3];

              when(
                () => playersRepository.getPlayers(
                  playerIds: any(named: "playerIds"),
                ),
              ).thenAnswer(
                (_) async => [],
              );
              // given
              await useCase(
                playerIds: playerIds,
              );

              // when

              // then
              verify(
                () => playersRepository.getPlayers(
                  playerIds: playerIds,
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

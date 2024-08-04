import 'package:five_on_4_mobile/src/features/players/domain/models/player/player_model.dart';
import 'package:five_on_4_mobile/src/features/players/domain/repositories/players/players_repository.dart';
import 'package:five_on_4_mobile/src/features/players/domain/use_cases/load_searched_players/load_searched_players_use_case.dart';
import 'package:five_on_4_mobile/src/features/players/domain/values/search_players_fluter_value.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  final PlayersRepository playersRepository = _MockPlayersRepository();

// tested class
  final loadSearchedPlayersUseCase = LoadSearchedPlayersUseCase(
    playersRepository: playersRepository,
  );

  setUpAll(() {
    registerFallbackValue(_FakeSearchPlayersFilterValue());
  });

  tearDown(() {
    reset(playersRepository);
  });

  group(
    "$LoadSearchedPlayersUseCase",
    () {
      group(".call()", () {
        test(
          "given a [SearchPlayersFilterValue]"
          "when [.call()] is called"
          "then should return expected player ids",
          () async {
            // setup
            // final playerModels = List.generate(
            //     3,
            //     (i) => PlayerModel(
            //           id: i + 1,
            //           name: "name",
            //           avatarUri: Uri.parse("https://example.com/"),
            //           nickname: "nickname",
            //         ));

            final matchIds = [1, 2, 3];

            when(
              () => playersRepository.loadSearchedPlayers(
                filter: any(named: "filter"),
              ),
            ).thenAnswer(
              (_) async => matchIds,
            );

            // given
            const filter = SearchPlayersFilterValue(
              name: "name",
            );

            // when
            final ids = await loadSearchedPlayersUseCase(
              filter: filter,
            );

            // then
            expect(ids, equals(matchIds));

            // cleanup
          },
        );

        test(
          "given a [SearchPlayersFilterValue]"
          "when [.call()] is called"
          "then should call [PlayersRepository.loadSearchedPlayers()] with expected arguments",
          () async {
            // setup
            when(
              () => playersRepository.loadSearchedPlayers(
                filter: any(named: "filter"),
              ),
            ).thenAnswer(
              (_) async => [],
            );

            // given
            const filter = SearchPlayersFilterValue(name: "name");

            // when
            await loadSearchedPlayersUseCase(
              filter: filter,
            );

            // then
            verify(
              () => playersRepository.loadSearchedPlayers(
                filter: filter,
              ),
            ).called(1);

            // cleanup
          },
        );
      });
    },
  );
}

class _MockPlayersRepository extends Mock implements PlayersRepository {}

class _FakeSearchPlayersFilterValue extends Fake
    implements SearchPlayersFilterValue {}

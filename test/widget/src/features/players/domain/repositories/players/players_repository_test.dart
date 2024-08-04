import 'package:five_on_4_mobile/src/features/players/data/data_sources/players_local/players_local_data_source.dart';
import 'package:five_on_4_mobile/src/features/players/data/data_sources/players_remote/players_remote_data_source.dart';
import 'package:five_on_4_mobile/src/features/players/data/entities/player_remote/player_remote_entity.dart';
import 'package:five_on_4_mobile/src/features/players/domain/models/player/player_model.dart';
import 'package:five_on_4_mobile/src/features/players/domain/repositories/players/players_repository.dart';
import 'package:five_on_4_mobile/src/features/players/domain/repositories/players/players_repository_impl.dart';
import 'package:five_on_4_mobile/src/features/players/domain/values/player_local_entity_value.dart';
import 'package:five_on_4_mobile/src/features/players/domain/values/search_players_fluter_value.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  final playersLocalDataSource = _MockPlayersLocalDataSource();
  final playersRemoteDataSource = _MockPlayersRemoteDataSource();

  // tested class
  final playersRepository = PlayersRepositoryImpl(
    playersLocalDataSource: playersLocalDataSource,
    playersRemoteDataSource: playersRemoteDataSource,
  );

  setUpAll(() {
    registerFallbackValue(_FakeSearchPlayersFilterValue());
  });

  tearDown(() {
    reset(playersLocalDataSource);
    reset(playersRemoteDataSource);
  });

  group(
    "$PlayersRepository",
    () {
      group(
        ".getMatches()",
        () {
          test(
            "given [PlayersLocalDataSource.getPlayers()] successfully returns players"
            "when [.getPlayers()] is called"
            "then should return expected players",
            () async {
              // setup
              final localMatchValues = List.generate(3, (i) {
                return PlayerLocalEntityValue(
                  id: i + 1,
                  firstName: "firstName$i",
                  lastName: "lastName$i",
                  nickname: "nickname$i",
                  avatarUrl: "http://example.com/$i",
                );
              });

              // given
              when(() => playersLocalDataSource.getPlayers(
                      playerIds: any(named: "playerIds")))
                  .thenAnswer((_) async => localMatchValues);

              // when
              final result = await playersRepository.getPlayers(
                playerIds: [1, 2, 3],
              );

              // then
              // TODO stopped here
              final expectedPlayers = localMatchValues
                  .map(
                    (value) => PlayerModel(
                      id: value.id,
                      name: "${value.firstName} ${value.lastName}",
                      // TODO fix this - we dont have converter from local match to model
                      avatarUri: Uri.parse(value.avatarUrl),
                      nickname: value.nickname,
                    ),
                  )
                  .toList();

              expect(result, equals(expectedPlayers));

              // cleanup
            },
          );

          test(
            "given [.getPlayers()] is called"
            "when examine call to [PlayersLocalDataSource.getPlayers()]"
            "then should have been called with expected arguments",
            () async {
              // setup
              final playerIds = [1, 2, 3];

              when(() => playersLocalDataSource.getPlayers(
                      playerIds: any(named: "playerIds")))
                  .thenAnswer((_) async => []);

              // given
              await playersRepository.getPlayers(
                playerIds: playerIds,
              );

              // when
              verify(
                () => playersLocalDataSource.getPlayers(
                  playerIds: playerIds,
                ),
              ).called(1);

              // then

              // cleanup
            },
          );
        },
      );

      group(
        ".loadSearchedPlayers()",
        () {
          test(
            "given [SearchPlayersFilterValue] is provided"
            "when [.loadSearchedPlayers()] is called"
            "then should call [PlayersRemoteDataSource.getSearchedPlayers()] with expected arguments",
            () async {
              // setup

              when(() => playersRemoteDataSource.getSearchedPlayers(
                      searchPlayersFilter: any(named: "searchPlayersFilter")))
                  .thenAnswer((_) async => []);

              when(() => playersLocalDataSource.storePlayers(
                      matchValues: any(named: "matchValues")))
                  .thenAnswer((_) async => []);

              // given
              const searchPlayersFilter =
                  SearchPlayersFilterValue(name: "name");

              // when
              await playersRepository.loadSearchedPlayers(
                filter: searchPlayersFilter,
              );

              // then
              verify(
                () => playersRemoteDataSource.getSearchedPlayers(
                  searchPlayersFilter: searchPlayersFilter,
                ),
              ).called(1);

              // cleanup
            },
          );

          test(
            "given [PlayersRemoteDataSource.getSearchedPlayers()] successfully returns retrieved players"
            "when [.loadSearchedPlayers()] is called"
            "then should call [PlayersLocalDataSource.storePlayers()] with expected arguments",
            () async {
              // setup
              final remoteEntities = List.generate(3, (i) {
                return PlayerRemoteEntity(
                  id: i + 1,
                  firstName: "firstName$i",
                  lastName: "lastName$i",
                  avatarUrl: "http://example.com/$i",
                  nickname: "nickname$i",
                );
              });

              when(() => playersLocalDataSource.storePlayers(
                      matchValues: any(named: "matchValues")))
                  .thenAnswer((_) async => []);

              // given
              when(() => playersRemoteDataSource.getSearchedPlayers(
                      searchPlayersFilter: any(named: "searchPlayersFilter")))
                  .thenAnswer((_) async => remoteEntities);

              // when
              await playersRepository.loadSearchedPlayers(
                filter: _FakeSearchPlayersFilterValue(),
              );

              // then
              final expectedPlayersValuesArguments = remoteEntities
                  .map(
                    (entity) => PlayerLocalEntityValue(
                      id: entity.id,
                      firstName: entity.firstName,
                      lastName: entity.lastName,
                      nickname: entity.nickname,
                      avatarUrl: entity.avatarUrl,
                    ),
                  )
                  .toList();

              verify(
                () => playersLocalDataSource.storePlayers(
                  matchValues: expectedPlayersValuesArguments,
                ),
              ).called(1);

              // cleanup
            },
          );

          test(
            "given search results are successfully retrieved and stored locally"
            "when [.loadSearchedPlayers()] is called"
            "then should return expected player ids",
            () async {
              // setup
              final remoteEntities = List.generate(3, (i) {
                return PlayerRemoteEntity(
                  id: i + 1,
                  firstName: "firstName$i",
                  lastName: "lastName$i",
                  avatarUrl: "avatarUrl$i",
                  nickname: "nickname$i",
                );
              });
              final playerIds = remoteEntities.map((e) => e.id).toList();

              // given
              when(() => playersLocalDataSource.storePlayers(
                      matchValues: any(named: "matchValues")))
                  .thenAnswer((_) async => playerIds);

              when(() => playersRemoteDataSource.getSearchedPlayers(
                      searchPlayersFilter: any(named: "searchPlayersFilter")))
                  .thenAnswer((_) async => remoteEntities);

              // when
              final result = await playersRepository.loadSearchedPlayers(
                filter: _FakeSearchPlayersFilterValue(),
              );

              // then
              expect(result, equals(playerIds));

              // cleanup
            },
          );
        },
      );
    },
  );
}

class _MockPlayersLocalDataSource extends Mock
    implements PlayersLocalDataSource {}

class _MockPlayersRemoteDataSource extends Mock
    implements PlayersRemoteDataSource {}

class _FakeSearchPlayersFilterValue extends Fake
    implements SearchPlayersFilterValue {}

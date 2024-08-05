import 'package:five_on_4_mobile/src/features/auth/domain/exceptions/auth_exceptions.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/use_cases/sign_out/sign_out_use_case.dart';
import 'package:five_on_4_mobile/src/features/players/domain/models/player/player_model.dart';
import 'package:five_on_4_mobile/src/features/players/domain/use_cases/get_players/get_players_use_case.dart';
import 'package:five_on_4_mobile/src/features/players/domain/use_cases/load_searched_players/load_searched_players_use_case.dart';
import 'package:five_on_4_mobile/src/features/players/domain/values/search_players_fluter_value.dart';
import 'package:five_on_4_mobile/src/features/players/domain/values/search_players_input_args_value.dart';
import 'package:five_on_4_mobile/src/features/players/presentation/controllers/search_players/provider/search_players_controller.dart';
import 'package:five_on_4_mobile/src/features/search/presentation/widgets/search/players/search_players_inputs.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/get_it/get_it_wrapper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

void main() {
  final loadSearchedPlayersUseCase = _MockLoadSearchedPlayersUseCase();
  final getPlayersUseCase = _MockGetPlayersUseCase();
  final signoutUseCase = _MockSignoutUseCase();

  final listener = _MockListener<AsyncValue<SearchPlayersControllerState>>();

  setUpAll(
    () {
      registerFallbackValue(_FakeSearchPlayersFilterValue());
      registerFallbackValue(
          AsyncValue.data(_FakeSearchPlayersControllerState()));
    },
  );

  setUpAll(
    () {
      getIt.registerSingleton<LoadSearchedPlayersUseCase>(
          loadSearchedPlayersUseCase);
      getIt.registerSingleton<GetPlayersUseCase>(getPlayersUseCase);
      getIt.registerSingleton<SignOutUseCase>(signoutUseCase);
    },
  );

  tearDown(
    () {
      reset(loadSearchedPlayersUseCase);
      reset(getPlayersUseCase);
      reset(signoutUseCase);
      reset(listener);
    },
  );

  group(
    "$SearchPlayersController",
    () {
      group(".build()", () {
        test(
          "given instance of [SearchPlayersController], "
          "when [.build()] is called, "
          "then should emit expected state",
          () async {
            // setup
            final ProviderContainer container = ProviderContainer();

            // given
            // already instasnntiated by calling the container below

            // when
            // .build() is called when start listening - lets see it that way to simplify
            container.listen(
              searchPlayersControllerProvider,
              listener,
              fireImmediately: true,
            );

            // then
            verifyInOrder([
              () => listener(
                  null,
                  const AsyncData<SearchPlayersControllerState>(
                      SearchPlayersControllerState(foundPlayers: []))),
            ]);
            verifyNoMoreInteractions(listener);

            // cleanup
            addTearDown(() {
              container.dispose();
            });
          },
        );
      });

      group(
        ".onSearchPlayers()",
        () {
          test(
            "given empty [nameTerm] filter is provided, "
            "when [.onSearchPlayers()] is called, "
            "then should NOT empty any events",
            () async {
              // setup
              final ProviderContainer container = ProviderContainer();

              // initialize the controller
              container.listen(
                searchPlayersControllerProvider,
                listener,
                fireImmediately: true,
              );

              // initial state
              verifyInOrder([
                () => listener(
                    null,
                    const AsyncData<SearchPlayersControllerState>(
                        SearchPlayersControllerState(foundPlayers: []))),
              ]);

              // given
              // const nameTerm = "";
              const SearchPlayersInputArgsValue args =
                  SearchPlayersInputArgsValue(nameTerm: "");

              // when
              await container
                  .read(searchPlayersControllerProvider.notifier)
                  .onSearchPlayers(
                    // nameTerm: nameTerm,
                    args: args,
                  );

              // then
              // verify no interactions with the listener - it means that listner has not consumerd state - no stsate has been emited to it
              verifyNoMoreInteractions(listener);

              verifyNever(() =>
                  loadSearchedPlayersUseCase(filter: any(named: "filter")));
              verifyNever(
                  () => getPlayersUseCase(playerIds: any(named: "playerIds")));
              verifyNever(() => signoutUseCase());

              // cleanup
              addTearDown(() {
                container.dispose();
              });
            },
          );

          test(
            "given there is an error when [LoadSearchedPlayersUseCase] is called, "
            "when [.onSearchPlayers()] is called, "
            "then should emit events in specific order and make expected calls to use cases",
            () async {
              // setup
              final ProviderContainer container = ProviderContainer();

              // initialize the controller
              container.listen(
                searchPlayersControllerProvider,
                listener,
                fireImmediately: true,
              );

              // initial state
              verifyInOrder([
                () => listener(
                    null,
                    const AsyncData<SearchPlayersControllerState>(
                        SearchPlayersControllerState(foundPlayers: []))),
              ]);

              // given
              when(() =>
                      loadSearchedPlayersUseCase(filter: any(named: "filter")))
                  .thenThrow(Exception("error"));

              // when
              await container
                  .read(searchPlayersControllerProvider.notifier)
                  .onSearchPlayers(
                    // nameTerm: "John",
                    args: const SearchPlayersInputArgsValue(nameTerm: "John"),
                  );

              // then
              verifyInOrder([
                () => listener(
                    const AsyncData<SearchPlayersControllerState>(
                        SearchPlayersControllerState(foundPlayers: [])),
                    const AsyncLoading<SearchPlayersControllerState>()),
                () => listener(
                      const AsyncLoading<SearchPlayersControllerState>(),
                      const AsyncError<SearchPlayersControllerState>(
                        "There was an issue getting searched players",
                        StackTrace.empty,
                      ),
                    ),
              ]);
              verifyNoMoreInteractions(listener);

              // verify calls to use cases
              verify(() => loadSearchedPlayersUseCase(
                      filter: const SearchPlayersFilterValue(
                    name: "John",
                  ))).called(1);

              verifyNever(
                  () => getPlayersUseCase(playerIds: any(named: "playerIds")));
              verifyNever(() => signoutUseCase());

              // cleanup
              addTearDown(() {
                container.dispose();
              });
            },
          );

          test(
            "given there is an [AuthNotLoggedInException] when [LoadSearchedPlayersUseCase] is called, "
            "when [.onSearchPlayers()] is called, "
            "then should emit events in specific order and make expected calls to use cases",
            () async {
              // setup
              final ProviderContainer container = ProviderContainer();

              // initialize the controller
              container.listen(
                searchPlayersControllerProvider,
                listener,
                fireImmediately: true,
              );

              // initial state
              verifyInOrder([
                () => listener(
                    null,
                    const AsyncData<SearchPlayersControllerState>(
                        SearchPlayersControllerState(foundPlayers: []))),
              ]);

              when(() => signoutUseCase()).thenAnswer((_) async {
                return;
              });

              // given
              when(() =>
                      loadSearchedPlayersUseCase(filter: any(named: "filter")))
                  .thenThrow(const AuthNotLoggedInException());

              // when
              await container
                  .read(searchPlayersControllerProvider.notifier)
                  .onSearchPlayers(
                    // nameTerm: "John",
                    args: const SearchPlayersInputArgsValue(nameTerm: "John"),
                  );

              // then
              verifyInOrder([
                () => listener(
                    const AsyncData<SearchPlayersControllerState>(
                        SearchPlayersControllerState(foundPlayers: [])),
                    const AsyncLoading<SearchPlayersControllerState>()),
                () => listener(
                      const AsyncLoading<SearchPlayersControllerState>(),
                      const AsyncError<SearchPlayersControllerState>(
                        "User is not logged in",
                        StackTrace.empty,
                      ),
                    ),
              ]);
              verifyNoMoreInteractions(listener);

              // verify calls to use cases
              verify(() => loadSearchedPlayersUseCase(
                      filter: const SearchPlayersFilterValue(
                    name: "John",
                  ))).called(1);
              verify(() => signoutUseCase()).called(1);

              verifyNever(
                  () => getPlayersUseCase(playerIds: any(named: "playerIds")));

              // cleanup
              addTearDown(() {
                container.dispose();
              });
            },
          );

          test(
            "given there is an error when [GetPlayersUseCase] is called, "
            "when [.onSearchPlayers()] is called, "
            "then should emit events in specific order and make expšected calls to use cases",
            () async {
              // setup
              final ProviderContainer container = ProviderContainer();

              // initialize the controller
              container.listen(
                searchPlayersControllerProvider,
                listener,
                fireImmediately: true,
              );

              // initial state
              verifyInOrder([
                () => listener(
                    null,
                    const AsyncData<SearchPlayersControllerState>(
                        SearchPlayersControllerState(foundPlayers: []))),
              ]);

              // given
              when(() =>
                      loadSearchedPlayersUseCase(filter: any(named: "filter")))
                  .thenAnswer((_) async {
                return [1, 2, 3];
              });

              // given
              when(() => getPlayersUseCase(playerIds: any(named: "playerIds")))
                  .thenThrow(Exception("error"));

              // when
              await container
                  .read(searchPlayersControllerProvider.notifier)
                  .onSearchPlayers(
                    // nameTerm: "John",
                    args: const SearchPlayersInputArgsValue(nameTerm: "John"),
                  );

              // then
              verifyInOrder([
                () => listener(
                    const AsyncData<SearchPlayersControllerState>(
                        SearchPlayersControllerState(foundPlayers: [])),
                    const AsyncLoading<SearchPlayersControllerState>()),
                () => listener(
                      const AsyncLoading<SearchPlayersControllerState>(),
                      const AsyncError<SearchPlayersControllerState>(
                        "There was an issue getting searched players",
                        StackTrace.empty,
                      ),
                    ),
              ]);
              verifyNoMoreInteractions(listener);

              // verify calls to use cases
              verify(() => loadSearchedPlayersUseCase(
                      filter: const SearchPlayersFilterValue(
                    name: "John",
                  ))).called(1);
              verify(() => getPlayersUseCase(playerIds: [1, 2, 3])).called(1);

              verifyNever(() => signoutUseCase());

              // cleanup
              addTearDown(() {
                container.dispose();
              });
            },
          );

          test(
            "given searched players are retrieved successfully, "
            "when [.onSearchPlayers()] is called, "
            "then should emit events in specific order and make expected calls to use cases",
            () async {
              // setup
              final List<PlayerModel> players = List.generate(
                3,
                (i) => PlayerModel(
                  id: i + 1,
                  name: "John Doe",
                  avatarUri: Uri.parse("http://example.com/"),
                  nickname: "JD",
                ),
              );

              final ProviderContainer container = ProviderContainer();

              // initialize the controller
              container.listen(
                searchPlayersControllerProvider,
                listener,
                fireImmediately: true,
              );

              // initial state
              verifyInOrder([
                () => listener(
                    null,
                    const AsyncData<SearchPlayersControllerState>(
                        SearchPlayersControllerState(foundPlayers: []))),
              ]);

              // given
              when(() =>
                      loadSearchedPlayersUseCase(filter: any(named: "filter")))
                  .thenAnswer((_) async {
                return [1, 2, 3];
              });

              when(() => getPlayersUseCase(playerIds: any(named: "playerIds")))
                  .thenAnswer((_) async {
                return players;
              });

              // when
              await container
                  .read(searchPlayersControllerProvider.notifier)
                  .onSearchPlayers(
                    // nameTerm: "John",
                    args: const SearchPlayersInputArgsValue(nameTerm: "John"),
                  );

              // then
              verifyInOrder([
                () => listener(
                    const AsyncData<SearchPlayersControllerState>(
                        SearchPlayersControllerState(foundPlayers: [])),
                    const AsyncLoading<SearchPlayersControllerState>()),
                () => listener(
                      const AsyncLoading<SearchPlayersControllerState>(),
                      AsyncData<SearchPlayersControllerState>(
                        SearchPlayersControllerState(foundPlayers: players),
                      ),
                    ),
              ]);
              verifyNoMoreInteractions(listener);

              // verify calls to use cases
              verify(() => loadSearchedPlayersUseCase(
                      filter: const SearchPlayersFilterValue(
                    name: "John",
                  ))).called(1);
              verify(() => getPlayersUseCase(playerIds: [1, 2, 3])).called(1);

              verifyNever(() => signoutUseCase());

              // cleanup
              addTearDown(() {
                container.dispose();
              });
            },
          );
        },
      );
    },
  );
}

class _MockLoadSearchedPlayersUseCase extends Mock
    implements LoadSearchedPlayersUseCase {}

class _MockGetPlayersUseCase extends Mock implements GetPlayersUseCase {}

class _MockSignoutUseCase extends Mock implements SignOutUseCase {}

class _MockListener<T> extends Mock {
  void call(T? previous, T next);
}

class _FakeSearchPlayersControllerState extends Fake
    implements SearchPlayersControllerState {}

class _FakeSearchPlayersFilterValue extends Fake
    implements SearchPlayersFilterValue {}

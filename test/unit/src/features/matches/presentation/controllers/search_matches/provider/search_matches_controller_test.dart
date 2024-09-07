import 'package:five_on_4_mobile/src/features/auth/domain/exceptions/auth_exceptions.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/use_cases/sign_out/sign_out_use_case.dart';
import 'package:five_on_4_mobile/src/features/matches/data/data_sources/matches_remote/matches_remote_data_source.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/models/match/match_model.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/get_matches/get_matches_use_case.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/load_searched_matches/load_searched_matches_use_case.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/controllers/search_matches/provider/search_matches_controller.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/get_it/get_it_wrapper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  final loadSearchedMatchesUseCase = _MockLoadSearchedMatchesUseCase();
  final getMatchesUseCase = _MockGetMatchesUseCase();
  final signOutUseCase = _MockSignOutUseCase();

  final listener = _MockListener<AsyncValue<SearchMatchesControllerState>>();

  setUpAll(() {
    registerFallbackValue(AsyncValue.data(_FakeSearchMatchesControllerState()));
    registerFallbackValue(_FakeSearchMatchesFilterValue());
  });

  setUpAll(() {
    getIt.registerSingleton<LoadSearchedMatchesUseCase>(
        loadSearchedMatchesUseCase);
    getIt.registerSingleton<GetMatchesUseCase>(getMatchesUseCase);
    getIt.registerSingleton<SignOutUseCase>(signOutUseCase);
  });

  tearDown(() {
    reset(loadSearchedMatchesUseCase);
    reset(getMatchesUseCase);
    reset(signOutUseCase);
    reset(listener);
  });

  group("$SearchMatchesController", () {
    group(".build()", () {
      test(
        "given SearchMatchesController "
        "when .build() is called "
        "then should emit expected state",
        () async {
          // setup
          final ProviderContainer container = ProviderContainer();

          // given

          // when
          container.listen(
            searchMatchesControllerProvider,
            listener,
            fireImmediately: true,
          );

          // then
          verifyInOrder([
            () => listener(
                  null,
                  const AsyncData<SearchMatchesControllerState>(
                      SearchMatchesControllerState(foundMatches: [])),
                ),
          ]);
          verifyNoMoreInteractions(listener);

          // cleanup
          addTearDown(() {
            container.dispose();
          });
        },
      );
    });

    group(".onSearchMatches()", () {
      // empty match title - nothing changes
      test(
        // TODO this case and test should in future be modified when more filters are added - maybe, we will see
        "given empty matchTitle string is passed"
        "when .onSearchMatches() is called "
        "then should not emit any events",
        () async {
          // setup
          final container = ProviderContainer();
          // initialize controller
          container.listen(
            searchMatchesControllerProvider,
            listener,
            fireImmediately: true,
          );
          // initial state
          verify(
            () => listener(
              null,
              const AsyncData<SearchMatchesControllerState>(
                  SearchMatchesControllerState(foundMatches: [])),
            ),
          );

          // given
          const matchTitle = "";

          // when
          await container
              .read(searchMatchesControllerProvider.notifier)
              .onSearchMatches(
                matchTitle: matchTitle,
              );

          // then
          verifyNoMoreInteractions(listener);

          verifyNever(
              () => loadSearchedMatchesUseCase(filter: any(named: "filter")));
          verifyNever(
              () => getMatchesUseCase(matchIds: any(named: "matchIds")));
          verifyNever(() => signOutUseCase());

          // cleanup
          addTearDown(() {
            container.dispose();
          });
        },
      );

      // error loading searched matches
      test(
        "given there is an error loading searched matches "
        "when .onSearchMatches() is called "
        "then should emit events in specific order and make expected calls to use cases",
        () async {
          // setup
          final container = ProviderContainer();
          // initialize controller
          container.listen(
            searchMatchesControllerProvider,
            listener,
            fireImmediately: true,
          );
          // initial state
          verify(
            () => listener(
              null,
              const AsyncData<SearchMatchesControllerState>(
                  SearchMatchesControllerState(foundMatches: [])),
            ),
          );

          // given
          when(() => loadSearchedMatchesUseCase(filter: any(named: "filter")))
              .thenThrow(Exception("error loading searched matches"));

          // when
          await container
              .read(searchMatchesControllerProvider.notifier)
              .onSearchMatches(
                matchTitle: "matchTitle",
              );

          // then
          verifyInOrder([
            () => listener(
                  const AsyncData<SearchMatchesControllerState>(
                      SearchMatchesControllerState(foundMatches: [])),
                  const AsyncLoading<SearchMatchesControllerState>(),
                ),
            () => listener(
                  const AsyncLoading<SearchMatchesControllerState>(),
                  const AsyncError<SearchMatchesControllerState>(
                    "There was an issue getting searched matches",
                    StackTrace.empty,
                  ),
                ),
          ]);
          verifyNoMoreInteractions(listener);

          // verify calls to use cases
          verify(() => loadSearchedMatchesUseCase(
                  filter:
                      const SearchMatchesFilterValue(matchTitle: "matchTitle")))
              .called(1);
          verifyNever(
              () => getMatchesUseCase(matchIds: any(named: "matchIds")));
          verifyNever(() => signOutUseCase());

          // cleanup
          addTearDown(() {
            container.dispose();
          });
        },
      );
      // in case of 401 - sign out - load searched matches should throw specific error
      test(
        "given there is an Authentication error loading searched matches "
        "when .onSearchMatches() is called "
        "then should emit events in specific order and make expected calls to use cases",
        () async {
          // setup
          when(() => signOutUseCase()).thenAnswer((_) async {});

          final container = ProviderContainer();
          // initialize controller
          container.listen(
            searchMatchesControllerProvider,
            listener,
            fireImmediately: true,
          );
          // initial state
          verify(
            () => listener(
              null,
              const AsyncData<SearchMatchesControllerState>(
                  SearchMatchesControllerState(foundMatches: [])),
            ),
          );

          // given
          when(() => loadSearchedMatchesUseCase(filter: any(named: "filter")))
              .thenThrow(const AuthNotLoggedInException());

          // when
          await container
              .read(searchMatchesControllerProvider.notifier)
              .onSearchMatches(
                matchTitle: "matchTitle",
              );

          // then
          verifyInOrder([
            () => listener(
                  const AsyncData<SearchMatchesControllerState>(
                      SearchMatchesControllerState(foundMatches: [])),
                  const AsyncLoading<SearchMatchesControllerState>(),
                ),
            () => listener(
                  const AsyncLoading<SearchMatchesControllerState>(),
                  const AsyncError<SearchMatchesControllerState>(
                    "User is not logged in",
                    StackTrace.empty,
                  ),
                ),
          ]);
          verifyNoMoreInteractions(listener);

          // verify calls to use cases
          verify(() => loadSearchedMatchesUseCase(filter: any(named: "filter")))
              .called(1);
          verify(() => signOutUseCase()).called(1);
          verifyNever(
              () => getMatchesUseCase(matchIds: any(named: "matchIds")));

          // cleanup
          addTearDown(() {
            container.dispose();
          });
        },
      );

      // error getting matches
      test(
        "given there is an error getting matches "
        "when .onSearchMatches() is called "
        "then should emit evdnts in specific order and make expected calls to use cases",
        () async {
          // setup
          when(() => loadSearchedMatchesUseCase(filter: any(named: "filter")))
              .thenAnswer((_) async => [1, 2, 3]);

          final container = ProviderContainer();
          // initialize controller
          container.listen(
            searchMatchesControllerProvider,
            listener,
            fireImmediately: true,
          );
          // initial state
          verify(
            () => listener(
              null,
              const AsyncData<SearchMatchesControllerState>(
                  SearchMatchesControllerState(foundMatches: [])),
            ),
          );

          // given
          when(() => getMatchesUseCase(matchIds: any(named: "matchIds")))
              .thenThrow(Exception("error getting matches"));

          // when
          await container
              .read(searchMatchesControllerProvider.notifier)
              .onSearchMatches(
                matchTitle: "matchTitle",
              );

          // then
          verifyInOrder([
            () => listener(
                  const AsyncData<SearchMatchesControllerState>(
                      SearchMatchesControllerState(foundMatches: [])),
                  const AsyncLoading<SearchMatchesControllerState>(),
                ),
            () => listener(
                  const AsyncLoading<SearchMatchesControllerState>(),
                  const AsyncError<SearchMatchesControllerState>(
                    "There was an issue getting searched matches",
                    StackTrace.empty,
                  ),
                ),
          ]);
          verifyNoMoreInteractions(listener);

          // verify calls to use cases
          verify(() => loadSearchedMatchesUseCase(filter: any(named: "filter")))
              .called(1);
          verify(() => getMatchesUseCase(matchIds: any(named: "matchIds")))
              .called(1);
          verifyNever(() => signOutUseCase());

          // cleanup
          addTearDown(() {
            container.dispose();
          });
        },
      );

      // success
      test(
        "given searched matches are retrieved successfully "
        "when .onSearchMatches() is called "
        "then should emit events in specific order and make expected calls to use cases",
        () async {
          // setup
          final List<MatchModel> matches = List.generate(
              3,
              (i) => MatchModel(
                    id: i + 1,
                    title: "title $i",
                    dateAndTime: DateTime.now(),
                    location: "location $i",
                    description: "description $i",
                    participations: const [],
                  ));
          final matchesIds = matches.map((e) => e.id).toList();

          final container = ProviderContainer();
          // initialize controller
          container.listen(
            searchMatchesControllerProvider,
            listener,
            fireImmediately: true,
          );
          // initial state
          verify(
            () => listener(
              null,
              const AsyncData<SearchMatchesControllerState>(
                  SearchMatchesControllerState(foundMatches: [])),
            ),
          );

          // given
          when(() => loadSearchedMatchesUseCase(filter: any(named: "filter")))
              .thenAnswer((_) async => matchesIds);
          when(() => getMatchesUseCase(matchIds: any(named: "matchIds")))
              .thenAnswer((_) async => matches);

          // when
          await container
              .read(searchMatchesControllerProvider.notifier)
              .onSearchMatches(
                matchTitle: "matchTitle",
              );

          // then
          verifyInOrder([
            () => listener(
                  const AsyncData<SearchMatchesControllerState>(
                      SearchMatchesControllerState(foundMatches: [])),
                  const AsyncLoading<SearchMatchesControllerState>(),
                ),
            () => listener(
                  const AsyncLoading<SearchMatchesControllerState>(),
                  AsyncData<SearchMatchesControllerState>(
                    SearchMatchesControllerState(foundMatches: matches),
                  ),
                ),
          ]);
          verifyNoMoreInteractions(listener);

          // verify calls to use cases
          verify(() => loadSearchedMatchesUseCase(
                  filter:
                      const SearchMatchesFilterValue(matchTitle: "matchTitle")))
              .called(1);
          verify(() => getMatchesUseCase(matchIds: matchesIds)).called(1);
          verifyNever(() => signOutUseCase());

          // cleanup
          addTearDown(() {
            container.dispose();
          });
        },
      );
    });
  });
}

class _MockLoadSearchedMatchesUseCase extends Mock
    implements LoadSearchedMatchesUseCase {}

class _MockGetMatchesUseCase extends Mock implements GetMatchesUseCase {}

class _MockSignOutUseCase extends Mock implements SignOutUseCase {}

class _MockListener<T> extends Mock {
  void call(T? previous, T next);
}

class _FakeSearchMatchesControllerState extends Fake
    implements SearchMatchesControllerState {}

class _FakeSearchMatchesFilterValue extends Fake
    implements SearchMatchesFilterValue {}

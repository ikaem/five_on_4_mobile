import 'package:five_on_4_mobile/src/features/auth/domain/exceptions/auth_exceptions.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/models/authenticated_player/authenticated_player_model.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/use_cases/get_authenticated_player_model/get_authenticated_player_model_use_case.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/use_cases/sign_out/sign_out_use_case.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/models/match/match_model.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/get_player_matches_overview/get_player_matches_overview_use_case.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/load_player_matches_overview/load_player_matches_overview_use_case.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/values/player_match_models_overview_value.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/controllers/get_my_matches/provider/get_my_matches_overview_controller.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/get_it/get_it_wrapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../../../../utils/data/test_entities.dart';

// TODO this should be renamed - get my matches overview controller - and folder name too
void main() {
  final loadPlayerMatchesOverviewUseCase =
      _MockLoadPlayerMatchesOverviewUseCase();
  final getPlayerMatchesOverviewUseCase =
      _MockGetPlayerMatchesOverviewUseCase();
  final getAuthenticatedPlayerModelUseCase =
      _MockGetAuthenticatedPlayerModelUseCase();
  final signOutUseCase = _MockSignOutUseCase();

  // TODO this might need to be async value - check with debugger
  final listener =
      _MockListener<AsyncValue<PlayerMatchesOverviewControllerState>>();

  setUpAll(() {
    registerFallbackValue(
      AsyncValue.data(_FakePlayerMatchesOverviewControllerState()),
    );
  });

  setUpAll(() {
    getIt.registerSingleton<LoadPlayerMatchesOverviewUseCase>(
        loadPlayerMatchesOverviewUseCase);
    getIt.registerSingleton<GetPlayerMatchesOverviewUseCase>(
        getPlayerMatchesOverviewUseCase);
    getIt.registerSingleton<GetAuthenticatedPlayerModelUseCase>(
        getAuthenticatedPlayerModelUseCase);
    getIt.registerSingleton<SignOutUseCase>(signOutUseCase);
  });

  tearDown(() {
    reset(loadPlayerMatchesOverviewUseCase);
    reset(getPlayerMatchesOverviewUseCase);
    reset(getAuthenticatedPlayerModelUseCase);
    reset(signOutUseCase);
    reset(listener);
  });

  group("$GetMyMatchesOverviewController", () {
    group(".build()", () {
      // states when there is no authenticated player

      test(
        "given there is no authenticated player"
        "when .build() is called"
        "then should emit expected states in specific order",
        () async {
          // setup
          when(() => signOutUseCase()).thenAnswer(
            (_) async {},
          );
          final ProviderContainer providerContainer = ProviderContainer();

          // given
          // stub has to come before listening - to make sure use case stub is available before controller is used
          when(() => getAuthenticatedPlayerModelUseCase()).thenAnswer(
            (_) async => null,
          );
          // addTearDown(() {
          //   providerContainer.dispose();
          // });

          // when
          providerContainer.listen(
            getMyMatchesOverviewControllerProvider,
            listener,
            fireImmediately: true,
          );

          await Future.delayed(Duration.zero);

          // then
          final captured = verifyInOrder([
            () => listener(
                  captureAny(),
                  captureAny(),
                ),
            () => listener(
                  captureAny(),
                  captureAny(),
                ),
          ]).captured;
          verifyNoMoreInteractions(listener);

          final firstCall = captured[0];
          final secondCall = captured[1];

          final firstCallFirstArg = firstCall[0];
          final firstCallSecondArg = firstCall[1];

          final secondCallFirstArg = secondCall[0];
          final secondCallSecondArg = secondCall[1];

          expect(firstCallFirstArg, isNull);
          expect(firstCallSecondArg,
              isA<AsyncLoading<PlayerMatchesOverviewControllerState>>());

          expect(secondCallFirstArg,
              isA<AsyncLoading<PlayerMatchesOverviewControllerState>>());
          expect(secondCallSecondArg,
              isA<AsyncError<PlayerMatchesOverviewControllerState>>());

          expect(
            (secondCallSecondArg
                    as AsyncError<PlayerMatchesOverviewControllerState>)
                .error,
            isA<AuthExceptionNotLoggedIn>(),
          );

          // TODO this is ok too
          expect(
            (secondCallSecondArg).error.toString(),
            equals("AuthException -> No logged in player"),
          );

          expect(
            (secondCallSecondArg).stackTrace.toString(),
            startsWith("#0      GetMyMatchesOverviewController.build "),
          );

          // cleanup
          addTearDown(() {
            providerContainer.dispose();
          });
        },
      );
    });

    // states when there is an error loading matches data
    test(
      "given there is an error loading matches data"
      "when .build() is called"
      "then should emit expected states in specific order",
      () async {
        // setup
        // stub signout
        when(() => signOutUseCase()).thenAnswer(
          (_) async {},
        );
        // stub get authenticated player model
        when(() => getAuthenticatedPlayerModelUseCase()).thenAnswer(
          (_) async => _testAuthenticatedPlayerModel,
        );

        // get provider container
        final providerContainer = ProviderContainer();
        // add teardown

        // given
        // stub load player matches overview use case
        when(() => loadPlayerMatchesOverviewUseCase(
            playerId: any(named: "playerId"))).thenThrow(
          Exception("error loading matches data"),
        );

        // when
        // listen to provider container
        providerContainer.listen(
          getMyMatchesOverviewControllerProvider,
          listener,
          fireImmediately: true,
        );
        // wait a bit
        await Future.delayed(Duration.zero);

        // then
        final captured = verifyInOrder([
          () => listener(
                captureAny(),
                captureAny(),
              ),
          () => listener(
                captureAny(),
                captureAny(),
              ),
        ]).captured;
        verifyNoMoreInteractions(listener);

        // capture calls
        final firstCall = captured[0];
        final secondCall = captured[1];

        final firstCallFirstArg = firstCall[0];
        final firstCallSecondArg = firstCall[1];

        final secondCallFirstArg = secondCall[0];
        final secondCallSecondArg = secondCall[1];

        // first call
        expect(firstCallFirstArg, isNull);
        expect(firstCallSecondArg,
            isA<AsyncLoading<PlayerMatchesOverviewControllerState>>());

        // second call
        expect(secondCallFirstArg,
            isA<AsyncLoading<PlayerMatchesOverviewControllerState>>());
        expect(secondCallSecondArg,
            isA<AsyncError<PlayerMatchesOverviewControllerState>>());

        // error message
        expect(
          (secondCallSecondArg
                  as AsyncError<PlayerMatchesOverviewControllerState>)
              .error,
          isA<Exception>(),
        );
        expect(
          (secondCallSecondArg).error.toString(),
          equals("Exception: error loading matches data"),
        );

        // TODO come back to this - check why this is is the stack trace - why it is not same as above
        // expect(
        //   (secondCallSecondArg).stackTrace.toString(),
        //   startsWith("#0      GetMyMatchesOverviewController.build "),
        // );

        // cleanup
        addTearDown(() {
          providerContainer.dispose();
        });
      },
    );

    // states when there is an error getting matches data
    test(
      "given there is an error getting matches data"
      "when .build() is called"
      "then should emit expected states in specific order",
      () async {
        // setup
        // stub signout
        when(() => signOutUseCase()).thenAnswer(
          (_) async {},
        );
        // stub get authenticated player model
        when(() => getAuthenticatedPlayerModelUseCase()).thenAnswer(
          (_) async => _testAuthenticatedPlayerModel,
        );
        // stub load player matches overview use case
        when(() => loadPlayerMatchesOverviewUseCase(
            playerId: any(named: "playerId"))).thenAnswer(
          (_) async {},
        );

        // get provider container
        final providerContainer = ProviderContainer();

        // given
        // stub get player matches overview use case
        when(() => getPlayerMatchesOverviewUseCase(
            playerId: any(named: "playerId"))).thenThrow(
          Exception("error getting matches data"),
        );

        // when
        // listen to provider container
        providerContainer.listen(
          getMyMatchesOverviewControllerProvider,
          listener,
          fireImmediately: true,
        );
        // wait a bit
        await Future.delayed(Duration.zero);

        // then
        final captured = verifyInOrder([
          () => listener(
                captureAny(),
                captureAny(),
              ),
          () => listener(
                captureAny(),
                captureAny(),
              ),
        ]).captured;
        verifyNoMoreInteractions(listener);

        // capture calls
        final firstCall = captured[0];
        final secondCall = captured[1];

        final firstCallFirstArg = firstCall[0];
        final firstCallSecondArg = firstCall[1];

        final secondCallFirstArg = secondCall[0];
        final secondCallSecondArg = secondCall[1];

        // first call
        expect(firstCallFirstArg, isNull);
        expect(firstCallSecondArg,
            isA<AsyncLoading<PlayerMatchesOverviewControllerState>>());

        // second call
        expect(secondCallFirstArg,
            isA<AsyncLoading<PlayerMatchesOverviewControllerState>>());
        expect(secondCallSecondArg,
            isA<AsyncError<PlayerMatchesOverviewControllerState>>());

        // error message
        expect(
          (secondCallSecondArg
                  as AsyncError<PlayerMatchesOverviewControllerState>)
              .error,
          isA<Exception>(),
        );
        expect(
          (secondCallSecondArg).error.toString(),
          equals("Exception: error getting matches data"),
        );

        // TODO come back to this - check why this is is the stack trace - why it is not same as above
        // expect(
        //   (secondCallSecondArg).stackTrace.toString(),
        //   startsWith("#0      GetMyMatchesOverviewController.build "),
        // );

        // cleanup
        addTearDown(() {
          providerContainer.dispose();
        });
      },
    );

    // states when data is loaded successfully
    test(
      "given players are retrieved successfully"
      "when .build() is called"
      "then should emit expected states in specific order",
      () async {
        // setup
        final matcheModels =
            generateTestMatchLocalEntityCompanions(count: 9).map((e) {
          return MatchModel(
            id: e.id.value,
            dateAndTime:
                DateTime.fromMillisecondsSinceEpoch(e.dateAndTime.value),
            description: e.description.value,
            location: e.location.value,
            title: e.title.value,
          );
        }).toList();

        final PlayerMatchModelsOverviewValue matchesOverviewValue =
            PlayerMatchModelsOverviewValue(
          todayMatches: matcheModels.sublist(0, 3),
          pastMatches: matcheModels.sublist(3, 6),
          upcomingMatches: matcheModels.sublist(6, 9),
        );

        // stub signout
        when(() => signOutUseCase()).thenAnswer(
          (_) async {},
        );
        // stub get authenticated player model
        when(() => getAuthenticatedPlayerModelUseCase()).thenAnswer(
          (_) async => _testAuthenticatedPlayerModel,
        );
        // stub load player matches overview use case
        when(() => loadPlayerMatchesOverviewUseCase(
            playerId: any(named: "playerId"))).thenAnswer(
          (_) async {},
        );

        // get provider container
        final providerContainer = ProviderContainer();

        // given
        // stub get player matches overview use case
        when(() => getPlayerMatchesOverviewUseCase(
            playerId: any(named: "playerId"))).thenAnswer(
          (_) async => matchesOverviewValue,
        );

        // when
        // listen to provider container
        providerContainer.listen(
          getMyMatchesOverviewControllerProvider,
          listener,
          fireImmediately: true,
        );
        // wait a bit
        await Future.delayed(Duration.zero);

        // then
        final expectedDataState = PlayerMatchesOverviewControllerState(
          isRemoteFetchDone: true,
          todayMatches: matchesOverviewValue.todayMatches,
          upcomingMatches: matchesOverviewValue.upcomingMatches,
          pastMatches: matchesOverviewValue.pastMatches,
        );
        final captured = verifyInOrder([
          () => listener(
                captureAny(),
                captureAny(),
              ),
          () => listener(
                captureAny(),
                captureAny(),
              ),
        ]).captured;
        verifyNoMoreInteractions(listener);

        // capture calls
        final firstCall = captured[0];
        final secondCall = captured[1];

        final firstCallFirstArg = firstCall[0];
        final firstCallSecondArg = firstCall[1];

        final secondCallFirstArg = secondCall[0];
        final secondCallSecondArg = secondCall[1];

        // first call
        expect(firstCallFirstArg, isNull);
        expect(firstCallSecondArg,
            isA<AsyncLoading<PlayerMatchesOverviewControllerState>>());

        // second call
        expect(secondCallFirstArg,
            isA<AsyncLoading<PlayerMatchesOverviewControllerState>>());
        expect(secondCallSecondArg,
            isA<AsyncData<PlayerMatchesOverviewControllerState>>());

        // data
        expect(
          (secondCallSecondArg
                  as AsyncData<PlayerMatchesOverviewControllerState>)
              .value,
          equals(expectedDataState),
        );

        // cleanup
        addTearDown(() {
          providerContainer.dispose();
        });
      },
    );
  });
}

// TODO move this to model helpers later - create generator for it
const _testAuthenticatedPlayerModel = AuthenticatedPlayerModel(
  playerId: 1,
  playerName: "playerName",
  playerNickname: "playerNickname",
);

class _MockLoadPlayerMatchesOverviewUseCase extends Mock
    implements LoadPlayerMatchesOverviewUseCase {}

class _MockGetPlayerMatchesOverviewUseCase extends Mock
    implements GetPlayerMatchesOverviewUseCase {}

class _MockGetAuthenticatedPlayerModelUseCase extends Mock
    implements GetAuthenticatedPlayerModelUseCase {}

class _MockSignOutUseCase extends Mock implements SignOutUseCase {}

class _MockListener<T> extends Mock {
  void call(T? previous, T next);
}

class _FakePlayerMatchesOverviewControllerState extends Fake
    implements PlayerMatchesOverviewControllerState {}

// TODO ------------------- old ---------------------
// import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/get_my_today_matches/get_my_today_matches_use_case.dart';
// import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/get_my_today_matches/provider/get_my_today_matches_use_case_provider.dart';
// import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/load_my_matches/load_my_matches_use_case.dart';
// import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/load_my_matches/provider/load_my_matches_use_case_provider.dart';
// import 'package:five_on_4_mobile/src/features/matches/presentation/controllers/get_my_matches/provider/get_my_matches_controller.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';

// void main() {
//   setUpAll(() => {
//         registerFallbackValue(AsyncValue.data(_FakeMatchesStateValue())),
//       });
//   group(
//     "$GetMyMatchesController",
//     () {
//       group(
//         "NON-error state",
//         () {
//           test(
//             "given a controller instance and connected to internet"
//             "when instance is created"
//             "then emits state in specific order",
//             () async {
//               final getMyTodayMatchesUseCase = _MockGetMyTodayMatchesUseCase();
//               final loadMyMatchesUseCase = _MockLoadMyMatchesUseCase();

//               when(() => getMyTodayMatchesUseCase()).thenAnswer(
//                 (_) async => [],
//               );

//               when(() => loadMyMatchesUseCase()).thenAnswer(
//                 (_) async {},
//               );

//               final providerContainer = ProviderContainer(
//                 overrides: [
//                   getMyTodayMatchesUseCaseProvider.overrideWith(
//                     (ref) => getMyTodayMatchesUseCase,
//                   ),
//                   loadMyMatchesUseCaseProvider.overrideWith(
//                     (ref) => loadMyMatchesUseCase,
//                   ),
//                 ],
//               );

//               addTearDown(() {
//                 providerContainer.dispose();
//               });

//               // create a listener
//               final listener =
//                   _MockListener<AsyncValue<MatchesControllerState>>();

//               providerContainer.listen(
//                 getMyMatchesControllerProvider,
//                 listener,
//                 fireImmediately: true,
//               );

//               // wait for data to be fetched
//               await Future.delayed(Duration.zero);

//               verifyInOrder(
//                 [
//                   () => listener(
//                         null,
//                         const AsyncValue<MatchesControllerState>.loading(),
//                       ),
//                   () => listener(
//                         const AsyncValue<MatchesControllerState>.loading(),
//                         const AsyncValue<MatchesControllerState>.data(
//                           MatchesControllerState(
//                             isRemoteFetchDone: false,
//                             todayMatches: [],
//                             pastMatches: [],
//                             upcomingMatches: [],
//                           ),
//                         ),
//                       ),
//                   () => listener(
//                         const AsyncValue<MatchesControllerState>.data(
//                           MatchesControllerState(
//                             isRemoteFetchDone: false,
//                             todayMatches: [],
//                             pastMatches: [],
//                             upcomingMatches: [],
//                           ),
//                         ),
//                         const AsyncValue<MatchesControllerState>.data(
//                           MatchesControllerState(
//                             isRemoteFetchDone: true,
//                             todayMatches: [],
//                             pastMatches: [],
//                             upcomingMatches: [],
//                           ),
//                         ),
//                       ),
//                 ],
//               );
//             },
//           );
//         },
//       );
//       // TODO add error retrieval group
//     },
//   );
// }

// class _FakeMatchesStateValue extends Fake implements MatchesControllerState {}

// class _MockGetMyTodayMatchesUseCase extends Mock
//     implements GetMyTodayMatchesUseCase {}

// class _MockLoadMyMatchesUseCase extends Mock implements LoadMyMatchesUseCase {}

// // a generic Listener class, used to keep track of when a provider notifies its listeners - this is like consumer of the provider state
// class _MockListener<T> extends Mock {
//   void call(T? previous, T next);
// }

// TODO come back to this

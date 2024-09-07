import 'package:five_on_4_mobile/src/features/auth/domain/use_cases/sign_out/sign_out_use_case.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/models/match/match_model.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/get_match/get_match_use_case.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/load_match/load_match_use_case.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/controllers/get_match/provider/get_match_controller.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/get_it/get_it_wrapper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

void main() {
  final loadMatchUseCase = _MockLoadMatchUseCase();
  final getMatchUseCase = _MockGetMatchUseCase();
  final signOutUseCase = _MockSignOutUseCase();

  final listener = _MockListener<AsyncValue<GetMatchControllerState>>();

  setUpAll(() {
    registerFallbackValue(AsyncValue.data(_FakeGetMatchControllerState()));
  });

  setUpAll(() {
    // TODO does this register it evrywhere? for other tests too? check this eventually
    getIt.registerSingleton<LoadMatchUseCase>(loadMatchUseCase);
    getIt.registerSingleton<GetMatchUseCase>(getMatchUseCase);
    getIt.registerSingleton<SignOutUseCase>(signOutUseCase);
  });

  setUp(() {
    reset(loadMatchUseCase);
    reset(getMatchUseCase);
    reset(signOutUseCase);
    reset(listener);
  });

  group(
    "$GetMatchController",
    () {
      group(
        ".build()",
        () {
          // given there is an error when load match use case is called, should emit states in particular order
          test(
            "given there is an error when loading match into db"
            "when build() is called"
            "then should emit state events in particular order",
            () async {
              // setup
              final ProviderContainer providerContainer = ProviderContainer();

              // given
              when(
                () => loadMatchUseCase(matchId: any(named: "matchId")),
              ).thenThrow(Exception("Error loading match into db"));

              // when
              providerContainer.listen(
                getMatchControllerProvider(
                  matchId: 1,
                ),
                listener,
                fireImmediately: true,
              );
              await Future.delayed(Duration.zero);

              // then
              final captured = verifyInOrder([
                () => listener(
                      captureAny(), // null
                      captureAny(), // loading
                    ),
                () => listener(
                      captureAny(), // loading
                      captureAny(), // error
                    ),
              ]).captured;
              verifyNoMoreInteractions(listener);

              print("what");

              // verify states
              final firstCall = captured[0];
              final secondCall = captured[1];

              final firstCallFirstArg = firstCall[0];
              final firstCallSecondArg = firstCall[1];

              final secondCallFirstArg = secondCall[0];
              final secondCallSecondArg = secondCall[1];

              expect(
                firstCallFirstArg,
                isNull,
              );
              expect(firstCallSecondArg,
                  isA<AsyncLoading<GetMatchControllerState>>());

              expect(secondCallFirstArg,
                  isA<AsyncLoading<GetMatchControllerState>>());
              expect(secondCallSecondArg,
                  isA<AsyncError<GetMatchControllerState>>());

              expect(
                (secondCallSecondArg as AsyncError<GetMatchControllerState>)
                    .error,
                isA<Exception>(),
              );
              expect(
                secondCallSecondArg.error.toString(),
                "Exception: Error loading match into db",
              );
              // TODO this does not seem that good
              expect(
                (secondCallSecondArg).stackTrace.toString(),
                startsWith("#0      When.thenThrow.<anonymous closure>"),
              );

              // cleanup
              addTearDown(() {
                providerContainer.dispose();
              });
            },
          );

          // given there is an error when get match use case is called, should emit states in particular order
          test(
            "given there is an error when getting match from db"
            "when .build() is called"
            "then should emit state events in particular order",
            () async {
              // setup
              when(
                () => loadMatchUseCase(matchId: any(named: "matchId")),
              ).thenAnswer(
                (_) async {},
              );
              final ProviderContainer providerContainer = ProviderContainer();

              // given
              when(
                () => getMatchUseCase(matchId: any(named: "matchId")),
              ).thenThrow(Exception("Error getting match from db"));

              // when
              providerContainer.listen(
                getMatchControllerProvider(
                  matchId: 1,
                ),
                listener,
                fireImmediately: true,
              );
              await Future.delayed(Duration.zero);

              // then
              final captured = verifyInOrder([
                () => listener(
                      captureAny(), // null
                      captureAny(), // loading
                    ),
                () => listener(
                      captureAny(), // loading
                      captureAny(), // error
                    ),
              ]).captured;
              verifyNoMoreInteractions(listener);

              // verify states
              final firstCall = captured[0];
              final secondCall = captured[1];

              final firstCallFirstArg = firstCall[0];
              final firstCallSecondArg = firstCall[1];

              final secondCallFirstArg = secondCall[0];
              final secondCallSecondArg = secondCall[1];

              expect(
                firstCallFirstArg,
                isNull,
              );
              expect(firstCallSecondArg,
                  isA<AsyncLoading<GetMatchControllerState>>());

              expect(secondCallFirstArg,
                  isA<AsyncLoading<GetMatchControllerState>>());

              expect(secondCallSecondArg,
                  isA<AsyncError<GetMatchControllerState>>());
              expect(
                (secondCallSecondArg as AsyncError<GetMatchControllerState>)
                    .error,
                isA<Exception>(),
              );

              expect(
                (secondCallSecondArg).error.toString(),
                "Exception: Error getting match from db",
              );
              // TODO this does not seem that good
              expect(
                (secondCallSecondArg).stackTrace.toString(),
                startsWith("#0      When.thenThrow.<anonymous closure>"),
              );

              // cleanup
              addTearDown(() {
                providerContainer.dispose();
              });
            },
          );

          // given that match is loaded and fetched successfully, should emit states in particular order
          // TODO - also here test that use cases are called with correct arguments
          test(
            "given successful loading and fetching of match"
            "when .build() is called"
            "then should emit state events in particular order",
            () async {
              // setup
              final MatchModel matchModel = MatchModel(
                dateAndTime: DateTime.now(),
                id: 1,
                description: "description",
                location: "location",
                title: "title",
                participations: const [],
              );

              final ProviderContainer providerContainer = ProviderContainer();

              // given
              when(
                () => loadMatchUseCase(matchId: any(named: "matchId")),
              ).thenAnswer(
                (_) async {},
              );
              when(
                () => getMatchUseCase(matchId: any(named: "matchId")),
              ).thenAnswer(
                (_) async => matchModel,
              );

              // when
              providerContainer.listen(
                getMatchControllerProvider(
                  matchId: 1,
                ),
                listener,
                fireImmediately: true,
              );
              await Future.delayed(Duration.zero);

              // then
              final captured = verifyInOrder([
                () => listener(
                      captureAny(), // null
                      captureAny(), // loading
                    ),
                () => listener(
                      captureAny(), // loading
                      captureAny(), // data
                    ),
              ]).captured;
              verifyNoMoreInteractions(listener);

              // verify states
              final firstCall = captured[0];
              final secondCall = captured[1];

              final firstCallFirstArg = firstCall[0];
              final firstCallSecondArg = firstCall[1];

              final secondCallFirstArg = secondCall[0];
              final secondCallSecondArg = secondCall[1];

              expect(
                firstCallFirstArg,
                isNull,
              );
              expect(firstCallSecondArg,
                  isA<AsyncLoading<GetMatchControllerState>>());

              expect(secondCallFirstArg,
                  isA<AsyncLoading<GetMatchControllerState>>());
              expect(secondCallSecondArg,
                  isA<AsyncData<GetMatchControllerState>>());

              expect(
                (secondCallSecondArg as AsyncData<GetMatchControllerState>)
                    .value,
                isA<GetMatchControllerState>(),
              );

              expect(
                (secondCallSecondArg).value.match,
                matchModel,
              );
              expect(
                (secondCallSecondArg).value.isRemoteFetchDone,
                true,
              );

              print("what");

              // cleanup
              addTearDown(() {
                providerContainer.dispose();
              });
            },
          );
        },
      );

      // TODO there will be a test for sign out needed
    },
  );

  group(
    ".onGetMatch()",
    () {
      test(
        "given there is an error when loading match into db"
        "when onGetMatch() is called"
        "then should emit state events in particular order",
        () async {
          // setup
          final MatchModel matchModel = MatchModel(
            dateAndTime: DateTime.now(),
            id: 1,
            description: "description",
            location: "location",
            title: "title",
            participations: const [],
          );

          final ProviderContainer providerContainer = ProviderContainer();
          when(
            () => loadMatchUseCase(matchId: any(named: "matchId")),
          ).thenAnswer((_) async {});
          when(
            () => getMatchUseCase(matchId: any(named: "matchId")),
          ).thenAnswer((_) async => matchModel);

          // start listening
          providerContainer.listen(
            getMatchControllerProvider(
              matchId: 1,
            ),
            listener,
            fireImmediately: true,
          );
          await Future.delayed(Duration.zero);

          // verify initial states
          // NOTE: no need to verify initial states, as we have already done that in the previous test
          verifyInOrder([
            () => listener(
                  any(), // null
                  any(), // loading
                ),
            () => listener(
                  any(), // loading
                  any(), // data
                ),
          ]);
          verifyNoMoreInteractions(listener);

          // given
          when(
            () => loadMatchUseCase(matchId: any(named: "matchId")),
          ).thenThrow(Exception("Error loading match into db"));

          // when
          await providerContainer
              .read(getMatchControllerProvider(matchId: 1).notifier)
              .onGetMatch();

          final captured = verifyInOrder([
            () => listener(
                  captureAny(), // data
                  captureAny(), // loading
                ),
            () => listener(
                  captureAny(), // loading
                  captureAny(), // error
                ),
          ]).captured;
          verifyNoMoreInteractions(listener);

          // verify states
          final firstCall = captured[0];
          final secondCall = captured[1];

          final firstCallFirstArg = firstCall[0];
          final firstCallSecondArg = firstCall[1];

          final secondCallFirstArg = secondCall[0];
          final secondCallSecondArg = secondCall[1];

          expect(
            firstCallFirstArg,
            isA<AsyncData<GetMatchControllerState>>(),
          );
          expect(
            firstCallSecondArg,
            isA<AsyncLoading<GetMatchControllerState>>(),
          );

          expect(
            secondCallFirstArg,
            isA<AsyncLoading<GetMatchControllerState>>(),
          );
          expect(
            secondCallSecondArg,
            isA<AsyncError<GetMatchControllerState>>(),
          );

          // examine error state
          expect(
            (secondCallSecondArg as AsyncError<GetMatchControllerState>).error,
            equals("Exception: Error loading match into db"),
          );
          expect(
            (secondCallSecondArg).stackTrace,
            equals(StackTrace.empty),
          );

          //
          print("hell");

          // cleanup
          addTearDown(() {
            providerContainer.dispose();
          });
        },
      );

      test(
        "given there is an error when getting match from db"
        "when onGetMatch() is called"
        "then should emit state events in particular order",
        () async {
          // setup
          final MatchModel matchModel = MatchModel(
            dateAndTime: DateTime.now(),
            id: 1,
            description: "description",
            location: "location",
            title: "title",
            participations: const [],
          );

          final ProviderContainer providerContainer = ProviderContainer();
          when(
            () => loadMatchUseCase(matchId: any(named: "matchId")),
          ).thenAnswer((_) async {});
          when(
            () => getMatchUseCase(matchId: any(named: "matchId")),
          ).thenAnswer((_) async => matchModel);

          // start listening
          providerContainer.listen(
            getMatchControllerProvider(
              matchId: 1,
            ),
            listener,
            fireImmediately: true,
          );
          await Future.delayed(Duration.zero);

          // verify initial states
          // NOTE: no need to verify initial states, as we have already done that in the previous test
          verifyInOrder([
            () => listener(
                  any(), // null
                  any(), // loading
                ),
            () => listener(
                  any(), // loading
                  any(), // data
                ),
          ]);
          verifyNoMoreInteractions(listener);

          // given
          when(
            () => getMatchUseCase(matchId: any(named: "matchId")),
          ).thenThrow(Exception("Error getting match from db"));

          // when
          await providerContainer
              .read(getMatchControllerProvider(matchId: 1).notifier)
              .onGetMatch();

          final captured = verifyInOrder([
            () => listener(
                  captureAny(), // data
                  captureAny(), // loading
                ),
            () => listener(
                  captureAny(), // loading
                  captureAny(), // error
                ),
          ]).captured;
          verifyNoMoreInteractions(listener);

          // verify states
          final firstCall = captured[0];
          final secondCall = captured[1];

          final firstCallFirstArg = firstCall[0];
          final firstCallSecondArg = firstCall[1];

          final secondCallFirstArg = secondCall[0];
          final secondCallSecondArg = secondCall[1];

          expect(
            firstCallFirstArg,
            isA<AsyncData<GetMatchControllerState>>(),
          );
          expect(
            firstCallSecondArg,
            isA<AsyncLoading<GetMatchControllerState>>(),
          );

          expect(
            secondCallFirstArg,
            isA<AsyncLoading<GetMatchControllerState>>(),
          );
          expect(
            secondCallSecondArg,
            isA<AsyncError<GetMatchControllerState>>(),
          );

          // examine error state
          expect(
            (secondCallSecondArg as AsyncError<GetMatchControllerState>).error,
            equals("Exception: Error getting match from db"),
          );
          expect(
            (secondCallSecondArg).stackTrace,
            equals(StackTrace.empty),
          );

          //
          print("hell");

          // cleanup
          addTearDown(() {
            providerContainer.dispose();
          });
        },
      );

      test(
        "given successful loading and fetching of match"
        "when .onGetMatch() is called"
        "then should emit state events in particular order",
        () async {
          // setup
          final MatchModel matchModel = MatchModel(
            dateAndTime: DateTime.now(),
            id: 1,
            description: "description",
            location: "location",
            title: "title",
            participations: const [],
          );

          final ProviderContainer providerContainer = ProviderContainer();
          when(
            () => loadMatchUseCase(matchId: any(named: "matchId")),
          ).thenAnswer((_) async {});
          when(
            () => getMatchUseCase(matchId: any(named: "matchId")),
          ).thenAnswer((_) async => matchModel);

          // start listening
          providerContainer.listen(
            getMatchControllerProvider(
              matchId: 1,
            ),
            listener,
            fireImmediately: true,
          );
          await Future.delayed(Duration.zero);

          // verify initial states
          // NOTE: no need to verify initial states, as we have already done that in the previous test
          verifyInOrder([
            () => listener(
                  any(), // null
                  any(), // loading
                ),
            () => listener(
                  any(), // loading
                  any(), // data
                ),
          ]);
          verifyNoMoreInteractions(listener);

          // given
          // when(
          //   () => getMatchUseCase(matchId: any(named: "matchId")),
          // ).thenThrow(Exception("Error getting match from db"));

          // when
          await providerContainer
              .read(getMatchControllerProvider(matchId: 1).notifier)
              .onGetMatch();

          final captured = verifyInOrder([
            () => listener(
                  captureAny(), // data
                  captureAny(), // loading
                ),
            () => listener(
                  captureAny(), // loading
                  captureAny(), // error
                ),
          ]).captured;
          verifyNoMoreInteractions(listener);

          // verify states
          final firstCall = captured[0];
          final secondCall = captured[1];

          final firstCallFirstArg = firstCall[0];
          final firstCallSecondArg = firstCall[1];

          final secondCallFirstArg = secondCall[0];
          final secondCallSecondArg = secondCall[1];

          expect(
            firstCallFirstArg,
            isA<AsyncData<GetMatchControllerState>>(),
          );
          expect(
            firstCallSecondArg,
            isA<AsyncLoading<GetMatchControllerState>>(),
          );

          expect(
            secondCallFirstArg,
            isA<AsyncLoading<GetMatchControllerState>>(),
          );
          expect(
            secondCallSecondArg,
            isA<AsyncData<GetMatchControllerState>>(),
          );

          // examine data state
          expect(
            (secondCallSecondArg as AsyncData<GetMatchControllerState>).value,
            equals(GetMatchControllerState(
              isRemoteFetchDone: true,
              match: matchModel,
            )),
          );

          // expect(
          //   secondCallSecondArg,
          //   isA<AsyncError<GetMatchControllerState>>(),
          // );

          // // examine error state
          // expect(
          //   (secondCallSecondArg as AsyncError<GetMatchControllerState>).error,
          //   equals("Exception: Error getting match from db"),
          // );
          // expect(
          //   (secondCallSecondArg).stackTrace,
          //   equals(StackTrace.empty),
          // );

          //
          print("hell");

          // cleanup
          addTearDown(() {
            providerContainer.dispose();
          });
        },
      );

// copy above cases
    },
  );
}

class _MockLoadMatchUseCase extends Mock implements LoadMatchUseCase {}

class _MockGetMatchUseCase extends Mock implements GetMatchUseCase {}

class _MockSignOutUseCase extends Mock implements SignOutUseCase {}

class _MockListener<T> extends Mock {
  void call(T? previous, T next);
}

class _FakeGetMatchControllerState extends Fake
    implements GetMatchControllerState {}

// import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/get_match/get_match_use_case.dart';
// import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/get_match/provider/get_match_use_case_provider.dart';
// import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/load_match/load_match_use_case.dart';
// import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/load_match/provider/load_match_use_case_provider.dart';
// import 'package:five_on_4_mobile/src/features/matches/presentation/controllers/get_match/provider/get_match_controller.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';

// import '../../../../../../../../utils/data/test_models.dart';

// void main() {
//   group(
//     "$GetMatchController",
//     () {
//       group(
//         "NON-error state",
//         () {
//           test(
//             "given a controller instance and connected to internet"
//             "when instance is created "
//             "then emits state in specific order",
//             () async {
//               final match = getTestMatchModel();

//               final getMatchUseCase = _MockGetMatchUseCase();
//               final loadMatchUseCase = _MockLoadMatchUseCase();

//               when(
//                 () => loadMatchUseCase(
//                   matchId: match.id,
//                 ),
//               ).thenAnswer(
//                 (_) async => match.id,
//               );
//               when(
//                 () => getMatchUseCase(
//                   matchId: match.id,
//                 ),
//               ).thenAnswer(
//                 (_) async => match,
//               );

//               final providerContaiuner = ProviderContainer(
//                 overrides: [
//                   getMatchUseCaseProvider.overrideWith(
//                     (ref) => getMatchUseCase,
//                   ),
//                   loadMatchUseCaseProvider.overrideWith(
//                     (ref) => loadMatchUseCase,
//                   ),
//                 ],
//               );

//               // make sure disposed container to not overflow into other tests, i guess...
//               addTearDown(() {
//                 providerContaiuner.dispose();
//               });

//               // create a listener
//               final listener =
//                   _MockListener<AsyncValue<GetMatchControllerState>>();

//               final getMatchControllerProviderInstance =
//                   getMatchControllerProvider(
//                 matchId: match.id,
//               );

//               providerContaiuner.listen(
//                 getMatchControllerProviderInstance,
//                 listener,
//                 fireImmediately: true,
//               );

//               await Future.delayed(Duration.zero);

//               verifyInOrder([
//                 () => listener(
//                       null,
//                       const AsyncValue<GetMatchControllerState>.loading(),
//                     ),
//                 () => listener(
//                       const AsyncValue<GetMatchControllerState>.loading(),
//                       AsyncValue<GetMatchControllerState>.data(
//                           GetMatchControllerState(
//                         isRemoteFetchDone: false,
//                         match: match,
//                       )),
//                     ),
//                 () => listener(
//                       AsyncValue<GetMatchControllerState>.data(
//                         GetMatchControllerState(
//                           isRemoteFetchDone: false,
//                           match: match,
//                         ),
//                       ),
//                       AsyncValue<GetMatchControllerState>.data(
//                         GetMatchControllerState(
//                           isRemoteFetchDone: true,
//                           match: match,
//                         ),
//                       ),
//                     ),
//               ]);
//             },
//           );
//         },
//       );

//       // error state
//     },
//   );
// }

// class _MockGetMatchUseCase extends Mock implements GetMatchUseCase {}

// class _MockLoadMatchUseCase extends Mock implements LoadMatchUseCase {}

// // TODO this will just be a generic listener that we will monitor to verify state changes
// class _MockListener<T> extends Mock {
//   void call(T? previousState, T newState);
// }

// TODO come back to this

import 'package:five_on_4_mobile/src/features/auth/domain/models/authenticated_player/authenticated_player_model.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/use_cases/get_authenticated_player_model/get_authenticated_player_model_use_case.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/use_cases/sign_out/sign_out_use_case.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/create_match/create_match_use_case.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/values/match_create_data_value.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/values/match_create_input_args.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/controllers/create_match/provider/create_match_controller.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/get_it/get_it_wrapper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  final getAuthenticatedPlayerModelUseCase =
      _MockGetAuthenticatedPlayerModelUseCase();
  final createMatchUseCase = _MockCreateMatchUseCase();
  final signOutUseCase = _MockSignOutUseCase();

  final listener = _MockListener<AsyncValue<CreateMatchControllerState?>>();

  setUpAll(() {
    // registerFallbackValue(const AsyncValue.data(null));
    registerFallbackValue(AsyncValue.data(_FakeMatchCreateControllerState()));
    registerFallbackValue(_FakeMatchCreateDataValue());
  });

  setUpAll(() {
    getIt.registerSingleton<GetAuthenticatedPlayerModelUseCase>(
        getAuthenticatedPlayerModelUseCase);
    getIt.registerSingleton<CreateMatchUseCase>(createMatchUseCase);
    getIt.registerSingleton<SignOutUseCase>(signOutUseCase);
  });

  tearDown(() {
    reset(getAuthenticatedPlayerModelUseCase);
    reset(createMatchUseCase);
    reset(signOutUseCase);

    reset(listener);
  });

  group(
    "$CreateMatchController",
    () {
      group(
        ".build()",
        () {
          test(
            "given CreateMatchController"
            "when .build() is called"
            "then should emit expected state",
            () async {
              // setup
              final ProviderContainer providerContainer = ProviderContainer();

              // given

              // when
              providerContainer.listen(
                createMatchControllerProvider,
                listener,
                fireImmediately: true,
              );

              // then
              verifyInOrder(
                [
                  () => listener(
                        null,
                        const AsyncValue<CreateMatchControllerState?>.data(
                          null,
                        ),
                      ),
                ],
              );
              verifyNoMoreInteractions(listener);

              // cleanup
              addTearDown(() {
                providerContainer.dispose();
              });
            },
          );
        },
      );

      group(
        ".onCreateMatch()",
        () {
          // TODO extract this in some test generators like on backend
          const matchData = MatchCreateInputArgs(
            name: "name",
            description: "description",
            location: "location",
            playersForInvite: [],
            dateTime: 1,
          );
          const AuthenticatedPlayerModel authPlayerModel =
              AuthenticatedPlayerModel(
            playerId: 1,
            playerName: "name",
            playerNickname: "nickname",
          );
          // no state change if no match data is provided
          test(
            "given no match data is provided"
            "when .onCreateMatch() is called"
            "then should not emit any events",
            () async {
              // setup
              final ProviderContainer providerContainer = ProviderContainer();
              providerContainer.listen(
                createMatchControllerProvider,
                listener,
                fireImmediately: true,
              );
              // initial state
              verify(
                () => listener(
                  null,
                  const AsyncValue<CreateMatchControllerState?>.data(null),
                ),
              );

              // given
              const matchData = null;

              // when
              await providerContainer
                  .read(createMatchControllerProvider.notifier)
                  .onCreateMatch(
                    matchData,
                  );

              // // then
              verifyNoMoreInteractions(listener);

              // verify calls to use cases
              verifyNever(() => getAuthenticatedPlayerModelUseCase());
              verifyNever(
                  () => createMatchUseCase(matchData: any(named: "matchData")));
              verifyNever(() => signOutUseCase());

              // cleanup
              addTearDown(() {
                providerContainer.dispose();
              });
            },
          );

// error state if no authenticated user

          test(
            "given there is no authenticated player"
            "when .onCreateMatch() is called"
            "then should emite events in expected order",
            () async {
              // setup
              when(() => signOutUseCase()).thenAnswer(
                (_) async {},
              );

              final ProviderContainer providerContainer = ProviderContainer();
              providerContainer.listen(
                createMatchControllerProvider,
                listener,
                fireImmediately: true,
              );
              // initial state
              verify(
                () => listener(
                  null,
                  const AsyncValue<CreateMatchControllerState?>.data(null),
                ),
              );

              // given
              when(() => getAuthenticatedPlayerModelUseCase()).thenAnswer(
                (_) async => null,
              );

              // when
              await providerContainer
                  .read(createMatchControllerProvider.notifier)
                  .onCreateMatch(matchData);

              // then
              verifyInOrder([
                () => listener(
                      const AsyncValue<CreateMatchControllerState?>.data(null),
                      const AsyncValue<CreateMatchControllerState?>.loading(),
                    ),
                () => listener(
                      const AsyncValue<CreateMatchControllerState?>.loading(),
                      const AsyncValue<CreateMatchControllerState?>.error(
                        "User is not logged in",
                        StackTrace.empty,
                      ),
                    ),
              ]);
              verifyNoMoreInteractions(listener);

              // verify calls to use cases
              verify(() => getAuthenticatedPlayerModelUseCase()).called(1);
              verify(() => signOutUseCase()).called(1);

              verifyNever(
                  () => createMatchUseCase(matchData: any(named: "matchData")));

              // cleanup
              addTearDown(() {
                providerContainer.dispose();
              });
            },
          );

// error state if error during match creation
          test(
            "given there is an error during match creation"
            "when .onCreateMatch() is called"
            "then should emit events in expected order",
            () async {
              // setup
              when(() => getAuthenticatedPlayerModelUseCase())
                  .thenAnswer((_) async => authPlayerModel);

              final ProviderContainer providerContainer = ProviderContainer();
              providerContainer.listen(
                createMatchControllerProvider,
                listener,
                fireImmediately: true,
              );
              // initial state
              verify(
                () => listener(
                  null,
                  const AsyncValue<CreateMatchControllerState?>.data(null),
                ),
              );

              // given
              when(() => createMatchUseCase(matchData: any(named: "matchData")))
                  .thenThrow(
                Exception("Some error"),
              );

              // when
              await providerContainer
                  .read(createMatchControllerProvider.notifier)
                  .onCreateMatch(matchData);

              // then
              verifyInOrder([
                () => listener(
                      const AsyncValue<CreateMatchControllerState?>.data(null),
                      const AsyncValue<CreateMatchControllerState?>.loading(),
                    ),
                () => listener(
                    const AsyncValue<CreateMatchControllerState?>.loading(),
                    const AsyncValue<CreateMatchControllerState?>.error(
                      "There was an issue creating the match",
                      StackTrace.empty,
                    )),
              ]);
              verifyNoMoreInteractions(listener);

              // verify calls to use cases

              final MatchCreateDataValue expectedMatchCreateDataValue =
                  MatchCreateDataValue(
                name: matchData.name,
                description: matchData.description,
                location: matchData.location,
                dateTime: matchData.dateTime,
                organizer: authPlayerModel.playerNickname,
                invitedPlayers: matchData.playersForInvite,
              );
              verify(() => createMatchUseCase(
                  matchData: expectedMatchCreateDataValue)).called(1);

              verify(() => getAuthenticatedPlayerModelUseCase()).called(1);
              verifyNever(() => signOutUseCase());

              // cleanup
              addTearDown(() {
                providerContainer.dispose();
              });
            },
          );

// data state if match is created successfully
          test(
            "given match is created successfully"
            "when .onCreateMatch() is called"
            "then should emit state events in expected order",
            () async {
              // setup
              when(() => getAuthenticatedPlayerModelUseCase())
                  .thenAnswer((_) async => authPlayerModel);

              final ProviderContainer providerContainer = ProviderContainer();
              providerContainer.listen(
                createMatchControllerProvider,
                listener,
                fireImmediately: true,
              );
              // initial state
              verify(
                () => listener(
                  null,
                  const AsyncValue<CreateMatchControllerState?>.data(null),
                ),
              );

              // given
              when(() => createMatchUseCase(matchData: any(named: "matchData")))
                  .thenAnswer(
                (_) async => 1,
              );

              // when
              await providerContainer
                  .read(createMatchControllerProvider.notifier)
                  .onCreateMatch(matchData);

              // then
              verifyInOrder([
                () => listener(
                      const AsyncValue<CreateMatchControllerState?>.data(null),
                      const AsyncValue<CreateMatchControllerState?>.loading(),
                    ),
                () => listener(
                      const AsyncValue<CreateMatchControllerState?>.loading(),
                      const AsyncValue<CreateMatchControllerState?>.data(
                        CreateMatchControllerState(
                          matchId: 1,
                        ),
                      ),
                    ),
              ]);
              verifyNoMoreInteractions(listener);

              // verify calls to use cases
              final MatchCreateDataValue expectedMatchCreateDataValue =
                  MatchCreateDataValue(
                name: matchData.name,
                description: matchData.description,
                location: matchData.location,
                dateTime: matchData.dateTime,
                organizer: authPlayerModel.playerNickname,
                invitedPlayers: matchData.playersForInvite,
              );
              verify(() => createMatchUseCase(
                  matchData: expectedMatchCreateDataValue)).called(1);

              verify(() => getAuthenticatedPlayerModelUseCase()).called(1);
              verifyNever(() => signOutUseCase());

              // cleanup
              addTearDown(() {
                providerContainer.dispose();
              });
            },
          );
        },
      );
    },
  );
}

// TODO maybe backend can do this - but lets save this for some other time
class _MockGetAuthenticatedPlayerModelUseCase extends Mock
    implements GetAuthenticatedPlayerModelUseCase {}

class _MockCreateMatchUseCase extends Mock implements CreateMatchUseCase {}

class _MockSignOutUseCase extends Mock implements SignOutUseCase {}

class _MockListener<T> extends Mock {
  void call(T? previous, T next);
}

// TODO test only
class _FakeMatchCreateControllerState extends Fake
    implements CreateMatchControllerState {}

class _FakeMatchCreateDataValue extends Fake implements MatchCreateDataValue {}

// should emite events in expected order if user is not logged in

// should logout user if user is not logged in - call use case

// should emit error state if there is an error during match creation

// if 401, again logout user

// should emit data state if match is created successfully

// should call create match case with expected arguments

// TODO - old --------------------

// import 'package:five_on_4_mobile/src/features/auth/domain/use_cases/get_auth_data_status/get_auth_data_status_use_case.dart';
// import 'package:five_on_4_mobile/src/features/auth/domain/use_cases/get_auth_data_status/provider/get_auth_data_status_use_case_provider.dart';
// import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/create_match/create_match_use_case.dart';
// import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/create_match/provider/create_match_use_case_provider.dart';
// import 'package:five_on_4_mobile/src/features/matches/domain/values/match_create_data_value.dart';
// import 'package:five_on_4_mobile/src/features/matches/domain/values/match_create_input_args.dart';
// import 'package:five_on_4_mobile/src/features/matches/presentation/controllers/create_match/provider/create_match_controller.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';

// import '../../../../../../../../utils/data/test_models.dart';
// import '../../../../../../../../utils/data/test_values.dart';

// TODO come back to this

// // TODO async notifier tests guide - https://codewithandrea.com/articles/unit-test-async-notifier-riverpod/

// void main() {
//   final getAuthDataStatusUseCase = _MockGetAuthDataStatusUseCase();
//   final createMatchUseCase = _MockCreateMatchUseCase();
//   final listener = _MockListener<AsyncValue<CreateMatchControllerState?>>();

//   setUpAll(() {
//     registerFallbackValue(_FakeMatchCreateDataValue());
//     registerFallbackValue(AsyncValue.data(_FakeMatchCreateControllerState()));
//   });

//   tearDown(() {
//     reset(getAuthDataStatusUseCase);
//     reset(createMatchUseCase);
//     reset(listener);
//   });
//   group(
//     "$CreateMatchController",
//     () {
//       group(
//         ".onCreateMatch()",
//         () {
//           const matchId = 1;
//           final authDataModel = getTestAuthDataModels(count: 1).first;
//           final matchData = getTestMatchCreateValues(count: 1).first;
//           final createMatchArgs = MatchCreateInputArgs(
//             name: matchData.name,
//             description: matchData.description,
//             location: matchData.location,
//             playersForInvite: matchData.invitedPlayers,
//             dateTime: matchData.dateTime,
//           );

//           test(
//             "given user is not logged in "
//             "when call '.onCreateMatch()' "
//             "then should emit expected error state ",
//             () async {
//               // Given
//               when(() => getAuthDataStatusUseCase()).thenAnswer(
//                 (_) async => null,
//               );

//               final providerContainer = ProviderContainer(
//                 overrides: [
//                   // TODO temp - come back to
//                   // getAuthDataStatusUseCaseProvider.overrideWith(
//                   //   (ref) => getAuthDataStatusUseCase,
//                   // ),
//                 ],
//               );

//               addTearDown(() {
//                 providerContainer.dispose();
//               });

//               providerContainer.listen(
//                 createMatchControllerProvider,
//                 listener,
//                 fireImmediately: true,
//               );

//               // this is initial state
//               verify(
//                 () => listener(
//                   null,
//                   const AsyncValue<CreateMatchControllerState?>.data(null),
//                 ),
//               );

//               await providerContainer
//                   .read(createMatchControllerProvider.notifier)
//                   .onCreateMatch(
//                     createMatchArgs,
//                   );

//               // now check two states
//               verifyInOrder([
//                 () => listener(
//                       const AsyncValue<CreateMatchControllerState?>.data(null),
//                       const AsyncValue<CreateMatchControllerState?>.loading(),
//                     ),
//                 () => listener(
//                       const AsyncValue<CreateMatchControllerState?>.loading(),
//                       const AsyncValue<CreateMatchControllerState?>.error(
//                         "User is not logged in",
//                         StackTrace.empty,
//                       ),
//                     ),
//               ]);

//               verifyNoMoreInteractions(listener);
//             },
//           );

//           test(
//             "given an error during match creation "
//             "when call '.onCreateMatch()' "
//             "then should emit expected error state ",
//             () async {
//               // Given
//               when(() => getAuthDataStatusUseCase()).thenAnswer(
//                 (_) async => authDataModel,
//               );
//               when(() => createMatchUseCase(matchData: any(named: "matchData")))
//                   .thenThrow(
//                 Exception("Some error"),
//               );

//               final providerContainer = ProviderContainer(
//                 overrides: [
//                   getAuthDataStatusUseCaseProvider.overrideWith(
//                     (ref) => getAuthDataStatusUseCase,
//                   ),
//                   createMatchUseCaseProvider.overrideWith(
//                     (ref) => createMatchUseCase,
//                   ),
//                 ],
//               );
//               addTearDown(() {
//                 providerContainer.dispose();
//               });

//               providerContainer.listen(
//                 createMatchControllerProvider,
//                 listener,
//                 fireImmediately: true,
//               );

//               // get rid of the first state
//               verify(
//                 () => listener(
//                   null,
//                   const AsyncValue<CreateMatchControllerState?>.data(null),
//                 ),
//               );

//               // When
//               await providerContainer
//                   .read(createMatchControllerProvider.notifier)
//                   .onCreateMatch(
//                     createMatchArgs,
//                   );

//               // Then
//               verifyInOrder(
//                 [
//                   () => listener(
//                         const AsyncValue<CreateMatchControllerState?>.data(
//                             null),
//                         const AsyncValue<CreateMatchControllerState?>.loading(),
//                       ),
//                   () => listener(
//                         const AsyncValue<CreateMatchControllerState?>.loading(),
//                         const AsyncValue<CreateMatchControllerState?>.error(
//                           "There was an issue creating the match",
//                           StackTrace.empty,
//                         ),
//                       ),
//                 ],
//               );

//               verifyNoMoreInteractions(listener);
//             },
//           );

//           test(
//             "given a successfull creation of match "
//             "when call '.onCreateMatch()' "
//             "then should emit state in specific order",
//             () async {
//               // Given
//               when(() => getAuthDataStatusUseCase()).thenAnswer(
//                 (_) async => authDataModel,
//               );
//               when(() => createMatchUseCase(matchData: any(named: "matchData")))
//                   .thenAnswer(
//                 (_) async => matchId,
//               );

//               final providerContainer = ProviderContainer(
//                 overrides: [
//                   getAuthDataStatusUseCaseProvider.overrideWith(
//                     (ref) => getAuthDataStatusUseCase,
//                   ),
//                   createMatchUseCaseProvider.overrideWith(
//                     (ref) => createMatchUseCase,
//                   ),
//                 ],
//               );
//               addTearDown(() {
//                 providerContainer.dispose();
//               });

//               providerContainer.listen(
//                 createMatchControllerProvider,
//                 listener,
//                 fireImmediately: true,
//               );

//               // get rid of the first state
//               verify(
//                 () => listener(
//                   null,
//                   const AsyncValue<CreateMatchControllerState?>.data(null),
//                 ),
//               );

//               // When
//               await providerContainer
//                   .read(createMatchControllerProvider.notifier)
//                   .onCreateMatch(
//                     createMatchArgs,
//                   );

//               // Then
//               verifyInOrder(
//                 [
//                   () => listener(
//                         const AsyncValue<CreateMatchControllerState?>.data(
//                           null,
//                         ),
//                         const AsyncValue<CreateMatchControllerState?>.loading(),
//                       ),
//                   () => listener(
//                         const AsyncValue<CreateMatchControllerState?>.loading(),
//                         const AsyncValue<CreateMatchControllerState?>.data(
//                           CreateMatchControllerState(
//                             matchId: matchId,
//                           ),
//                         ),
//                       ),
//                 ],
//               );

//               verifyNoMoreInteractions(listener);
//             },
//           );
//         },
//       );
//     },
//   );
// }

// class _FakeMatchCreateDataValue extends Fake implements MatchCreateDataValue {}

// // TODO possibly not needed
// class _FakeMatchCreateControllerState extends Fake
//     implements CreateMatchControllerState {}

// class _MockGetAuthDataStatusUseCase extends Mock
//     implements GetAuthDataStatusUseCase {}

// class _MockCreateMatchUseCase extends Mock implements CreateMatchUseCase {}

// class _MockListener<T> extends Mock {
//   void call(T? previous, T next);
// }

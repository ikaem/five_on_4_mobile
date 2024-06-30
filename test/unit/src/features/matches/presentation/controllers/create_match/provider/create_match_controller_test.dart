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

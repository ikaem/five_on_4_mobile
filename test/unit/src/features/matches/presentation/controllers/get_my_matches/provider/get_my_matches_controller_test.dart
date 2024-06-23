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

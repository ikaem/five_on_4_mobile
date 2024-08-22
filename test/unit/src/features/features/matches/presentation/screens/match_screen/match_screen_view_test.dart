// import 'package:five_on_4_mobile/src/features/core/presentation/widgets/tab_toggler/tab_toggler.dart';
// import 'package:five_on_4_mobile/src/features/matches/domain/models/match/match_model.dart';
// import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/get_match/get_match_use_case.dart';
// import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/get_match/provider/get_match_use_case_provider.dart';
// import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/load_match/load_match_use_case.dart';
// import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/load_match/provider/load_match_use_case_provider.dart';
// import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match/match_info_container.dart';
// import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match/match_participants_container.dart';
// import 'package:five_on_4_mobile/src/features/matches/presentation/screens/match_screen/match_screen_view.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';

// import '../../../../../../../utils/data/test_models.dart';
// import '../../../../../../../utils/extensions/widget_tester_extension.dart';

// void main() {
//   final testPlayers = getTestPlayersModels();
//   final testMatch = getTestMatchModel(arrivingPlayers: testPlayers);

//   final getMatchUseCase = _MockGetMatchUseCase();
//   final loadMatchUseCase = _MockLoadMatchUseCase();

//   final overrides = [
//     getMatchUseCaseProvider.overrideWith((ref) => getMatchUseCase),
//     loadMatchUseCaseProvider.overrideWith((ref) => loadMatchUseCase),
//   ];

//   tearDown(() {
//     reset(getMatchUseCase);
//     reset(loadMatchUseCase);
//   });

//   group(
//     "$MatchScreenView",
//     () {
//       group(
//         "Layout",
//         () {
//           testWidgets(
//             "given nothing in particular"
//             "when widget is rendered"
//             "should show a [TabToggler] with expected arguments",
//             (widgetTester) async {
//               _stubGetMatchUseCases(
//                 getMatchUseCase: getMatchUseCase,
//                 loadMatchUseCase: loadMatchUseCase,
//                 loadMatchCallback: () => testMatch.id,
//                 getMatchCallback: () => testMatch,
//               );

//               await widgetTester.pumpWithProviderScope(
//                 widget: MaterialApp(
//                   home: Scaffold(
//                     body: MatchScreenView(
//                       matchId: testMatch.id,
//                     ),
//                   ),
//                 ),
//                 overrides: overrides,
//               );

//               final tabTogglerFinder = _findTabToggler();

//               expect(tabTogglerFinder, findsOneWidget);
//             },
//           );
//         },
//       );

//       group(
//         "State Reactivity",
//         () {
//           testWidgets(
//             "given GetMatchController emits loading state "
//             "when widget is rendered "
//             "then should show [TabToggler] widget with expected arguments passed to it",
//             (widgetTester) async {
//               _stubGetMatchUseCases(
//                 getMatchUseCase: getMatchUseCase,
//                 loadMatchUseCase: loadMatchUseCase,
//                 loadMatchCallback: () => testMatch.id,
//                 getMatchCallback: () => testMatch,
//               );

//               await widgetTester.pumpWithProviderScope(
//                 widget: MaterialApp(
//                   home: Scaffold(
//                     body: MatchScreenView(
//                       matchId: testMatch.id,
//                     ),
//                   ),
//                 ),
//                 overrides: overrides,
//               );

//               final tabTogglerFinder = _findTabToggler(
//                 propertyChecker: ({
//                   required MatchInfoContainer matchInfoContainer,
//                   required MatchParticipantsContainer
//                       matchParticipantsContainer,
//                 }) {
//                   if (!matchInfoContainer.isLoading) return false;
//                   if (!matchParticipantsContainer.isLoading) return false;

//                   return true;
//                 },
//               );

//               expect(tabTogglerFinder, findsOneWidget);
//             },
//           );
//           testWidgets(
//             "given GetMatchController emits error state "
//             "when widget is rendered "
//             "then should show [TabToggler] widget with expected arguments passed to it",
//             (widgetTester) async {
//               _stubGetMatchUseCases(
//                 getMatchUseCase: getMatchUseCase,
//                 loadMatchUseCase: loadMatchUseCase,
//                 loadMatchCallback: () => throw Exception(),
//                 getMatchCallback: () => testMatch,
//               );

//               await widgetTester.pumpWithProviderScope(
//                 widget: MaterialApp(
//                   home: Scaffold(
//                     body: MatchScreenView(
//                       matchId: testMatch.id,
//                     ),
//                   ),
//                 ),
//                 overrides: overrides,
//               );

//               await widgetTester.pump();

//               final tabTogglerFinder = _findTabToggler(
//                 propertyChecker: ({
//                   required MatchInfoContainer matchInfoContainer,
//                   required MatchParticipantsContainer
//                       matchParticipantsContainer,
//                 }) {
//                   if (!matchInfoContainer.isError) return false;
//                   if (!matchParticipantsContainer.isError) return false;

//                   return true;
//                 },
//               );

//               expect(tabTogglerFinder, findsOneWidget);
//             },
//           );

//           testWidgets(
//             "given GetMatchController emits data state with 'isRemoteFetchDone' set to false "
//             "when widget is rendered "
//             "then should show [TabToggler] widget with expected arguments passed to it",
//             (widgetTester) async {
//               _stubGetMatchUseCases(
//                 getMatchUseCase: getMatchUseCase,
//                 loadMatchUseCase: loadMatchUseCase,
//                 loadMatchCallback: () => testMatch.id,
//                 getMatchCallback: () => testMatch,
//                 shouldSimulateLoadFromServerDelay: true,
//               );

//               await widgetTester.pumpWithProviderScope(
//                 widget: MaterialApp(
//                   home: Scaffold(
//                     body: MatchScreenView(
//                       matchId: testMatch.id,
//                     ),
//                   ),
//                 ),
//                 overrides: overrides,
//               );

//               await widgetTester.pump();

//               final tabTogglerFinder = _findTabToggler(
//                 propertyChecker: ({
//                   required MatchInfoContainer matchInfoContainer,
//                   required MatchParticipantsContainer
//                       matchParticipantsContainer,
//                 }) {
//                   if (!matchInfoContainer.isSyncing) return false;
//                   if (!matchParticipantsContainer.isSyncing) return false;

//                   return true;
//                 },
//               );

//               expect(tabTogglerFinder, findsOneWidget);

//               // await for server delay to finish
//               await widgetTester.pumpAndSettle();
//             },
//           );

//           testWidgets(
//             "given GetMatchController emits data state with 'isRemoteFetchDone' set to true "
//             "when widget is rendered "
//             "then should show [TabToggler] widget with expected arguments passed to it",
//             (widgetTester) async {
//               _stubGetMatchUseCases(
//                 getMatchUseCase: getMatchUseCase,
//                 loadMatchUseCase: loadMatchUseCase,
//                 loadMatchCallback: () => testMatch.id,
//                 getMatchCallback: () => testMatch,
//               );

//               await widgetTester.pumpWithProviderScope(
//                 widget: MaterialApp(
//                   home: Scaffold(
//                     body: MatchScreenView(
//                       matchId: testMatch.id,
//                     ),
//                   ),
//                 ),
//                 overrides: overrides,
//               );

//               await widgetTester.pumpAndSettle();

//               final tabTogglerFinder = _findTabToggler(
//                 propertyChecker: ({
//                   required MatchInfoContainer matchInfoContainer,
//                   required MatchParticipantsContainer
//                       matchParticipantsContainer,
//                 }) {
//                   if (matchInfoContainer.isSyncing) return false;
//                   if (matchParticipantsContainer.isSyncing) return false;

//                   return true;
//                 },
//               );

//               expect(tabTogglerFinder, findsOneWidget);
//             },
//           );

//           testWidgets(
//             "given GetMatchController emits data state "
//             "when widget is rendered "
//             "then should show [TabToggler] widget with expected arguments passed to it",
//             (widgetTester) async {
//               _stubGetMatchUseCases(
//                 getMatchUseCase: getMatchUseCase,
//                 loadMatchUseCase: loadMatchUseCase,
//                 loadMatchCallback: () => testMatch.id,
//                 getMatchCallback: () => testMatch,
//               );

//               await widgetTester.pumpWithProviderScope(
//                 widget: MaterialApp(
//                   home: Scaffold(
//                     body: MatchScreenView(
//                       matchId: testMatch.id,
//                     ),
//                   ),
//                 ),
//                 overrides: overrides,
//               );

//               await widgetTester.pumpAndSettle();

//               final tabTogglerFinder = _findTabToggler(
//                 propertyChecker: ({
//                   required MatchInfoContainer matchInfoContainer,
//                   required MatchParticipantsContainer
//                       matchParticipantsContainer,
//                 }) {
//                   if (matchInfoContainer.match != testMatch) return false;
//                   if (matchParticipantsContainer.participants !=
//                       testMatch.arrivingPlayers) return false;

//                   return true;
//                 },
//               );

//               expect(tabTogglerFinder, findsOneWidget);
//             },
//           );
//         },
//       );
//     },
//   );
// }

// class _MockGetMatchUseCase extends Mock implements GetMatchUseCase {}

// class _MockLoadMatchUseCase extends Mock implements LoadMatchUseCase {}

// void _stubGetMatchUseCases({
//   required GetMatchUseCase getMatchUseCase,
//   required LoadMatchUseCase loadMatchUseCase,
//   required int Function() loadMatchCallback,
//   required MatchModel Function() getMatchCallback,
//   bool shouldSimulateLoadFromServerDelay = false,
// }) {
//   when(
//     () => getMatchUseCase(
//       matchId: any(named: "matchId"),
//     ),
//   ).thenAnswer((_) async => getMatchCallback());

//   when(
//     () => loadMatchUseCase(
//       matchId: any(
//         named: "matchId",
//       ),
//     ),
//   ).thenAnswer(
//     (_) async {
//       if (shouldSimulateLoadFromServerDelay) {
//         await Future.delayed(Duration.zero);
//       }
//       return loadMatchCallback();
//     },
//   );
// }

// Finder _findTabToggler({
//   bool Function({
//     required MatchInfoContainer matchInfoContainer,
//     required MatchParticipantsContainer matchParticipantsContainer,
//   })? propertyChecker,
// }) {
//   final tabTogglerFinder = find.byWidgetPredicate((widget) {
//     if (widget is! TabToggler) return false;
//     if (widget.options.length != 2) return false;

//     final option1 = widget.options[0];
//     final option2 = widget.options[1];

//     final option1Title = option1.title;
//     final option2Title = option2.title;

//     if (option1Title != "Info") return false;
//     if (option2Title != "Participants") return false;

//     final option1Child = option1.child;
//     final option2Child = option2.child;

//     if (option1Child is! MatchInfoContainer) return false;
//     if (option2Child is! MatchParticipantsContainer) return false;

//     if (propertyChecker == null) return true;

//     final doChildrenPropertiesMatch = propertyChecker(
//       matchInfoContainer: option1Child,
//       matchParticipantsContainer: option2Child,
//     );
//     return doChildrenPropertiesMatch;
//   });

//   return tabTogglerFinder;
// }


// TODO come back to this

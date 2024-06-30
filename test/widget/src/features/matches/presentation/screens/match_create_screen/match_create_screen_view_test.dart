// import 'package:five_on_4_mobile/src/features/auth/domain/models/auth_data/auth_data_model.dart';
// import 'package:five_on_4_mobile/src/features/auth/domain/use_cases/get_auth_data_status/get_auth_data_status_use_case.dart';
// import 'package:five_on_4_mobile/src/features/auth/domain/use_cases/get_auth_data_status/provider/get_auth_data_status_use_case_provider.dart';
// import 'package:five_on_4_mobile/src/features/core/presentation/widgets/tab_toggler/tab_toggler.dart';
// import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/create_match/create_match_use_case.dart';
// import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/create_match/provider/create_match_use_case_provider.dart';
// import 'package:five_on_4_mobile/src/features/matches/domain/values/match_create_data_value.dart';
// import 'package:five_on_4_mobile/src/features/matches/domain/values/match_create_input_args.dart';
// import 'package:five_on_4_mobile/src/features/matches/presentation/controllers/create_match/provider/create_match_controller.dart';
// import 'package:five_on_4_mobile/src/features/matches/presentation/controllers/create_match_inputs/create_match_inputs_controller.dart';
// import 'package:five_on_4_mobile/src/features/matches/presentation/controllers/create_match_inputs/provider/create_match_inputs_controller_provider.dart';
// import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match_create/match_create_info_container.dart';
// import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match_create/match_create_participants_container.dart';
// import 'package:five_on_4_mobile/src/features/matches/presentation/screens/match_create_screen/match_create_screen_view.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';

// import '../../../../../../../utils/data/test_models.dart';
// import '../../../../../../../utils/extensions/widget_tester_extension.dart';

// void main() {
//   final createMatchUseCase = _MockCreateMatchUseCase();
//   final getAuthDataStatusUseCase = _MockGetAuthDataStatusUseCase();

//   final overrides = [
//     createMatchUseCaseProvider.overrideWith((ref) => createMatchUseCase),
//     getAuthDataStatusUseCaseProvider
//         .overrideWith((ref) => getAuthDataStatusUseCase),
//   ];

//   setUpAll(() {
//     registerFallbackValue(_FakeMatchCreateDataValue());
//   });

//   tearDown(() {
//     reset(createMatchUseCase);
//     reset(getAuthDataStatusUseCase);
//   });
//   group(
//     "$MatchCreateScreenView",
//     () {
//       group(
//         "Layout",
//         () {
//           testWidgets(
//             "given MatchCreateScreenView dependencies are provided "
//             "when the widget is rendered "
//             "then should should show a [TabToggler] with expected arguments",
//             (tester) async {
//               // setup

//               // given
//               _stubCreateMatchControllerDependencies(
//                 createMatchUseCase: createMatchUseCase,
//                 getAuthDataStatusUseCase: getAuthDataStatusUseCase,
//                 createMatchCallback: () async {
//                   await Future.delayed(Duration.zero);
//                   return 1;
//                 },
//                 getAuthDataStatusCallback: () async => null,
//               );

//               // when
//               await tester.pumpWithProviderScope(
//                 overrides: overrides,
//                 widget: const MaterialApp(
//                   home: Scaffold(
//                     body: MatchCreateScreenView(),
//                   ),
//                 ),
//               );

//               // then
//               final tabTogglerFinder = _findTabToggler();

//               expect(tabTogglerFinder, findsOneWidget);

//               // cleanup
//             },
//           );

//           // TODO maybe this should be under a different group - like "StateReactivity"
//           // TODO test that button is disabled when inputs are not validated
//           testWidgets(
//             "given create match inputs are invalid"
//             "when Icons.save button is rendered"
//             "then should should have a disabled state",
//             (tester) async {
//               // setup
//               _stubCreateMatchControllerDependencies(
//                 createMatchUseCase: createMatchUseCase,
//                 getAuthDataStatusUseCase: getAuthDataStatusUseCase,
//                 createMatchCallback: () async {
//                   return 1;
//                 },
//                 getAuthDataStatusCallback: () async => null,
//               );

//               final inputsController = _MockCreateMatchInputsController();
//               _stubCreateMatchInputsController(
//                 inputsController,
//                 onGetValidatedNameStream: const Stream<String>.empty(),
//                 onGetValidatedLocationStream: const Stream<String>.empty(),
//                 onGetValidatedDescriptionStream: const Stream<String>.empty(),
//                 onGetValidatedDateTimeStream: const Stream<DateTime>.empty(),
//                 // given
//                 onGetAreInputsValidStream: Stream<bool>.value(false),
//                 onGetValidatedMatchCreateInputArgs: null,
//               );

//               final localOverrides = [
//                 createMatchInputsControllerProvider
//                     .overrideWith((ref) => inputsController),
//               ];

//               await tester.pumpWithProviderScope(
//                 overrides: localOverrides,
//                 widget: const MaterialApp(
//                   home: Scaffold(
//                     body: MatchCreateScreenView(),
//                   ),
//                 ),
//               );
//               // TODO wait until first stream for is validated is emitted
//               await tester.pump();

//               final submitButtonFinder = find.ancestor(
//                 of: find.byIcon(Icons.save),
//                 matching: find.byType(IconButton),
//               );
//               final submitButton =
//                   tester.widget<IconButton>(submitButtonFinder);
//               final onPressed = submitButton.onPressed;

//               // then
//               expect(onPressed, isNull);
//             },
//           );

//           testWidgets(
//             "given create match inputs are valid"
//             "when Icons.save button is rendered"
//             "then should should have an enabled state",
//             (tester) async {
//               // setup
//               _stubCreateMatchControllerDependencies(
//                 createMatchUseCase: createMatchUseCase,
//                 getAuthDataStatusUseCase: getAuthDataStatusUseCase,
//                 createMatchCallback: () async {
//                   return 1;
//                 },
//                 getAuthDataStatusCallback: () async => null,
//               );

//               final inputsController = _MockCreateMatchInputsController();
//               _stubCreateMatchInputsController(inputsController,
//                   onGetValidatedNameStream: const Stream<String>.empty(),
//                   onGetValidatedLocationStream: const Stream<String>.empty(),
//                   onGetValidatedDescriptionStream: const Stream<String>.empty(),
//                   onGetValidatedDateTimeStream: const Stream<DateTime>.empty(),
//                   // given
//                   onGetAreInputsValidStream: Stream<bool>.value(true),
//                   // TODO abstract this because it is used in  the one below too
//                   onGetValidatedMatchCreateInputArgs: MatchCreateInputArgs(
//                     name: "name",
//                     location: "location",
//                     description: "description",
//                     playersForInvite: const [],
//                     dateTime: DateTime.now()
//                         .add(const Duration(days: 1))
//                         .millisecondsSinceEpoch,
//                   ));

//               final localOverrides = [
//                 createMatchInputsControllerProvider
//                     .overrideWith((ref) => inputsController),
//               ];

//               await tester.pumpWithProviderScope(
//                 overrides: localOverrides,
//                 widget: const MaterialApp(
//                   home: Scaffold(
//                     body: MatchCreateScreenView(),
//                   ),
//                 ),
//               );
//               // TODO wait until first stream for is validated is emitted
//               await tester.pump();

//               final submitButtonFinder = find.ancestor(
//                 of: find.byIcon(Icons.save),
//                 matching: find.byType(IconButton),
//               );
//               final submitButton =
//                   tester.widget<IconButton>(submitButtonFinder);
//               final onPressed = submitButton.onPressed;

//               // then
//               expect(onPressed, isNotNull);
//             },
//           );
//           testWidgets(
//             // TODO change desc to when inputs are valid
//             "given create match inputs are valid"
//             "when tap on submit button"
//             "then should should show a [TabToggler] with expected arguments",
//             (tester) async {
//               // setup
//               _stubCreateMatchControllerDependencies(
//                 createMatchUseCase: createMatchUseCase,
//                 getAuthDataStatusUseCase: getAuthDataStatusUseCase,
//                 createMatchCallback: () async {
//                   await Future.delayed(Duration.zero);
//                   return 1;
//                 },
//                 getAuthDataStatusCallback: () async =>
//                     getTestAuthDataModels(count: 1).first,
//               );

//               final inputsController = _MockCreateMatchInputsController();
//               _stubCreateMatchInputsController(
//                 inputsController,
//                 onGetValidatedNameStream: const Stream<String>.empty(),
//                 onGetValidatedLocationStream: const Stream<String>.empty(),
//                 onGetValidatedDescriptionStream: const Stream<String>.empty(),
//                 onGetValidatedDateTimeStream: const Stream<DateTime>.empty(),
//                 onGetAreInputsValidStream: Stream<bool>.value(true),
//                 // given
//                 onGetValidatedMatchCreateInputArgs: MatchCreateInputArgs(
//                   name: "name",
//                   location: "location",
//                   description: "description",
//                   playersForInvite: const [],
//                   dateTime: DateTime.now()
//                       .add(const Duration(days: 1))
//                       .millisecondsSinceEpoch,
//                 ),
//               );

//               final localOverrides = [
//                 ...overrides,
//                 createMatchInputsControllerProvider
//                     .overrideWith((ref) => inputsController),
//               ];

//               await tester.pumpWithProviderScope(
//                 overrides: localOverrides,
//                 widget: const MaterialApp(
//                   home: Scaffold(
//                     body: MatchCreateScreenView(),
//                   ),
//                 ),
//               );
//               // TODO wait until first stream for is validated is emitted
//               await tester.pump();

//               // when
//               final submitButtonFinder = find.byIcon(Icons.save);
//               await tester.tap(submitButtonFinder);

//               await tester.pump();

//               // then
//               final tabTogglerFinder = _findTabToggler(
//                 propertyChecker: ({
//                   required MatchCreateInfoContainer infoContainer,
//                   required MatchCreateParticipantsContainer
//                       participantsContainer,
//                 }) {
//                   if (!infoContainer.isLoading) return false;
//                   if (!participantsContainer.isLoading) return false;

//                   return true;
//                 },
//               );

//               expect(tabTogglerFinder, findsOneWidget);

//               // cleanup
//               await tester.pumpAndSettle();
//             },
//           );

//           // TODO use MatchScreenViewTest as a reference
//           // testWidgets(
//           //   "given nothing in particular"
//           //   "when widget is rendered"
//           //   "should show a [TabToggler] with expected arguments",
//           //   (widgetTester) async {
//           //     await widgetTester.pumpWidget(
//           //       const MaterialApp(
//           //         home: Scaffold(
//           //           // TODO match view will need some arguments eventually
//           //           body: MatchCreateScreenView(),
//           //         ),
//           //       ),
//           //     );

//           //     final tabTogglerFinder = find.byWidgetPredicate((widget) {
//           //       if (widget is! TabToggler) return false;
//           //       if (widget.options.length != 2) return false;

//           //       final option1 = widget.options[0];
//           //       final option2 = widget.options[1];

//           //       final option1Title = option1.title;
//           //       final option2Title = option2.title;

//           //       if (option1Title != "Info") return false;
//           //       if (option2Title != "Participants") return false;

//           //       final option1Child = option1.child;
//           //       final option2Child = option2.child;

//           //       if (option1Child is! MatchCreateInfoContainer) return false;
//           //       if (option2Child is! MatchCreateParticipantsContainer) {
//           //         return false;
//           //       }

//           //       // TODO will need chec more arguments here

//           //       return true;
//           //     });

//           //     expect(tabTogglerFinder, findsOneWidget);
//           //   },
//           // );
//         },
//       );
//     },
//   );
// }

// class _FakeMatchCreateDataValue extends Fake implements MatchCreateDataValue {}

// class _MockCreateMatchUseCase extends Mock implements CreateMatchUseCase {}

// class _MockCreateMatchController extends Mock
//     implements CreateMatchController {}

// class _MockCreateMatchInputsController extends Mock
//     implements CreateMatchInputsController {}

// class _MockGetAuthDataStatusUseCase extends Mock
//     implements GetAuthDataStatusUseCase {}

// void _stubCreateMatchControllerDependencies({
//   required CreateMatchUseCase createMatchUseCase,
//   required GetAuthDataStatusUseCase getAuthDataStatusUseCase,
//   required Future<int> Function() createMatchCallback,
//   required Future<AuthDataModel?> Function() getAuthDataStatusCallback,
// }) {
//   when(() => createMatchUseCase(matchData: any(named: "matchData")))
//       .thenAnswer((_) async => createMatchCallback());
//   when(() => getAuthDataStatusUseCase()).thenAnswer((_) async {
//     return getAuthDataStatusCallback();
//   });
// }

// Finder _findTabToggler({
//   bool Function({
//     required MatchCreateInfoContainer infoContainer,
//     required MatchCreateParticipantsContainer participantsContainer,
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

//     if (option1Child is! MatchCreateInfoContainer) return false;
//     if (option2Child is! MatchCreateParticipantsContainer) {
//       return false;
//     }

//     if (propertyChecker == null) return true;

//     final doChildrenPropertiesMatch = propertyChecker(
//       infoContainer: option1Child,
//       participantsContainer: option2Child,
//     );
//     return doChildrenPropertiesMatch;
//   });

//   return tabTogglerFinder;
// }

// void _stubCreateMatchInputsController(
//   CreateMatchInputsController inputsController, {
//   required Stream<String> onGetValidatedNameStream,
//   required Stream<String> onGetValidatedLocationStream,
//   required Stream<String> onGetValidatedDescriptionStream,
//   required Stream<DateTime> onGetValidatedDateTimeStream,
//   required Stream<bool> onGetAreInputsValidStream,
//   required MatchCreateInputArgs? onGetValidatedMatchCreateInputArgs,
// }) {
//   when(() => inputsController.dispose()).thenAnswer((_) async {});
//   when(() => inputsController.validatedNameStream).thenAnswer(
//     (_) => onGetValidatedNameStream,
//   );
//   when(() => inputsController.validatedLocationStream).thenAnswer(
//     (_) => onGetValidatedLocationStream,
//   );
//   when(() => inputsController.validatedDescriptionStream).thenAnswer(
//     (_) => onGetValidatedDescriptionStream,
//   );
//   when(() => inputsController.validatedDateTimeStream).thenAnswer(
//     (_) => onGetValidatedDateTimeStream,
//   );
//   when(() => inputsController.areInputsValidStream).thenAnswer(
//     (_) => onGetAreInputsValidStream,
//   );
//   when(() => inputsController.validatedMatchCreateInputArgs).thenAnswer(
//     (_) => onGetValidatedMatchCreateInputArgs,
//   );
// }


// TODO come back to this

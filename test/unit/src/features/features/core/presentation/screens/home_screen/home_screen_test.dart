// import 'package:five_on_4_mobile/src/features/core/presentation/screens/home_screen/home_screen.dart';
// import 'package:five_on_4_mobile/src/features/core/presentation/screens/home_screen/home_screen_view.dart';
// import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/get_my_today_matches/get_my_today_matches_use_case.dart';
// import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/get_my_today_matches/provider/get_my_today_matches_use_case_provider.dart';
// import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/load_my_matches/load_my_matches_use_case.dart';
// import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/load_my_matches/provider/load_my_matches_use_case_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:mocktail_image_network/mocktail_image_network.dart';

// import '../../../../../../../utils/extensions/widget_tester_extension.dart';

// void main() {
//   final getMyTodayMatchesUseCase = _MockGetMyTodayMatchesUseCase();
//   final loadMyMatchesUseCase = _MockLoadMyMatchesUseCase();

//   final riverpodOverrides = [
//     getMyTodayMatchesUseCaseProvider.overrideWith(
//       (ref) => getMyTodayMatchesUseCase,
//     ),
//     loadMyMatchesUseCaseProvider.overrideWith(
//       (ref) => loadMyMatchesUseCase,
//     ),
//   ];

//   setUpAll(() {
//     when(() => getMyTodayMatchesUseCase()).thenAnswer(
//       (_) async => [],
//     );
//     when(() => loadMyMatchesUseCase()).thenAnswer(
//       (_) async {},
//     );
//   });

//   tearDown(() {
//     reset(getMyTodayMatchesUseCase);
//     reset(loadMyMatchesUseCase);
//   });
//   group(
//     "HomeScreen",
//     () {
//       // TODO do somehow ordering and position possibly - dont force it though
//       group(
//         "Screen layout",
//         () {
//           testWidgets(
//             "given nothing in particular"
//             "when screen is rendered"
//             "should show all expected child widgets",
//             (widgetTester) async {
//               await mockNetworkImages(() async {
//                 await widgetTester.pumpWithProviderScope(
//                   overrides: riverpodOverrides,
//                   widget: const MaterialApp(
//                     home: HomeScreen(),
//                   ),
//                 );
//               });

//               final viewWidgetFinder = find.byWidgetPredicate((widget) {
//                 if (widget is! HomeScreenView) return false;

//                 return true;
//               });

//               expect(viewWidgetFinder, findsOneWidget);
//             },
//           );
//         },
//       );
//     },
//   );
// }

// class _MockGetMyTodayMatchesUseCase extends Mock
//     implements GetMyTodayMatchesUseCase {}

// class _MockLoadMyMatchesUseCase extends Mock implements LoadMyMatchesUseCase {}

// TODO come back to this

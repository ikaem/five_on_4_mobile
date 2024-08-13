// import 'package:five_on_4_mobile/src/features/core/presentation/widgets/home/home_events.dart';
// import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match_brief/match_brief_extended.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';

// import '../../../../../../../utils/data/test_models.dart';

// void main() {
//   group(
//     "HomeEvents",
//     () {
//       group(
//         "Layout",
//         () {
//           testWidgets(
//             "given matches argument is provided"
//             "when widget is rendered"
//             "should show expected number of match briefs",
//             (widgetTester) async {
//               final matches = getTestMatchesModels();

//               await widgetTester.pumpWidget(
//                 MaterialApp(
//                   home: HomeEvents(
//                     matches: matches,
//                   ),
//                 ),
//               );

//               // TODO this is also an option // this would get all widgets of type MatchBriefExtended
//               // final matchBriefs = find.byType(MatchBriefExtended);
//               // matchBriefs.evaluate();

//               final matchTop = widgetTester
//                   .widgetList<MatchBriefExtended>(
//                     find.byType(MatchBriefExtended),
//                   )
//                   .first;
//               expect(matchTop.title, matches.first.name);

//               await widgetTester.dragUntilVisible(
//                 find.text("test_name9"),
//                 find.byType(ListView),
//                 const Offset(0, -1000),
//               );

//               final matchBottom = widgetTester
//                   .widgetList<MatchBriefExtended>(
//                     find.byType(MatchBriefExtended),
//                   )
//                   .last;
//               expect(matchBottom.title, matches.last.name);
//             },
//           );
//         },
//       );
//     },
//   );
// }


// TODO come back to this

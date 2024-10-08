// import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match_brief/match_brief.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';

// void main() {
//   group("MatchBrief", () {
//     group(
//       "Layout",
//       () {
//         testWidgets(
//           "given date, day name, and time arguments are provided"
//           "when widget is rendered"
//           "should show expected date, day name, and time",
//           (widgetTester) async {
//             const date = "23 DEC";
//             const dayName = "WEDNESDAY";
//             const time = "19:00";

//             await widgetTester.pumpWidget(
//               const MaterialApp(
//                 home: MatchBrief(
//                   date: date,
//                   dayName: dayName,
//                   time: time,
//                   title: "testTitle",
//                   location: "testLocation",
//                 ),
//               ),
//             );

//             final dateText = find.text(date);
//             final dayNameText = find.text(dayName);
//             final timeText = find.text(time);

//             expect(dateText, findsOneWidget);
//             expect(dayNameText, findsOneWidget);
//             expect(timeText, findsOneWidget);
//           },
//         );

//         testWidgets(
//           "given title argument is provided"
//           "when widget is rendered"
//           "should show expected title",
//           (widgetTester) async {
//             const title = "testTitle";

//             await widgetTester.pumpWidget(
//               const MaterialApp(
//                 home: MatchBrief(
//                   date: "testDate",
//                   dayName: "testDayName",
//                   time: "testTime",
//                   title: title,
//                   location: "testLocation",
//                 ),
//               ),
//             );

//             final titleText = find.text(title);

//             expect(titleText, findsOneWidget);
//           },
//         );

//         testWidgets(
//           "given location argument is provided"
//           "when widget is rendered"
//           "should show expected location",
//           (widgetTester) async {
//             const location = "testLocation";

//             await widgetTester.pumpWidget(
//               const MaterialApp(
//                 home: MatchBrief(
//                   date: "testDate",
//                   dayName: "testDayName",
//                   time: "testTime",
//                   title: "testTitle",
//                   location: location,
//                 ),
//               ),
//             );

//             final organizerText = find.text(location);

//             expect(organizerText, findsOneWidget);
//           },
//         );
//       },
//     );
//   });
// }

// TODO this does not belong here - it should be in widget tesrts - but maybe we can put it all here? probably not good to do that
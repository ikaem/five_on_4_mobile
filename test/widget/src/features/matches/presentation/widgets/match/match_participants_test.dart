// import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match/match_participants_list.dart';
// import 'package:five_on_4_mobile/src/features/players/models/player/player_model.dart';
// import 'package:five_on_4_mobile/src/features/players/presentation/widgets/player_brief/player_brief.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail_image_network/mocktail_image_network.dart';

// import '../../../../../../../utils/data/test_models.dart';

// TODO come back to this

// void main() {
//   group(
//     "MatchParticipants",
//     () {
//       group(
//         "Layout",
//         () {
//           testWidgets(
//             "given non-empty list of participants is provided"
//             "when widget is rendered"
//             "should show expected number of participant briefs",
//             (widgetTester) async {
//               final participants = getTestPlayersModels();

//               await mockNetworkImages(() async {
//                 await widgetTester.pumpWidget(
//                   MaterialApp(
//                     home: MatchParticipantsList(
//                       participants: participants,
//                     ),
//                   ),
//                 );
//               });

//               final participantTop = widgetTester
//                   .widgetList<PlayerBrief>(
//                     find.byType(
//                       PlayerBrief,
//                     ),
//                   )
//                   .first;
//               expect(participantTop.nickname, participants.first.nickname);

//               await widgetTester.dragUntilVisible(
//                 find.text("test_nickname9"),
//                 find.byType(ListView),
//                 const Offset(0, -1000),
//               );

//               // at this point, we can only see items at the bottom of the list
//               final participantBottom = widgetTester
//                   .widgetList<PlayerBrief>(
//                     find.byType(
//                       PlayerBrief,
//                     ),
//                   )
//                   .last;
//               expect(participantBottom.nickname, participants.last.nickname);
//             },
//           );
//         },
//       );
//     },
//   );
// }

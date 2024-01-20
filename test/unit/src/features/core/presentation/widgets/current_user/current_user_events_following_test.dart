import 'package:five_on_4_mobile/src/features/core/presentation/widgets/current_user/current_user_events_following.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/models/match/match_model.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match_brief.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    "CurrentUserAllEvents",
    () {
      testWidgets(
        "given empty list of matches are provided"
        "when widget is rendered"
        "should show expexted NO MATCHES text",
        (widgetTester) async {
          final matches = <MatchModel>[];

          await widgetTester.pumpWidget(
            MaterialApp(
              home: CurrentUserEventsFollowing(
                matches: matches,
              ),
            ),
          );

          final noMatchesText = find.text("No joined matches");
          final joineOneText = find.text("Why not join one?");

          expect(noMatchesText, equals(findsOneWidget));
          expect(joineOneText, equals(findsOneWidget));
        },
      );

      testWidgets(
        "given non-empty list of matches are provided"
        "when widget is rendered"
        "should show expexted number of match briefs",
        (widgetTester) async {
          final matches = List<MatchModel>.generate(10, (index) {
            return MatchModel(
              id: index,
              date: DateTime.now(),
              name: "testName$index",
              location: "testLocation$index",
              organizer: "testOrganizer$index",
              arrivingPlayers: index,
            );
          });

          await widgetTester.pumpWidget(
            MaterialApp(
              home: CurrentUserEventsFollowing(
                matches: matches,
              ),
            ),
          );

          final matchTop = widgetTester
              .widgetList<MatchBrief>(find.byType(
                MatchBrief,
              ))
              .toList()
              .first;
          expect(matchTop.title, equals(matches.first.name));

          await widgetTester.dragUntilVisible(
            find.text("testName9"),
            find.byType(ListView), // widget you want to scroll
            const Offset(0, -1000), // delta to move
          );

          final matchBottom = widgetTester
              .widgetList<MatchBrief>(find.byType(MatchBrief))
              .toList()
              .last;
          expect(matchBottom.title, equals(matches.last.name));
        },
      );
    },
  );
}

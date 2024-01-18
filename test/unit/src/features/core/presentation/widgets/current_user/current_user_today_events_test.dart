import 'package:five_on_4_mobile/src/features/core/presentation/widgets/current_user/current_user_today_events.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/models/match/match_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    "CurrentUserTodayEvents",
    () {
      testWidgets(
        "given empty list of todays matches are provided"
        "when widget is rendered"
        "should show expexted NO MATCHES text",
        (widgetTester) async {
          final todaysMatches = <MatchModel>[];

          await widgetTester.pumpWidget(
            MaterialApp(
              home: CurrentUserTodayEvents(
                todaysMatches: todaysMatches,
              ),
            ),
          );

          // find texts with messages for no match

          final noMatchesText = find.text("No matches today");
          final restTodayText = find.text("Have a rest, you deserve it!");

          expect(noMatchesText, findsOneWidget);
          expect(restTodayText, findsOneWidget);
        },
      );
    },
  );
}

import 'package:five_on_4_mobile/src/features/matches/presentation/screens/match_screen/match_screen.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/screens/match_screen/match_screen_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    "MatchScreen",
    () {
      group(
        "Layout",
        () {
          testWidgets(
            "given nothing in particular"
            "when screen is rendered"
            "should show [MatchView] with expected arguments passed to it",
            (widgetTester) async {
              await widgetTester.pumpWidget(
                const MaterialApp(
                  home: MatchScreen(matchId: 1),
                ),
              );

              // TODO come back to this - will need to override controller to provide match
              final matchViewFinder = find.byType(MatchScreenView);

              expect(matchViewFinder, findsOneWidget);
            },
          );
        },
      );
    },
  );
}

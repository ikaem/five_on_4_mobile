import 'package:five_on_4_mobile/src/features/matches/presentation/screens/match_create_screen/match_create_screen.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/screens/match_create_screen/match_create_screen_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    "MatchCreateScreen",
    () {
      group(
        "Layout",
        () {
          testWidgets(
            "given nothing in particular"
            "when screen is rendered"
            "should show [MatchCreateView] with expected arguments passed to it",
            (widgetTester) async {
              await widgetTester.pumpWidget(
                const MaterialApp(
                  home: MatchCreateScreen(),
                ),
              );

              // TODO come back to this - will need to override controller to provide create match data
              final matchCreateViewFinder = find.byType(MatchCreateScreenView);

              expect(matchCreateViewFinder, findsOneWidget);
            },
          );
        },
      );
    },
  );
}

import 'package:five_on_4_mobile/src/features/matches/presentation/screens/match_screen.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match/match_tab_option_toggler.dart';
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
            "should show [MatchTabOptionToggler] with expected arguments pass to it",
            (widgetTester) async {
              await widgetTester.pumpWidget(
                const MaterialApp(
                  home: MatchScreen(),
                ),
              );

              // TODO come back to this - will need to override controller to provide match
              final matchTabOptionTogglerWidget =
                  find.byType(MatchTabOptionToggler);

              expect(matchTabOptionTogglerWidget, findsOneWidget);
            },
          );
        },
      );
    },
  );
}

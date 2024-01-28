import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match_create/match_create_info_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    "MatchCreateInfoData",
    () {
      group(
        "Layout",
        () {
          testWidgets(
            "given widget is rendered"
            "when no particular behavior happens"
            "should show 'MATCH NAME' TextField",
            (widgetTester) async {
              // write the test

              await widgetTester.pumpWidget(
                const MaterialApp(
                  home: Scaffold(
                    body: MatchCreateInfoData(),
                  ),
                ),
              );

              final matchNameTextFieldFinder = find.ancestor(
                of: find.text("MATCH NAME"),
                matching: find.byType(TextField),
              );

              expect(matchNameTextFieldFinder, findsOneWidget);
            },
          );
        },
      );
    },
  );
}

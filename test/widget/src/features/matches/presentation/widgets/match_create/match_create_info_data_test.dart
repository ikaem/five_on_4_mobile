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
            "given nothing in particular"
            "when widget is rendered"
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

          testWidgets(
            "given nothing in particular"
            "when widget is rendered"
            "should show expected 'MATCH DATE' TextField input",
            (widgetTester) async {
              // write the test
              // TODO should do interaction test to make sure that date picker is shown

              await widgetTester.pumpWidget(
                const MaterialApp(
                  home: Scaffold(
                    body: MatchCreateInfoData(),
                  ),
                ),
              );

              final matchDateTextFieldFinder = find.ancestor(
                of: find.text("MATCH DATE"),
                matching: find.byType(TextField),
              );

              expect(matchDateTextFieldFinder, findsOneWidget);
            },
          );

          testWidgets(
            "given nothing in particular"
            "when widget is rendered"
            "should show expected 'MATCH TIME' TextField input",
            (widgetTester) async {
              // write the test
              // TODO should do interaction test to make sure that time picker is shown

              await widgetTester.pumpWidget(
                const MaterialApp(
                  home: Scaffold(
                    body: MatchCreateInfoData(),
                  ),
                ),
              );

              final matchTimeTextFieldFinder = find.ancestor(
                of: find.text("MATCH TIME"),
                matching: find.byType(TextField),
              );

              expect(matchTimeTextFieldFinder, findsOneWidget);
            },
          );

          testWidgets(
            "given nothing in particular"
            "when widget is rendered"
            "should show expected 'MATCH DESCRIPTION' TextField input",
            (widgetTester) async {
              // write the test
              // TODO should do interaction test to make sure that time picker is shown

              await widgetTester.pumpWidget(
                const MaterialApp(
                  home: Scaffold(
                    body: MatchCreateInfoData(),
                  ),
                ),
              );

              final matchDescriptionTextFieldFinder = find.byWidgetPredicate(
                (widget) {
                  if (widget is! TextField) return false;
                  if (widget.decoration?.labelText != "MATCH DESCRIPTION") {
                    return false;
                  }
                  if (widget.minLines != 5) return false;
                  if (widget.maxLines != 5) return false;

                  return true;
                },
              );

              expect(matchDescriptionTextFieldFinder, findsOneWidget);

              // final matchTimeTextFieldFinder = find.ancestor(
              //   of: find.text("MATCH DESCRIPTION"),
              //   matching: find.byType(TextField),
              // );

              // TODO also possibly test that it is multiline
              // expect(matchTimeTextFieldFinder, findsOneWidget);
            },
          );
        },
      );
    },
  );
}

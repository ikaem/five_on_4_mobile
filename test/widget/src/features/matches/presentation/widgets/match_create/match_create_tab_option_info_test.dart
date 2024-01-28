import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match_create/match_create_info_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    "MatchCreateTabOptionInfo",
    () {
      group(
        "Layout",
        () {
          testWidgets(
            "given nothing in particular"
            "when widget is rendered"
            "should render expected widget",
            (widgetTester) async {
              await widgetTester.pumpWidget(
                MaterialApp(
                  home: MatchCreateTabOptionInfo(),
                ),
              );

              final matchCreateInfoDataFinder = find.byWidgetPredicate(
                (widget) {
                  if (widget is! MatchCreateInfoData) return false;
                  // TODO there will be more checks here when we pass arguments to widget

                  return true;
                },
              );

              expect(matchCreateInfoDataFinder, findsOneWidget);
            },
          );
        },
      );
    },
  );
}

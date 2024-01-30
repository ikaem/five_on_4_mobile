import 'package:five_on_4_mobile/src/features/core/presentation/widgets/tab_toggler/tab_toggler.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match_create/match_create_info_container.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match_create/match_create_participants_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    "MatchView",
    () {
      group(
        "Layout",
        () {
          testWidgets(
            "given nothing in particular"
            "when widget is rendered"
            "should show a [TabToggler] with expected arguments",
            (widgetTester) async {
              await widgetTester.pumpWidget(
                MaterialApp(
                  home: Scaffold(
                    // TODO match view will need some arguments eventually
                    body: MatchView(),
                  ),
                ),
              );

              final tabTogglerFinder = find.byWidgetPredicate((widget) {
                if (widget is! TabToggler) return false;
                if (widget.options.length != 2) return false;

                final option1 = widget.options[0];
                final option2 = widget.options[1];

                final option1Title = option1.title;
                final option2Title = option2.title;

                if (option1Title != "Info") return false;
                if (option2Title != "Participants") return false;

                final option1Child = option1.child;
                final option2Child = option2.child;

                if (option1Child is! MatchCreateInfoContainer) return false;
                if (option2Child is! MatchCreateParticipantsContainer) {
                  return false;
                }

                // TODO will need more arguments here

                return true;
              });

              expect(tabTogglerFinder, findsOneWidget);
            },
          );
        },
      );
    },
  );
}

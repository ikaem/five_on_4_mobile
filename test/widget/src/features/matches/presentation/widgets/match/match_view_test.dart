import 'package:five_on_4_mobile/src/features/core/presentation/widgets/tab_toggler/tab_toggler.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match/match_info_container.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match/match_participants_container.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match/match_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../../../utils/data/test_models.dart';

void main() {
  final testPlayers = getTestPlayers();
  final testMatch = getTestMatch(arrivingPlayers: testPlayers);

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
                    body: MatchView(match: testMatch),
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

                if (option1Child is! MatchInfoContainer) return false;
                if (option2Child is! MatchParticipantsContainer) return false;

                final option1ChildMatch = option1Child.match;
                final option2ChildParticipants = option2Child.participants;

                if (option1ChildMatch != testMatch) return false;
                if (option2ChildParticipants != testPlayers) return false;

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

import 'package:five_on_4_mobile/src/features/core/presentation/widgets/home/home_events_container.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/widgets/home/home_greeting.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/widgets/home/home_view.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/widgets/tab_toggler/tab_toggler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

import '../../../../../../../utils/data/test_models.dart';

void main() {
  group(
    "HomeView",
    () {
      group(
        "Layout",
        () {
          testWidgets(
            "given nothing in particular"
            "when widget is rendered"
            "should show [CurrentUserGreeting] with expected arguments passed to it",
            (widgetTester) async {
              await widgetTester.pumpWidget(
                const MaterialApp(
                  home: Scaffold(
                    body: HomeView(
                      matchesToday: [],
                      matchesFollowing: [],
                    ),
                  ),
                ),
              );

              final userGreetingFinder = find.byWidgetPredicate((widget) {
                if (widget is! HomeGreeting) return false;
                // TODO there will be more tests here

                return true;
              });

              expect(userGreetingFinder, findsOneWidget);
            },
          );

          testWidgets(
            "given nothing in particular"
            "when widget is rendered"
            "should show [TabToggler] widget with expected arguments passed to it",
            (widgetTester) async {
              final matchesToday =
                  getTestMatchesModels(count: 2, namesPrefix: "today_");
              final matchesFollowing =
                  getTestMatchesModels(count: 10, namesPrefix: "following_");

              await mockNetworkImages(() async {
                await widgetTester.pumpWidget(
                  MaterialApp(
                    home: Scaffold(
                      body: HomeView(
                        matchesToday: matchesToday,
                        matchesFollowing: matchesFollowing,
                      ),
                    ),
                  ),
                );
              });

              final userGreetingFinder = find.byWidgetPredicate((widget) {
                if (widget is! TabToggler) return false;
                if (widget.options.length != 2) return false;

                final option1 = widget.options[0];
                final option2 = widget.options[1];

                final option1Title = option1.title;
                final option2Title = option2.title;

                if (option1Title != "Today") return false;
                if (option2Title != "Following") return false;

                final option1Child = option1.child;
                final option2Child = option2.child;

                if (option1Child is! HomeEventsContainer) return false;
                if (option2Child is! HomeEventsContainer) return false;

                if (option1Child.isToday != true) return false;
                if (option2Child.isToday != false) return false;

                if (option1Child.matches != matchesToday) return false;
                if (option2Child.matches != matchesFollowing) return false;

                return true;
              });

              expect(userGreetingFinder, findsOneWidget);
            },
          );
        },
      );
    },
  );
}

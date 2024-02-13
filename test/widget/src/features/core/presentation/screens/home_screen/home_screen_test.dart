import 'package:five_on_4_mobile/src/features/core/presentation/screens/home_screen/home_screen.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/screens/home_screen/home_screen_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

void main() {
  group(
    "HomeScreen",
    () {
      // TODO do somehow ordering and position possibly - dont force it though
      group(
        "Screen layout",
        () {
          testWidgets(
            "given nothing in particular"
            "when screen is rendered"
            "should show all expected child widgets",
            (widgetTester) async {
              await mockNetworkImages(() async {
                await widgetTester.pumpWidget(
                  const MaterialApp(
                    home: HomeScreen(),
                  ),
                );
              });

              final viewWidgetFinder = find.byWidgetPredicate((widget) {
                if (widget is! HomeScreenView) return false;
                // TODO will need to test arguemtns to the widget

                return true;
              });

              expect(viewWidgetFinder, findsOneWidget);
            },
          );
        },
      );
    },
  );
}

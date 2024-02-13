import 'package:five_on_4_mobile/src/features/core/presentation/widgets/loading_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("LoadingStatus", () {
    group(
      "Layout",
      () {
        testWidgets(
          "given 'message' is passed "
          "when when the widget is rendered "
          "then should should show the message",
          (widgetTester) async {
            // given
            const message = "Loading...";
            const loadingStatus = LoadingStatus(message: message);

            // when
            await widgetTester
                .pumpWidget(const MaterialApp(home: loadingStatus));

            // then
            expect(find.text(message), findsOneWidget);
          },
        );

        testWidgets(
          "given a widget instance"
          "when when the widget is rendered "
          "then should show CircularProgressIndicator",
          (widgetTester) async {
            // given
            const loadingStatus = LoadingStatus(message: "Loading...");

            // when
            await widgetTester
                .pumpWidget(const MaterialApp(home: loadingStatus));

            // then
            expect(
              find.byType(
                CircularProgressIndicator,
              ),
              findsOneWidget,
            );
          },
        );

        testWidgets(
          "given 'isLinear' argument is set to true "
          "when when the widget is rendered "
          "then should show LinearProgressIndicator",
          (widgetTester) async {
            // given
            const loadingStatus = LoadingStatus(
              message: "Loading...",
              isLinear: true,
            );

            // when
            await widgetTester.pumpWidget(const MaterialApp(
              home: loadingStatus,
            ));

            // then
            expect(
              find.byType(
                LinearProgressIndicator,
              ),
              findsOneWidget,
            );
          },
        );
      },
    );
  });
}

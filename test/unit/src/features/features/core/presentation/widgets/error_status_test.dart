import 'package:five_on_4_mobile/src/features/core/presentation/widgets/error_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  group(
    "ErrorStatus",
    () {
      group(
        "Layout",
        () {
          testWidgets(
            "given 'message' is passed "
            "when when the widget is rendered "
            "then should should show the message",
            (widgetTester) async {
              // given
              const message = "There was an error";
              final errorStatus = ErrorStatus(
                message: message,
                onRetry: () async {},
              );

              // when
              await widgetTester.pumpWidget(MaterialApp(home: errorStatus));

              // then
              expect(find.text(message), findsOneWidget);
            },
          );

          testWidgets(
            "given a widget instance"
            "when when the widget is rendered "
            "then should show Error icon",
            (widgetTester) async {
              // given
              final loadingStatus = ErrorStatus(
                message: "There was an error",
                onRetry: () async {},
              );

              // when
              await widgetTester.pumpWidget(MaterialApp(home: loadingStatus));

              // then
              expect(
                find.byIcon(
                  Icons.error,
                ),
                findsOneWidget,
              );
            },
          );

          testWidgets(
            "given a widget instance"
            "when when the widget is rendered "
            "then should show Retry button",
            (widgetTester) async {
              // given
              final loadingStatus = ErrorStatus(
                message: "There was an error",
                onRetry: () async {},
              );

              // when
              await widgetTester.pumpWidget(MaterialApp(home: loadingStatus));

              final retryButton = find.ancestor(
                of: find.text("Retry"),
                matching: find.byType(TextButton),
              );

              // then
              expect(
                retryButton,
                findsOneWidget,
              );
            },
          );
        },
      );

      group(
        "Interaction",
        () {
          testWidgets(
            "given the widget is rendered "
            "when user taps on the retry button "
            "then should call the onRetry callback",
            (widgetTester) async {
              final onRetryWrapper = _MockOnRetryWrapper();
              when(() => onRetryWrapper.call()).thenAnswer((_) async {});

              // given
              final loadingStatus = ErrorStatus(
                message: "There was an error",
                onRetry: onRetryWrapper.call,
              );
              await widgetTester.pumpWidget(MaterialApp(home: loadingStatus));

              // when
              await widgetTester.tap(find.text("Retry"));

              // then
              verify(() => onRetryWrapper.call()).called(1);
            },
          );
        },
      );
    },
  );
}

class _MockOnRetryWrapper extends Mock {
  Future<void> call();
}

import 'package:five_on_4_mobile/src/features/core/presentation/widgets/error_status.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/widgets/home/home_events.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/widgets/home/home_events_container.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/widgets/loading_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../../../utils/data/test_models.dart';

void main() {
  group(
    "HomeEventsContainer",
    () {
      group(
        "Layout",
        () {
          testWidgets(
            "given 'isToday' is true and empty list of matches is provided "
            "when widget is rendered "
            "should show expected 'NO MATCHES TODAY' message",
            (widgetTester) async {
              const isToday = true;

              await widgetTester.pumpWidget(
                const MaterialApp(
                  home: Scaffold(
                    body: HomeEventsContainer(
                      isLoading: false,
                      isSyncing: false,
                      isError: false,
                      isToday: isToday,
                      matches: [],
                    ),
                  ),
                ),
              );

              final messageFinder = find.text("No matches today");
              final ctaFinder = find.text("Have a rest, you deserve it!");

              expect(messageFinder, findsOneWidget);
              expect(ctaFinder, findsOneWidget);
            },
          );

          testWidgets(
            "given 'isToday' is false and empty list of matches is provided "
            "when widget is rendered "
            "should show expected 'NO JOINED MATCHES' message",
            (widgetTester) async {
              const isToday = false;

              await widgetTester.pumpWidget(
                const MaterialApp(
                  home: Scaffold(
                    body: HomeEventsContainer(
                      isLoading: false,
                      isSyncing: false,
                      isError: false,
                      isToday: isToday,
                      matches: [],
                    ),
                  ),
                ),
              );

              final messageFinder = find.text("No joined matches");
              final ctaFinder = find.text("Why not join one?");

              expect(messageFinder, findsOneWidget);
              expect(ctaFinder, findsOneWidget);
            },
          );

          testWidgets(
            "given a non-empty list of matches is provided "
            "when widget is rendered "
            "should show [HomeEvents] widget with expected arguments passed to it",
            (widgetTester) async {
              final matches = getTestMatchesModels();

              await widgetTester.pumpWidget(
                MaterialApp(
                  home: Scaffold(
                    body: HomeEventsContainer(
                      isLoading: false,
                      isSyncing: false,
                      isError: false,
                      isToday: true, // irrelevant for this test,
                      matches: matches,
                    ),
                  ),
                ),
              );

              final homeEventsFinder = find.byWidgetPredicate((widget) {
                if (widget is! HomeEvents) return false;
                if (widget.matches != matches) return false;

                return true;
              });

              expect(homeEventsFinder, findsOneWidget);
            },
          );
          testWidgets(
            "given 'isLoading' argument is set to true "
            "when the widget is rendered "
            "then should show LoadingStatus widget with expected arguments",
            (widgetTester) async {
              final matches = getTestMatchesModels();

              await widgetTester.pumpWidget(
                MaterialApp(
                  home: Scaffold(
                    body: HomeEventsContainer(
                      isLoading: true,
                      isSyncing: false,
                      isError: false,
                      isToday: true, // irrelevant for this test,
                      matches: matches,
                    ),
                  ),
                ),
              );

              final circularLoadingStatus = find.byWidgetPredicate(
                (widget) {
                  if (widget is! LoadingStatus) return false;
                  if (widget.isLinear) return false;

                  return true;
                },
              );
              expect(circularLoadingStatus, findsOneWidget);
            },
          );

          testWidgets(
            "given 'isSyncing' argument is set to true "
            "when the widget is rendered "
            "then should show LoadingStatus widget with expected arguments",
            (widgetTester) async {
              final matches = getTestMatchesModels();

              await widgetTester.pumpWidget(
                MaterialApp(
                  home: Scaffold(
                    body: HomeEventsContainer(
                      isLoading: false,
                      isSyncing: true,
                      isError: false,
                      onRetry: () {},
                      isToday: true, // irrelevant for this test,
                      matches: matches,
                    ),
                  ),
                ),
              );

              final linearLoadingStatus = find.byWidgetPredicate(
                (widget) {
                  if (widget is! LoadingStatus) return false;
                  if (!widget.isLinear) return false;

                  return true;
                },
              );
              expect(linearLoadingStatus, findsOneWidget);
            },
          );

          testWidgets(
            "given 'isError' argument is set to true "
            "when the widget is rendered "
            "then should show ErrorStatus widget with expected arguments",
            (widgetTester) async {
              const isError = true;
              onRetryCallback() {}

              await widgetTester.pumpWidget(
                MaterialApp(
                  home: Scaffold(
                    body: HomeEventsContainer(
                      isLoading: false,
                      isSyncing: false,
                      isError: isError,
                      onRetry: onRetryCallback,
                      isToday: true, // irrelevant for this test,
                      matches: getTestMatchesModels(),
                    ),
                  ),
                ),
              );

              final errorStatus = find.byWidgetPredicate(
                (widget) {
                  if (widget is! ErrorStatus) return false;
                  if (widget.message !=
                      "There was an issue retrieving matches") {
                    return false;
                  }
                  if (widget.onRetry != onRetryCallback) return false;

                  return true;
                },
              );
            },
          );
        },
      );
    },
  );
}

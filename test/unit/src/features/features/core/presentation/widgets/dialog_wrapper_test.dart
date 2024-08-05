import 'package:five_on_4_mobile/src/features/core/presentation/widgets/dialog_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    "DialogWrapper",
    () {
      group(
        "Interaction",
        () {
          // should close dialog when tap on close button in the dialog
          // for this, we have to activate it with showDialog in text - will need builder or something to provide context
        },
      );
      group(
        "Layout",
        () {
          testWidgets(
            "given 'title' argument is provided"
            "when widget is rendered"
            "should show expected title",
            (widgetTester) async {
              const title = "Test Title";

              await widgetTester.pumpWidget(
                const MaterialApp(
                  home: DialogWrapper(
                    title: title,
                    child: SizedBox(),
                  ),
                ),
              );

              final titleFinder = find.text(title);

              expect(titleFinder, findsOneWidget);
            },
          );

          testWidgets(
            "given nothing in particular"
            "when widget is rendered"
            "should show 'close' IconButton",
            (widgetTester) async {
              await widgetTester.pumpWidget(
                const MaterialApp(
                  home: DialogWrapper(
                    title: "testTitle",
                    child: SizedBox(),
                  ),
                ),
              );

              final closeButtonFinder = find.ancestor(
                of: find.byIcon(Icons.close_rounded),
                matching: find.byType(IconButton),
              );

              expect(closeButtonFinder, findsOneWidget);
            },
          );

          testWidgets(
            "given 'child' argument is provided"
            "when widget is rendered"
            "should show expected child",
            (widgetTester) async {
              await widgetTester.pumpWidget(
                const MaterialApp(
                  home: DialogWrapper(
                    title: "testTitle",
                    child: _MyCustomWidget(),
                  ),
                ),
              );

              final childFinder = find.byType(_MyCustomWidget);

              expect(childFinder, findsOneWidget);
            },
          );
        },
      );
    },
  );
}

class _MyCustomWidget extends StatelessWidget {
  const _MyCustomWidget();

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

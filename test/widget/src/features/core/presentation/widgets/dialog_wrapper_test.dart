import 'package:five_on_4_mobile/src/features/core/presentation/widgets/dialog_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    "DialogWrapper",
    () {
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
        },
      );
    },
  );
}

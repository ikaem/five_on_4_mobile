import 'package:flutter_test/flutter_test.dart';

void main() {
  group("LoadingStatus", () {
    group(
      "Layout",
      () {
        testWidgets(
          "given 'message' is pased "
          "when when the widget is rendered "
          "then should should show the message",
          (widgetTester) async {
            // given
            const message = "Loading...";
            final loadingStatus = LoadingStatus(message: message);

            // when
            await widgetTester.pumpWidget(loadingStatus);

            // then
            expect(find.text(message), findsOneWidget);
          },
        );
      },
    );
  });
}

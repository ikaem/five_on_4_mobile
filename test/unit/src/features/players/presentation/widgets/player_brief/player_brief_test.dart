import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

void main() {
  group("PlayerBrief", () {
    group(
      "Layout",
      () {
        testWidgets(
          "given avatarUrl argument is provided"
          "when widget is rendered"
          "should show expected avatar image",
          (widgetTester) async {
            await mockNetworkImages(() async {
              await widgetTester.pumpWidget(
                MaterialApp(
                  home: PlayerBrief(
                    avatarUrl: Uri.parse(
                      "https://test.com/avatar.png",
                    ),
                  ),
                ),
              );
            });
          },
        );
      },
    );
  });
}

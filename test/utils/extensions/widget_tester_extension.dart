import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

extension WidgetTesterExtension on WidgetTester {
  Future<void> pumpConfiguredWidget({
    required Widget widget,
    required List<Override> riverpodOverrides,
  }) async {
    await pumpWidget(
      ProviderScope(
        overrides: riverpodOverrides,
        child: widget,
      ),
    );
  }

  Future<void> pumpWithProviderScope({
    required Widget widget,
    List<Override> overrides = const [],
  }) async {
    await pumpWidget(
      ProviderScope(
        overrides: overrides,
        child: widget,
      ),
    );
  }
}

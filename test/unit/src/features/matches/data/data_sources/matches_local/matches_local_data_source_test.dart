import 'package:five_on_4_mobile/src/wrappers/libraries/isar/isar_wrapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  final isarWrapper = _MockIsarWrapper();

  // final matchesLocalDataSource = MatchesLocalDataSourceImpl(
  //   isarWrapper: isarWrapper,
  // );

  // group(description, () { })
}

class _MockIsarWrapper extends Mock implements IsarWrapper {}

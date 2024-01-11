import 'package:five_on_4_mobile/src/features/auth/data/data_sources/auth_local/auth_local_data_source_impl.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/flutter_secure_storage/flutter_secure_storage_wrapper.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/isar/isar_wrapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  group("AuthLocalDataSource", () {
    group(".saveAuthData", () {
      test(
        "should store token and authId to secure storage WHEN called",
        () {
          // TODO this should be tore down in a setup method for each test
          final secureStorageWrapper = _MockFlutterSecureStorageWrapper();
          final isarWrapper = _MockIsarWrapper();

          // when(secureStorageWrapper.storeAuthData)

          final authLocalDataSource = AuthLocalDataSourceImpl(
            secureStorageWrapper: secureStorageWrapper,
            isarWrapper: isarWrapper,
          );
        },
      );

      test(
        "should store authData to isar WHEN called",
        () => null,
      );

      test(
        "should store same authId in secure storage and isar WHEN called",
        () => null,
      );
    });
  });
}

class _MockFlutterSecureStorageWrapper extends Mock
    implements FlutterSecureStorageWrapper {}

class _MockIsarWrapper extends Mock implements IsarWrapper {}

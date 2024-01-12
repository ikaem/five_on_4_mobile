import 'package:five_on_4_mobile/src/features/auth/data/data_sources/auth_local/auth_local_data_source_impl.dart';
import 'package:five_on_4_mobile/src/features/auth/data/entities/auth_data/auth_data_entity.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/flutter_secure_storage/flutter_secure_storage_wrapper.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/isar/isar_wrapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../../../utils/data/entities.dart';

// TODO move to helpers

void main() {
  group("AuthLocalDataSource", () {
    group(".setAuthData", () {
      test(
        "should set token and authId to secure storage WHEN called",
        () async {
          // TODO this should be tore down in a setup method for each test
          final secureStorageWrapper = _MockFlutterSecureStorageWrapper();
          final isarWrapper = _MockIsarWrapper();

          String? token;
          int? authId;

          AuthDataEntity? authDataEntity;

          when(
            () => secureStorageWrapper.storeAuthData(
              token: any(named: "token"),
              authId: any(named: "authId"),
            ),
          ).thenAnswer((invocation) async {
            // TODO make wrapper out of this
            final tokenArgument =
                invocation.namedArguments[const Symbol("token")];
            final authIdArgument =
                invocation.namedArguments[const Symbol("authId")];

            token = tokenArgument;
            authId = authIdArgument;
          });

          final authLocalDataSource = AuthLocalDataSourceImpl(
            secureStorageWrapper: secureStorageWrapper,
            isarWrapper: isarWrapper,
          );

          await authLocalDataSource.setAuthData(
            authDataEntity: testAuthDataEntity,
            authToken: "authToken",
          );

          expect(
            token,
            equals("authToken"),
          );
          expect(
            authId,
            equals(testAuthDataEntity.id),
          );
        },
      );

      test(
        // TODO this next
        "should store authData to isar WHEN called",
        () => null,
      );

      test(
        "should store same authId in secure storage and isar WHEN called",
        () => null,
      );

      // TODO continue this test
    });
  });
}

class _MockFlutterSecureStorageWrapper extends Mock
    implements FlutterSecureStorageWrapper {}

class _MockIsarWrapper extends Mock implements IsarWrapper {}

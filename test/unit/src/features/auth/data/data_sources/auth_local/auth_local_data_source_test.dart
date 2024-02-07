import 'package:five_on_4_mobile/src/features/auth/data/data_sources/auth_local/auth_local_data_source_impl.dart';
import 'package:five_on_4_mobile/src/features/auth/data/entities/auth_data/auth_data_entity.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/flutter_secure_storage/flutter_secure_storage_wrapper.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/isar/isar_wrapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../../../utils/data/test_entities.dart';
import '../../../../../../../utils/db/setup_db.dart';
import '../../../../../../../utils/secure_storage/setup_secure_storage.dart';

void main() {
  final isarWrapper = setupTestDb();
  final secureStorageWrapper = setupTestSecureStorage();
  // final secureStorageWrapper = _MockFlutterSecureStorageWrapper();

  final authLocalDataSource = AuthLocalDataSourceImpl(
    // secureStorageWrapper: secureStorageWrapper,
    secureStorageWrapper: secureStorageWrapper,
    isarWrapper: isarWrapper,
  );

  group("AuthLocalDataSource", () {
    group(
      ".getAuthData()",
      () {
        // TODO these tests fail - fix them
        // TODO this will pass when authlocaldata source logic is uncommented
        test(
          "given authId and authToken stored in secure storage AND matching authDataEntity exists in isar"
          "when '.getAuthData() is called"
          "should return expected [AuthDataEntity]",
          () async {
            final entity = AuthDataEntity(
              playerInfo: testAuthDataEntity.playerInfo,
              teamInfo: testAuthDataEntity.teamInfo,
            )..id = 1;

            await secureStorageWrapper.storeAuthData(
              token: "authToken",
              authId: 1,
            );

            await isarWrapper.db.writeTxn(() async {
              await isarWrapper.db.authDataEntitys.put(entity);
            });

            final authDataEntity = await authLocalDataSource.getAuthData();

            expect(authDataEntity, equals(entity));
          },
        );

        // tests when not all data is present, or when data is not present
        // test then data is delete from secure stroage if something is off
      },
    );

    group(".setAuthData()", () {
      final draftEntity = testAuthDataEntity;

      test(
        "given draft of [AuthDataEntity] and authToken"
        "when '.setAuthData()' is called"
        "should store the draft in isar",
        () async {
          await authLocalDataSource.setAuthData(
            authDataEntityDraft: draftEntity,
            authToken: "authToken",
          );

          final storedEntities =
              await isarWrapper.db.authDataEntitys.where().findAll();

          expect(storedEntities.length, equals(1));
          expect(storedEntities.first, equals(draftEntity));
        },
      );

      test(
        "given draft of [AuthDataEntity] and authToken"
        "when '.setAuthData()' is called"
        "should store the authToken and authId in secure storage",
        () async {
          await authLocalDataSource.setAuthData(
            authDataEntityDraft: draftEntity,
            authToken: "authToken",
          );

          verify(
            () => secureStorageWrapper.storeAuthData(
              token: "authToken",
              authId: 1,
            ),
          ).called(1);
        },
      );
    });
  });
}

class _MockFlutterSecureStorageWrapper extends Mock
    implements FlutterSecureStorageWrapper {}

class _MockIsarWrapper extends Mock implements IsarWrapper {}

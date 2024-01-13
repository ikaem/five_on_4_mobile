import 'package:five_on_4_mobile/src/features/auth/data/data_sources/auth_local/auth_local_data_source_impl.dart';
import 'package:five_on_4_mobile/src/features/auth/data/entities/auth_data/auth_data_entity.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/flutter_secure_storage/flutter_secure_storage_wrapper.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/isar/isar_wrapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../../../utils/data/entities.dart';

void main() {
  // reset and clear interactions docs - https://stackoverflow.com/a/77574465
  final secureStorageWrapper = _MockFlutterSecureStorageWrapper();
  final isarWrapper = _MockIsarWrapper();

  final authLocalDataSource = AuthLocalDataSourceImpl(
    secureStorageWrapper: secureStorageWrapper,
    isarWrapper: isarWrapper,
  );

  final draftEntity = testAuthDataEntity;

  setUpAll(
    () {
      registerFallbackValue(
        AuthDataEntity(
          playerInfo: AuthDataPlayerInfoEntity(),
          teamInfo: AuthDataTeamInfoEntity(),
        ),
      );
    },
  );

  setUp(() {
    when(
      () => isarWrapper.putEntity<AuthDataEntity>(
        entity: any(named: "entity"),
      ),
    ).thenAnswer((invocation) async {
      return 1;
    });

    when(
      () => secureStorageWrapper.storeAuthData(
        token: any(named: "token"),
        authId: any(named: "authId"),
      ),
    ).thenAnswer((invocation) async {
      return;
    });
  });

  tearDown(() {
    reset(secureStorageWrapper);
    reset(isarWrapper);
  });

  group("AuthLocalDataSource", () {
    group(
      ".getAuthData()",
      () {
        test(
          "given authId and authToken stored in secure storage AND matching authDataEntity exists in isar"
          "when '.getAuthData() is called"
          "should return expected [AuthDataEntity]",
          () async {
            final entity = AuthDataEntity(
                playerInfo: testAuthDataEntity.playerInfo,
                teamInfo: testAuthDataEntity.teamInfo)
              ..id = 1;

            when(
              () => secureStorageWrapper.getAuthData(),
            ).thenAnswer((invocation) async {
              return (
                "testToken",
                entity.id!,
              );
            });

            when(
              () => isarWrapper.findAllEntities<AuthDataEntity>(),
            ).thenAnswer((invocation) async {
              return [entity];
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
      test(
        "given draft of [AuthDataEntity] and authToken"
        "when '.setAuthData()' is called"
        "should store the draft in isar",
        () async {
          await authLocalDataSource.setAuthData(
            authDataEntityDraft: draftEntity,
            authToken: "authToken",
          );

          verify(() => isarWrapper.putEntity(entity: draftEntity)).called(1);
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

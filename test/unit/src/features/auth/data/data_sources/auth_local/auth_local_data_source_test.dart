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
  });

  group("AuthLocalDataSource", () {
    group(".setAuthData", () {
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
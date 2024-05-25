import 'package:five_on_4_mobile/src/features/auth/data/data_sources/auth_local/auth_local_data_source.dart';
import 'package:five_on_4_mobile/src/features/auth/data/data_sources/auth_status/auth_status_data_source.dart';
import 'package:five_on_4_mobile/src/features/auth/data/repositories/auth/auth_repository_impl.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/repository_interfaces/auth/auth_repository.dart';
import 'package:five_on_4_mobile/src/features/auth/utils/helpers/converters/auth_data_converter.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/flutter_secure_storage/flutter_secure_storage_wrapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../../utils/data/test_entities.dart';

void main() {
  final authStatusDataSource = _MockAuthStatusDataSource();
  final authLocalDataSource = _MockAuthLocalDataSource();
  final flutterSecureStorageWrapper = _MockFlutterSecureStorageWrapper();

  final authRepository = AuthRepositoryImpl(
    authLocalDataSource: authLocalDataSource,
    authStatusDataSource: authStatusDataSource,
    flutterSecureStorageWrapper: flutterSecureStorageWrapper,
  );

  tearDown(() {
    reset(authStatusDataSource);
    reset(authLocalDataSource);
    reset(flutterSecureStorageWrapper);
  });

  group(
    "$AuthRepository",
    () {
      group(
        ".authDataStatus",
        () {
          test(
            "given user is logged in"
            "when .authDataStatus is called"
            "then should return expected value",
            () {
              // final authDataEntity =
              final authDataEntity = getTestAuthDataEntities(count: 1).first;
              final authDataModel = AuthDataConverter.toModelFromEntity(
                entity: authDataEntity,
              );

              // Given
              when(() => authStatusDataSource.authDataStatus)
                  .thenReturn(authDataEntity);

              // When
              final result = authRepository.auth;

              // Then
              expect(result, authDataModel);
            },
          );

          test(
            "given user is NOT logged in"
            "when .authDataStatus is called"
            "then should return expected value",
            () {
              // Given
              when(() => authStatusDataSource.authDataStatus).thenReturn(null);

              // When
              final result = authRepository.auth;

              // Then
              expect(result, isNull);
            },
          );
        },
      );
    },
  );
}

class _MockAuthStatusDataSource extends Mock implements AuthStatusDataSource {}

class _MockAuthLocalDataSource extends Mock implements AuthLocalDataSource {}

class _MockFlutterSecureStorageWrapper extends Mock
    implements FlutterSecureStorageWrapper {}
// TODO we will need remote data source
// class _MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

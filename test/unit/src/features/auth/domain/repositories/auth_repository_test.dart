import 'dart:async';

import 'package:five_on_4_mobile/src/features/auth/data/data_sources/auth_local/auth_local_data_source.dart';
import 'package:five_on_4_mobile/src/features/auth/data/data_sources/auth_remote/auth_remote_data_source.dart';
import 'package:five_on_4_mobile/src/features/auth/data/data_sources/auth_status/auth_status_data_source.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/exceptions/auth_exceptions.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/repositories/auth/auth_repository_impl.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/repositories/auth/auth_repository.dart';
import 'package:five_on_4_mobile/src/features/auth/utils/converters/authenticated_player_converters.dart';
import 'package:five_on_4_mobile/src/features/auth/utils/helpers/converters/auth_data_converter.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/drift/app_database.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/flutter_secure_storage/flutter_secure_storage_wrapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../../utils/data/test_entities.dart';
import '../../../../../../utils/matchers/throws_exception_with_message.dart';

void main() {
  final authStatusDataSource = _MockAuthStatusDataSource();
  final authLocalDataSource = _MockAuthLocalDataSource();
  final flutterSecureStorageWrapper = _MockFlutterSecureStorageWrapper();
  final authRemoteDataSource = _MockAuthRemoteDataSource();

  final authRepository = AuthRepositoryImpl(
    authLocalDataSource: authLocalDataSource,
    authStatusDataSource: authStatusDataSource,
    flutterSecureStorageWrapper: flutterSecureStorageWrapper,
    authRemoteDataSource: authRemoteDataSource,
  );

  tearDown(() {
    reset(authStatusDataSource);
    reset(authLocalDataSource);
    reset(flutterSecureStorageWrapper);
    reset(authRemoteDataSource);
  });

  group(
    "$AuthRepository",
    () {
      group(".checkAuthenticatedPlayer", () {
        // should make call to remote data source to get player

        test(
          "given nothing in particular"
          "when .checkAuthenticatedPlayer() is called"
          "then should make a call to AuthRemoteDataSource to get authenticated player",
          () async {
            // setup

            // given
            // when(() => authRemoteDataSource.g)

            // when
            await authRepository.checkAuthenticatedPlayer();

            // then

            // cleanup
          },
        );

        test(
          "given there is no authenticated player"
          "when .checkAuthenticatedPlayer() is called"
          "then should pass null to local data source ",
          () async {
            // setup

            // given

            // when

            // then

            // cleanup
          },
        );

        test(
          "given there is an authenticated player"
          "when .checkAuthenticatedPlayer() is called"
          "then should pass the player to local data source",
          () async {
            // setup

            // given

            // when

            // then

            // cleanup
          },
        );

        // should pass this result to local data source to store player
      });

      // TODO also get authetnicated player

      group(".getAuthenticatedPlayerModelStream()", () {
        test(
          "given a stream of AuthenticatedPlayerModel"
          "when listening to the stream"
          "then should emit expected events",
          () async {
            // setup
            const entityData = AuthenticatedPlayerLocalEntityData(
              playerId: 1,
              playerName: "playerName",
              playerNickname: "playerNickname",
            );

            final streamController =
                StreamController<AuthenticatedPlayerLocalEntityData?>();

            when(() => authLocalDataSource
                .getAuthenticatedPlayerLocalEntityDataStream()).thenAnswer(
              (_) {
                return streamController.stream;
              },
            );

            // given
            final stream = authRepository.getAuthenticatedPlayerModelStream();

            // then
            final model =
                AuthenticatedPlayerConverters.toModelFromLocalEntityData(
              entity: entityData,
            );

            expectLater(
                stream,
                emitsInOrder([
                  null,
                  model,
                  emitsError(
                    isA<AuthMultipleLocalAuthenticatedPlayersException>()
                        .having(
                      (exception) {
                        return exception.message;
                      },
                      "message",
                      "Multiple local authenticated players found",
                    ),
                  )
                ]));

            // when
            streamController.add(null);
            streamController.add(entityData);
            streamController.addError(
              const AuthMultipleLocalAuthenticatedPlayersException(),
            );

            // cleanup
          },
        );
      });

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

class _MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

class _MockFlutterSecureStorageWrapper extends Mock
    implements FlutterSecureStorageWrapper {}
// TODO we will need remote data source
// class _MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

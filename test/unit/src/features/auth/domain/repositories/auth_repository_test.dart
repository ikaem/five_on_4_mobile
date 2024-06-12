import 'dart:async';

import 'package:five_on_4_mobile/src/features/auth/data/data_sources/auth_local/auth_local_data_source.dart';
import 'package:five_on_4_mobile/src/features/auth/data/data_sources/auth_remote/auth_remote_data_source.dart';
import 'package:five_on_4_mobile/src/features/auth/data/data_sources/auth_status/auth_status_data_source.dart';
import 'package:five_on_4_mobile/src/features/auth/data/entities/authenticated_player_remote/authenticated_player_remote_entity.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/exceptions/auth_exceptions.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/repositories/auth/auth_repository_impl.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/repositories/auth/auth_repository.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/values/anthenticated_player_local_entity_value.dart';
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

  setUpAll(() {
    registerFallbackValue(_FakeAuthenticatedPlayerLocalEntityValue());
  });

  tearDown(() {
    reset(authStatusDataSource);
    reset(authLocalDataSource);
    reset(flutterSecureStorageWrapper);
    reset(authRemoteDataSource);
  });

  group(
    "$AuthRepository",
    () {
      group(
        ".loadAuthenticatedPlayerFromRemote",
        () {
          // should load authenticated player from remote

          test(
            "given remote player is authenticated"
            "when call .loadAuthenticatedPlayerFromRemote()"
            "then should pass remote AuthenticatedPlayerEntity to local data source to store",
            () async {
              // setup
              const remoteEntity = AuthenticatedPlayerRemoteEntity(
                playerId: 1,
                playerName: "playerName",
                playerNickname: "playerNickname",
              );
              final localEntityValue = AuthenticatedPlayerLocalEntityValue(
                playerId: remoteEntity.playerId,
                playerName: remoteEntity.playerName,
                playerNickname: remoteEntity.playerNickname,
              );

              // given
              when(() => authRemoteDataSource.getAuth()).thenAnswer(
                (_) async {
                  return remoteEntity;
                },
              );
              when(() => authLocalDataSource.storeAuthenticatedPlayerEntity(
                    any(),
                  )).thenAnswer(
                (_) async {
                  return remoteEntity.playerId;
                },
              );

              // when
              await authRepository.loadAuthenticatedPlayerFromRemote();

              // then

              verify(() => authRemoteDataSource.getAuth()).called(1);
              verify(
                () => authLocalDataSource.storeAuthenticatedPlayerEntity(
                  localEntityValue,
                ),
              ).called(1);

              // cleanup
            },
          );

          test(
            "given remote player is NOT authenticated"
            "when call .loadAuthenticatedPlayerFromRemote()"
            "then should NOT call local data source to store",
            () async {
              // setup
              const remoteEntity = null;

              // given
              when(() => authRemoteDataSource.getAuth()).thenAnswer(
                (_) async {
                  return remoteEntity;
                },
              );

              // when
              await authRepository.loadAuthenticatedPlayerFromRemote();

              // then

              verify(() => authRemoteDataSource.getAuth()).called(1);
              verifyNever(
                () => authLocalDataSource.storeAuthenticatedPlayerEntity(
                  any(),
                ),
              );

              // cleanup
            },
          );
        },
      );

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
            final model =
                AuthenticatedPlayerConverters.toModelFromLocalEntityData(
              entity: entityData,
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

class _FakeAuthenticatedPlayerLocalEntityValue extends Fake
    implements AuthenticatedPlayerLocalEntityValue {}

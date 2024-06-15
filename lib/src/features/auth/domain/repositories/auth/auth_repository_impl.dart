import 'package:five_on_4_mobile/src/features/auth/data/data_sources/auth_local/auth_local_data_source.dart';
import 'package:five_on_4_mobile/src/features/auth/data/data_sources/auth_remote/auth_remote_data_source.dart';
import 'package:five_on_4_mobile/src/features/auth/data/data_sources/auth_status/auth_status_data_source.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/models/auth_data/auth_data_model.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/models/authenticated_player/authenticated_player_model.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/repositories/auth/auth_repository.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/values/anthenticated_player_local_entity_value.dart';
import 'package:five_on_4_mobile/src/features/auth/utils/converters/authenticated_player_converters.dart';
import 'package:five_on_4_mobile/src/features/auth/utils/helpers/converters/auth_data_converter.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/flutter_secure_storage/flutter_secure_storage_wrapper.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/flutter_secure_storage/provider/flutter_secure_storage_wrapper_provider.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl({
    required AuthLocalDataSource authLocalDataSource,
    // required AuthStatusDataSource authStatusDataSource,
    required AuthRemoteDataSource authRemoteDataSource,
    // required FlutterSecureStorageWrapper flutterSecureStorageWrapper,
  })  : _authLocalDataSource = authLocalDataSource,
        // _authStatusDataSource = authStatusDataSource,
        _authRemoteDataSource = authRemoteDataSource;
  // _flutterSecureStorageWrapper = flutterSecureStorageWrapper;

  final AuthLocalDataSource _authLocalDataSource;
  // final AuthStatusDataSource _authStatusDataSource;
  final AuthRemoteDataSource _authRemoteDataSource;
  // final FlutterSecureStorageWrapper _flutterSecureStorageWrapper;

  @override
  Future<void> checkAuth() async {
    // // 1. get auth id from secure storage
    // // /* TODO not that g */
    // final authId = await _flutterSecureStorageWrapper.getAuthId();
    // if (authId == null) {
    //   _authStatusDataSource.setAuthDataStatus(null);
    //   return;
    // }

    // // 2. get auth data from db
    // final authDataEntity = await _authLocalDataSource.getAuthEntity(authId);

    // // _authStatusDataSource.setAuthDataStatus(authDataEntity);
    // // TODO temp
    // _authStatusDataSource.setAuthDataStatus(null);
    // // 3. set auth data status
    // // final authDataEntity = await _authLocalDataSource.getAuthData();

    // // _authStatusDataSource.setAuthDataStatus(authDataEntity);
  }

// TODO rename this
  @override
  Stream<bool> get authStatusStream {
    throw UnimplementedError();
    //   return _authStatusDataSource.authDataStatusStream
    //       .distinct()
    //       .map((authData) {
    //     final isLoggedIn = authData != null;
    //     return isLoggedIn;
    //   });
    // }

    // @override
    // AuthDataModel? get auth {
    //   final authDataEntity = _authStatusDataSource.authDataStatus;
    //   if (authDataEntity == null) return null;

    //   final authDataModel =
    //       AuthDataConverter.toModelFromEntity(entity: authDataEntity);
    //   return authDataModel;
  }

  @override
  Future<void> loginWithGoogle() async {
    // TODO: implement loginWithGoogle
    throw UnimplementedError();
  }

  @override
  Stream<AuthenticatedPlayerModel?> getAuthenticatedPlayerModelStream() {
    final stream =
        _authLocalDataSource.getAuthenticatedPlayerLocalEntityDataStream();
    final modelStream = stream.map((event) {
      if (event == null) return null;

      final model = AuthenticatedPlayerConverters.toModelFromLocalEntityData(
          entity: event);
      return model;
    });

    return modelStream;
  }

  @override
  Future<void> checkAuthenticatedPlayer() async {
    // TODO: implement checkAuthenticatedPlayer
    throw UnimplementedError();
  }

  @override
  // TODO: implement auth
  AuthDataModel? get auth => throw UnimplementedError();

  @override
  Future<void> loadAuthenticatedPlayerFromRemote() async {
    final remoteEntity = await _authRemoteDataSource.getAuth();
    if (remoteEntity == null) return;

    final localEntityValue = AuthenticatedPlayerLocalEntityValue(
      playerId: remoteEntity.playerId,
      playerName: remoteEntity.playerName,
      playerNickname: remoteEntity.playerNickname,
    );

    await _authLocalDataSource.storeAuthenticatedPlayerEntity(localEntityValue);
  }

  @override
  Future<void> authenticateWithGoogle() async {
    final idToken = await _authRemoteDataSource.getGoogleSignInIdToken();

    final authenticatedPlayerEntity =
        await _authRemoteDataSource.authenticateWithGoogle(idToken);

    // TODO make converter for this
    final localEntityValue = AuthenticatedPlayerLocalEntityValue(
      playerId: authenticatedPlayerEntity.playerId,
      playerName: authenticatedPlayerEntity.playerName,
      playerNickname: authenticatedPlayerEntity.playerNickname,
    );
    await _authLocalDataSource.storeAuthenticatedPlayerEntity(localEntityValue);
  }
}

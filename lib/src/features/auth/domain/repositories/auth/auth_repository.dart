import 'package:five_on_4_mobile/src/features/auth/domain/models/auth_data/auth_data_model.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/models/authenticated_player/authenticated_player_model.dart';

abstract interface class AuthRepository {
  AuthDataModel? get auth;
  Future<void> checkAuth();
  Stream<bool> get authStatusStream;

  Future<void> loginWithGoogle();

  Stream<AuthenticatedPlayerModel?> getAuthenticatedPlayerModelStream();

  // this will check auth
  // TODO maybe not needed
  Future<void> checkAuthenticatedPlayer();

  Future<void> loadAuthenticatedPlayerFromRemote();
}

/* 
auth repo - login with google 
1. remote data source - verify google sign in
2. remote data source - authenticate with google

3. local data source - store auth entity to db and stored auth entity 
4. secure storage - store auth id
5. local auth status data source - set auth data 
6. return void


 */
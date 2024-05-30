import 'package:five_on_4_mobile/src/features/auth/data/entities/auth_remote/auth_remote_entity.dart';
import 'package:five_on_4_mobile/src/features/auth/data/entities/authenticated_player_remote/authenticated_player_remote_entity.dart';

abstract interface class AuthRemoteDataSource {
  Future<String> verifyGoogleSignIn();
  Future<AuthRemoteEntity> authenticateWithGoogle(String idToken);
  Future<AuthenticatedPlayerRemoteEntity> getAuth();
}

import 'package:five_on_4_mobile/src/features/auth/data/entities/auth_data/auth_data_entity.dart';

// TODO this will be removed
abstract interface class AuthStatusDataSource {
  Stream<AuthDataEntity?> get authDataStatusStream;
  AuthDataEntity? get authDataStatus;
  int? get playerId;

  void setAuthDataStatus(AuthDataEntity? authData);
  Future<void> dispose();
}

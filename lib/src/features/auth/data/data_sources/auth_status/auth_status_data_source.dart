import 'package:five_on_4_mobile/src/features/auth/data/entities/auth_data/auth_data_entity.dart';

abstract interface class AuthStatusDataSource {
  Stream<AuthDataEntity?> get authDataStatusStream;
  AuthDataEntity? get authDataStatus;

  void setAuthDataStatus(AuthDataEntity? authData);
  Future<void> dispose();
}

import 'package:five_on_4_mobile/src/features/auth/data/entities/auth_local/auth_local_entity.dart';

abstract interface class AuthLocalDataSource {
  // Future<AuthDataEntity?> getLoggedInAuthLocalEntity();
  // Future<void> storeAuthData({
  //   // TODO this type needs rename
  //   required AuthDataEntity authLocalEntityDraft,
  // });

  Future<AuthLocalEntity?> getAuthEntity(int authId);
  Future<int> storeAuthEntity(AuthLocalEntity authLocalEntity);
}

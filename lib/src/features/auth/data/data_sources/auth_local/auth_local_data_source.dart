import 'package:five_on_4_mobile/src/features/auth/data/entities/auth_data/auth_data_entity.dart';

abstract interface class AuthLocalDataSource {
  Future<AuthDataEntity?> getAuthData();
  Future<void> setAuthData({
    required AuthDataEntity authDataEntityDraft,
    required String authToken,
  });
}

import 'package:five_on_4_mobile/src/features/auth/domain/models/auth_data/auth_data_model.dart';

abstract interface class AuthRepository {
  Future<void> checkAuthDataStatus();
  Stream<bool> get authDataStatusStream;
}

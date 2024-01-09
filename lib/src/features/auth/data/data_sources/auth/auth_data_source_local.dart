import 'package:five_on_4_mobile/src/features/auth/data/entities/auth_data/auth_data_entity.dart';

abstract interface class AuthDataSourceLocal {
  Future<AuthDataEntity?> getAuthData();
}

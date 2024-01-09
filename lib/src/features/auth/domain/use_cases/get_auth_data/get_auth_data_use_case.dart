// TODO should unify all use cases to have smae interface and same params and implement same interface

import 'package:five_on_4_mobile/src/features/auth/domain/models/auth_data/auth_data_model.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/repository_interfaces/auth/auth_repository.dart';

class GetAuthDataUseCase {
  const GetAuthDataUseCase({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  final AuthRepository _authRepository;

  Future<AuthDataModel?> call() {
    return _authRepository.getAuthData();
  }
}

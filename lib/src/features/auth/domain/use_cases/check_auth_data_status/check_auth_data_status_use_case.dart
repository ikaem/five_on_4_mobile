// TODO should unify all use cases to have smae interface and same params and implement same interface

import 'package:five_on_4_mobile/src/features/auth/domain/models/auth_data/auth_data_model.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/repository_interfaces/auth/auth_repository.dart';

// TODO might not be needed because subscriuption will do this

class CheckAuthDataStatusUseCase {
  const CheckAuthDataStatusUseCase({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  final AuthRepository _authRepository;

  Future<void> call() {
    return _authRepository.checkAuthDataStatus();
  }
}

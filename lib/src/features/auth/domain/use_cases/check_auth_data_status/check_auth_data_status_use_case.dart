// TODO should unify all use cases to have smae interface and same params and implement same interface

import 'package:five_on_4_mobile/src/features/auth/domain/models/auth_data/auth_data_model.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/repositories/auth/auth_repository.dart';

// TODO might not be needed because subscriuption will do this

class CheckAuthDataStatusUseCase {
  const CheckAuthDataStatusUseCase({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  final AuthRepository _authRepository;

  Future<void> call() async {
    // return _authRepository.checkAuthDataStatus();
  }
}

import 'package:five_on_4_mobile/src/features/auth/domain/use_cases/check_auth_data_status/provider/check_auth_data_status_use_case_provider.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/use_cases/get_auth_data_status_stream/provider/get_auth_data_status_stream_use_case_provider.dart';
import 'package:five_on_4_mobile/src/features/auth/presentation/controllers/auth_status/auth_status_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "auth_status_controller_provider.g.dart";

@Riverpod(keepAlive: true)
AuthStatusController authStatusController(AuthStatusControllerRef ref) {
  final checkAuthDataStatusUseCase =
      ref.read(checkAuthDataStatusUseCaseProvider);
  final getAuthDataStatusStreamUseCase =
      ref.read(getAuthDataStatusStreamUseCaseProvider);

  return AuthStatusController(
    checkAuthDataStatusUseCase: checkAuthDataStatusUseCase,
    getAuthDataStatusStreamUseCase: getAuthDataStatusStreamUseCase,
  );
}

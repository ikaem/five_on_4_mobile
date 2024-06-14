import 'package:five_on_4_mobile/src/features/auth/domain/use_cases/check_auth_data_status/check_auth_data_status_use_case.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/use_cases/check_auth_data_status/provider/check_auth_data_status_use_case_provider.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/use_cases/get_auth_data_status_stream/get_auth_data_status_stream_use_case.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/use_cases/get_auth_data_status_stream/provider/get_auth_data_status_stream_use_case_provider.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/use_cases/get_authenticated_player_model_stream/get_authenticated_player_model_stream_use_case.dart';
import 'package:five_on_4_mobile/src/features/auth/presentation/controllers/auth_status/auth_status_controller.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/get_it/get_it_wrapper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "auth_status_controller_provider.g.dart";

@Riverpod(keepAlive: true)
AuthStatusController authStatusController(AuthStatusControllerRef ref) {
  // final checkAuthDataStatusUseCase =
  //     ref.read(checkAuthDataStatusUseCaseProvider);
  // final getAuthDataStatusStreamUseCase =
  //     ref.read(getAuthDataStatusStreamUseCaseProvider);

  // final checkAuthDataStatusUseCase = GetItWrapper.get<CheckAuthDataStatusUseCase>();
  // final getAuthDataStatusStreamUseCase = GetItWrapper.get<GetAuthDataStatusStreamUseCase>();
  // final getAuthenticatedPlayerModelStreamUseCase =
  //     GetItWrapper.get<GetAuthenticatedPlayerModelStreamUseCase>();

  return AuthStatusController();
}

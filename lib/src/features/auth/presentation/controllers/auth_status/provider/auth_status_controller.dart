import 'dart:async';

import 'package:five_on_4_mobile/src/features/auth/domain/use_cases/check_auth_data_status/check_auth_data_status_use_case.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/use_cases/check_auth_data_status/provider/check_auth_data_status_use_case_provider.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/use_cases/get_auth_data_status_stream/get_auth_data_status_stream_use_case.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/use_cases/get_auth_data_status_stream/provider/get_auth_data_status_stream_use_case_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "auth_status_controller.g.dart";

// TODO should have common interface for controllers

// TODO not sure if need to specify - this will always be used
@Riverpod(keepAlive: true)
class AuthStatusController extends _$AuthStatusController {
  late final _checkAuthDataStatusUseCase =
      ref.read(checkAuthDataStatusUseCaseProvider);
  late final _getAuthDataStatusStreamUseCase =
      ref.read(getAuthDataStatusStreamUseCaseProvider);

  late final StreamSubscription<bool> _authDataStatusSubscription;

  Future<void> dispose() async {
    ref.onDispose(() {
      _authDataStatusSubscription.cancel();
    });
  }

  @override
  AsyncValue<bool?> build() {
    // TODO not sure if it would be better if this returns async value - probably, so then we can use then on it?
    _initialize();
    return const AsyncValue.data(null);
  }

  Future<void> _initialize() async {
    state = const AsyncValue.loading();

    try {
      await _checkAuthDataStatusUseCase();
    } catch (e) {
      _handleError(e);
    }

    _authDataStatusSubscription = _getAuthDataStatusStreamUseCase().listen(
      (event) {
        state = AsyncValue.data(event);
      },
      onError: _handleError,
    );
  }

  void _handleError(dynamic e) {
    state = AsyncValue.error(e, StackTrace.current);
  }
}

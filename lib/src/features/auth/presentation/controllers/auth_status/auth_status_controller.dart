import 'dart:async';

import 'package:five_on_4_mobile/src/features/auth/domain/use_cases/check_auth_data_status/check_auth_data_status_use_case.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/use_cases/get_auth_data_status_stream/get_auth_data_status_stream_use_case.dart';
import 'package:flutter/material.dart';

class AuthStatusController extends ChangeNotifier {
  AuthStatusController({
    required CheckAuthDataStatusUseCase checkAuthDataStatusUseCase,
    required GetAuthDataStatusStreamUseCase getAuthDataStatusStreamUseCase,
  })  : _checkAuthDataStatusUseCase = checkAuthDataStatusUseCase,
        _getAuthDataStatusStreamUseCase = getAuthDataStatusStreamUseCase {
    _initialize();
  }

  final CheckAuthDataStatusUseCase _checkAuthDataStatusUseCase;
  final GetAuthDataStatusStreamUseCase _getAuthDataStatusStreamUseCase;

  late final StreamSubscription<bool> _authDataStatusSubscription;

  bool _isLoggedIn = false;
  bool _isError = false;
  bool _isLoading = true;

  // TODO maybe it would be good to expose user basic data to the UI - hold it here possibly - or maybe not needed

  bool get isLoggedIn => _isLoggedIn;
  bool get isError => _isError;
  bool get isLoading => _isLoading;

  Future<void> _initialize() async {
    // _isLoggedIn = true;
    // _isError = false;
    // _isLoading = true;
    // notifyListeners();

    try {
      await _checkAuthDataStatusUseCase();
    } catch (e) {
      _handleError(e);
    }

    _authDataStatusSubscription = _getAuthDataStatusStreamUseCase().listen(
      (event) {
        final isLoggedIn = event;
        _isLoggedIn = isLoggedIn;
        _isLoading = false;
        _isError = false;
        notifyListeners();
      },
      onError: _handleError,
    );
  }

  // TODO how to imoplement .when() function?

  void _handleError(dynamic e) {
    _isError = true;
    _isLoading = false;
    notifyListeners();
  }

  @override
  Future<void> dispose() async {
    await _authDataStatusSubscription.cancel();
    super.dispose();
  }
}

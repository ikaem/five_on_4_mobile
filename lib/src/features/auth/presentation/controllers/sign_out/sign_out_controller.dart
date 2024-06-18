import 'dart:developer';

import 'package:five_on_4_mobile/src/features/auth/domain/use_cases/sign_out/sign_out_use_case.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/get_it/get_it_wrapper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "sign_out_controller.g.dart";

@riverpod
class SignOutController extends _$SignOutController {
  final signOutUseCase = GetItWrapper.get<SignOutUseCase>();

  // there is no state really, as far as data is concerned

  // we only have:
  // - loading
  // - error

  @override
  AsyncValue<bool> build() {
    _handleDispose();

    return const AsyncValue.data(false);
  }

  Future<void> onSignOut() async {
    try {
      state = const AsyncValue.loading();
      await signOutUseCase();
      state = const AsyncValue.data(true);
    } catch (e, s) {
      // TODO handle error
      log("There was an error when signing out -> error: $e, stack: $s");

      // state = AsyncValue.error(e, s);
      // TODO empty because i dont know how to get exact stack trace in tests - but maybe tests can be written differently
      state = AsyncValue.error(e, StackTrace.empty);
    }
  }

  Future<void> _handleDispose() async {
    ref.onDispose(() {
      // TODO probably no cleanup will be needed here
    });
  }
}

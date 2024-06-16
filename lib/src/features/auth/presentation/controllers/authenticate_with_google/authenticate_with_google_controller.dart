import 'package:five_on_4_mobile/src/features/auth/domain/use_cases/authenticate_with_google/authenticate_with_google_use_case.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/get_it/get_it_wrapper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "authenticate_with_google_controller.g.dart";

@riverpod
class AuthenticateWithGoogleController
    extends _$AuthenticateWithGoogleController {
  final authenticateWithGoogleUseCase =
      GetItWrapper.get<AuthenticateWithGoogleUseCase>();

  // there is no state really, as far as data is concerned

  // we only have:
  // - loading
  // - error

  @override
  AsyncValue<bool> build() {
    _handleDispose();

    return const AsyncValue.data(false);
  }

  Future<void> onAuthenticate() async {
    try {
      state = const AsyncValue.loading();
      await authenticateWithGoogleUseCase();
      state = const AsyncValue.data(true);
    } catch (e, s) {
      // TODO handle error

      // state = AsyncValue.error(e, s);
      // TODO empty because i dont know how
      state = AsyncValue.error(e, StackTrace.empty);
    }
  }

  Future<void> _handleDispose() async {
    ref.onDispose(() {
      // TODO probably no cleanup will be needed here
    });
  }
}

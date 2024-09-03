import 'package:five_on_4_mobile/src/features/auth/domain/use_cases/get_authenticated_player_model/get_authenticated_player_model_use_case.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/use_cases/sign_out/sign_out_use_case.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  final getAuthenticatedPlayerModelUseCase =
      _MockGetAuthenticatedPlayerModelUseCase();
  final signOutUseCase = _MockSignOutUseCase();

// tested class
}

class _MockGetAuthenticatedPlayerModelUseCase extends Mock
    implements GetAuthenticatedPlayerModelUseCase {}

class _MockSignOutUseCase extends Mock implements SignOutUseCase {}

class _MockListener<T> extends Mock {
  // NOTE seems no need to stub this
  void call(T? prev, T next);
}

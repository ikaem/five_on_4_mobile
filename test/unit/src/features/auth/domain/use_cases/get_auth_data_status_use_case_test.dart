import 'package:five_on_4_mobile/src/features/auth/domain/repository_interfaces/auth/auth_repository.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/use_cases/get_auth_data_status/get_auth_data_status_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../../utils/data/test_models.dart';

void main() {
  final authRepository = _MockAuthRepository();

  final getAuthDataStatusUseCase = GetAuthDataStatusUseCase(
    authRepository: authRepository,
  );

  tearDown(() {
    reset(authRepository);
  });

  group(
    "$GetAuthDataStatusUseCase",
    () {
      // should return expected value
      group(".call()", () {
        test(
          "given nothing in particular "
          "when call() is called"
          "then should return expected value",
          () async {
            // setup
            final authDataModel = getTestAuthDataModels(count: 1).first;
            when(() => authRepository.auth).thenReturn(authDataModel);

            // Given

            // When
            final result = await getAuthDataStatusUseCase();

            // Then
            expect(result, authDataModel);
          },
        );
      });

      // should call auth repository
    },
  );
}

class _MockAuthRepository extends Mock implements AuthRepository {}

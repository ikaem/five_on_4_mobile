import 'package:five_on_4_mobile/src/features/auth/domain/repository_interfaces/auth/auth_repository.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/repository_interfaces/matches_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  final matchesRepository = _MockMatchesRepository();
  final authRepository = _MockAuthRepository();

  tearDown(() {
    reset(matchesRepository);
    reset(authRepository);
  });

//   group(
//     "$CreateMatchUseCase",
//     () {
//       group(
//         ".call()",
//         () {
// // should return expected value

//           test(
//             "given <pre-condition to the test>"
//             "when <behavior we are specifying>"
//             "then should <state we expect to happen>",
//             () {
//               // write the test
//             },
//           );

// // should call matches repository with expected values

// // should call auth repository
//         },
//       );
//     },
//   );
}

class _MockMatchesRepository extends Mock implements MatchesRepository {}

class _MockAuthRepository extends Mock implements AuthRepository {}

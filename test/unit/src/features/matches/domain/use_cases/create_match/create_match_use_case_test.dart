import 'package:five_on_4_mobile/src/features/auth/domain/repository_interfaces/auth/auth_repository.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/repository_interfaces/matches_repository.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  final matchesRepository = _MockMatchesRepository();
  final authRepository = _MockAuthRepository();
}

class _MockMatchesRepository extends Mock implements MatchesRepository {}

class _MockAuthRepository extends Mock implements AuthRepository {}

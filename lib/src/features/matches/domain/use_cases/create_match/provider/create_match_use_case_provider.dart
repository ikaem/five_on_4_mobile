import 'package:five_on_4_mobile/src/features/matches/data/repositories/matches/provider/matches_repository_provider.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/create_match/create_match_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "create_match_use_case_provider.g.dart";

@riverpod
CreateMatchUseCase createMatchUseCase(
  CreateMatchUseCaseRef ref,
) {
  final repository = ref.read(matchesRepositoryProvider);

  final useCase = CreateMatchUseCase(
    matchesRepository: repository,
  );

  return useCase;
}

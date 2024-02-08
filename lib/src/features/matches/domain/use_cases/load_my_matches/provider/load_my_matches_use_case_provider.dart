import 'package:five_on_4_mobile/src/features/matches/data/repositories/matches/provider/matches_repository_provider.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/load_my_matches/load_my_matches_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "load_my_matches_use_case_provider.g.dart";

@riverpod
LoadMyMatchesUseCase loadMyMatchesUseCase(
  LoadMyMatchesUseCaseRef ref,
) {
  final repository = ref.read(matchesRepositoryProvider);

  final useCase = LoadMyMatchesUseCase(
    matchesRepository: repository,
  );

  return useCase;
}

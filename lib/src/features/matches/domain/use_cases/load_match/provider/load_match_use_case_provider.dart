import 'package:five_on_4_mobile/src/features/matches/data/repositories/matches/provider/matches_repository_provider.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/load_match/load_match_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "load_match_use_case_provider.g.dart";

@riverpod
LoadMatchUseCase loadMatchUseCase(
  LoadMatchUseCaseRef ref,
) {
  final repository = ref.read(matchesRepositoryProvider);

  final useCase = LoadMatchUseCase(
    matchesRepository: repository,
  );

  return useCase;
}

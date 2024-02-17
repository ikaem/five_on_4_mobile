import 'package:five_on_4_mobile/src/features/matches/data/repositories/matches/provider/matches_repository_provider.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/get_match/get_match_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "get_match_use_case_provider.g.dart";

@riverpod
GetMatchUseCase getMatchUseCase(
  GetMatchUseCaseRef ref,
) {
  final repository = ref.read(matchesRepositoryProvider);

  final useCase = GetMatchUseCase(
    matchesRepository: repository,
  );

  return useCase;
}

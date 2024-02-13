import 'package:five_on_4_mobile/src/features/matches/data/repositories/matches/provider/matches_repository_provider.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/get_my_today_matches/get_my_today_matches_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "get_my_today_matches_use_case_provider.g.dart";

@riverpod
GetMyTodayMatchesUseCase getMyTodayMatchesUseCase(
  GetMyTodayMatchesUseCaseRef ref,
) {
  final repository = ref.read(matchesRepositoryProvider);

  final useCase = GetMyTodayMatchesUseCase(
    matchesRepository: repository,
  );

  return useCase;
}

import 'package:five_on_4_mobile/src/features/matches/presentation/controllers/sarch_matches_inputs/search_matches_inputs_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "search_matches_inputs_controller_provider.g.dart";

@riverpod
SearchMatchesInputsController searchMatchesInputsController(
  SearchMatchesInputsControllerRef ref,
) {
  final controller = SearchMatchesInputsController();
  // TODO this is called only on creation of new
  // ref.onDispose(() async {
  //   await controller.dispose();
  // });

  return controller;
}

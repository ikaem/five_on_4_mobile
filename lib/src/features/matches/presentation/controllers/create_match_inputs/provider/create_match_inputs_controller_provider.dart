import 'package:five_on_4_mobile/src/features/matches/presentation/controllers/create_match_inputs/create_match_inputs_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "create_match_inputs_controller_provider.g.dart";

@riverpod
CreateMatchInputsController createMatchInputsController(
  CreateMatchInputsControllerRef ref,
) {
  final controller = CreateMatchInputsController();
  // TODO this is called only on creation of new
  // ref.onDispose(() async {
  //   await controller.dispose();
  // });

  return controller;
}

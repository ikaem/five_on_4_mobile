import 'package:five_on_4_mobile/src/features/players/presentation/controllers/search_players_input/search_players_input_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "search_players_inputs_controller_provider.g.dart";

@riverpod
SearchPlayersInputsController searchPlayersInputsController(
  SearchPlayersInputsControllerRef ref,
) {
  final controller = SearchPlayersInputsController();

// TODO cannot call this here because this ref.onDispose is caleld on each rebuild of widget
  // ref.onDispose(() async {
  //   // TODO this might be ok here - lets test it. if not, we can do it in the container where we get it
  //   await controller.dispose();
  // });
  // TODO this is called only on creation of new
  // ref.onDispose(() async {
  //   await controller.dispose();
  // });

  return controller;
}

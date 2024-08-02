import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchPlayersContainer extends ConsumerStatefulWidget {
  const SearchPlayersContainer({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SearchPlayersContainerState();
}

class _SearchPlayersContainerState
    extends ConsumerState<SearchPlayersContainer> {
// TODO this will instantiate its own controller - and later matches container should do the same

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

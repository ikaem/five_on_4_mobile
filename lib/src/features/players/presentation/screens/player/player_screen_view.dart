import 'package:five_on_4_mobile/src/features/core/presentation/widgets/tab_toggler/tab_toggler.dart';
import 'package:five_on_4_mobile/src/features/players/domain/models/player/player_model.dart';
import 'package:five_on_4_mobile/src/features/players/presentation/widgets/player/player_info_container.dart';
import 'package:five_on_4_mobile/src/style/utils/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlayerScreenView extends ConsumerWidget {
  const PlayerScreenView({
    super.key,
    required this.playerId,
  });

  final int playerId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final togglerOptions = _getToggleOptions();

    return Scaffold(
      backgroundColor: ColorConstants.BLUE_LIGHT,
      appBar: AppBar(
        backgroundColor: ColorConstants.BLUE_LIGHT,
      ),
      body: TabToggler(
        options: togglerOptions,
        backgroundColor: ColorConstants.WHITE,
      ),
    );
  }

  List<TabTogglerOptionValue> _getToggleOptions() {
    return [
      TabTogglerOptionValue(
        title: "PLAYER INFO",
        child: PlayerInfoContainer(
          isLoading: false,
          isError: false,
          player: _tempPlayer,
        ),
      ),
      TabTogglerOptionValue(
        title: "MATCHES",
        child: Container(),
      ),
    ];
  }
}

// TODO temp until fetch player is implemented
final _tempPlayer = PlayerModel(
  avatarUri:
      Uri.parse("https://images.unsplash.com/photo-1438761681033-6461ffad8d80"),
  name: "John Doe",
  nickname: "John",
  id: 1,
);

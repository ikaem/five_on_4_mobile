import 'package:five_on_4_mobile/src/features/core/presentation/widgets/right_side_rounded_avatar.dart';
import 'package:five_on_4_mobile/src/features/players/models/player/player_model.dart';
import 'package:five_on_4_mobile/src/style/utils/constants/color_constants.dart';
import 'package:five_on_4_mobile/src/style/utils/constants/spacing_constants.dart';
import 'package:five_on_4_mobile/src/style/utils/constants/text_size_constants.dart';
import 'package:flutter/material.dart';

typedef OnInvitationAction = void Function({
  required PlayerModel player,
});

class MatchPlayerInvitation extends StatelessWidget {
  const MatchPlayerInvitation({
    super.key,
    required this.player,
    required this.isAddedToMatchInvitations,
    required this.onInvitationAction,
  });

  final PlayerModel player;
  final bool isAddedToMatchInvitations;
  final OnInvitationAction onInvitationAction;

  @override
  Widget build(BuildContext context) {
    final invitationIcon = isAddedToMatchInvitations
        ? const Icon(
            Icons.remove,
            color: Colors.green,
          )
        : const Icon(
            Icons.add,
            color: Colors.blue,
          );

    return Row(
      children: [
        RightSideRoundedAvatar(
          // TODO create constants for sizes in general - like regular zise, small size, i dont know...
          width: 60,
          height: 50,
          avatarUri: player.avatarUri,
        ),
        const SizedBox(
          width: SpacingConstants.M,
        ),
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
                // border: Border
                border: Border(
              bottom: BorderSide(
                color: ColorConstants.GREY_DARK,
                width: 1,
              ),
            )),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      player.nickname,
                      style: const TextStyle(
                        fontSize: TextSizeConstants.LARGE,
                        color: ColorConstants.BLACK,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        onInvitationAction(
                          player: player,
                        );
                      },
                      icon: invitationIcon,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

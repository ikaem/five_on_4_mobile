import 'package:five_on_4_mobile/src/style/utils/constants/circular_radius_constants.dart';
import 'package:five_on_4_mobile/src/style/utils/constants/color_constants.dart';
import 'package:five_on_4_mobile/src/style/utils/constants/spacing_constants.dart';
import 'package:flutter/material.dart';

class PlayerBrief extends StatelessWidget {
  const PlayerBrief({
    super.key,
    required this.avatarUri,
    required this.nickname,
  });

  final Uri avatarUri;
  final String nickname;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _AvatarElement(avatarUri: avatarUri),
        // TODO crearte issue to install default font - one from figma
        const SizedBox(width: SpacingConstants.M),
        Expanded(
          child: Text(
            nickname,
          ),
        ),
        // todo THIS Should also include name in smaller font
      ],
    );
  }
}

class _AvatarElement extends StatelessWidget {
  const _AvatarElement({
    super.key,
    required this.avatarUri,
  });

  final Uri avatarUri;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 54,
      height: 30,
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
        color: ColorConstants.BLUE_DARK,
        borderRadius: BorderRadius.horizontal(
          right: CircularRadiusConstants.EXTRA_SMALL,
        ),
      ),
      child: Image.network(
        avatarUri.toString(),
        fit: BoxFit.cover,
      ),
    );
  }
}

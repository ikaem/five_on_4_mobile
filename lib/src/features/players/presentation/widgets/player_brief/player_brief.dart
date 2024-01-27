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
    return Container(
      child: Row(
        children: [
          Container(
            child: Image.network(
              avatarUri.toString(),
              width: 54,
              height: 30,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Text(
              nickname,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class PlayerBrief extends StatelessWidget {
  const PlayerBrief({
    super.key,
    required this.avatarUrl,
    required this.nickname,
  });

  final Uri avatarUrl;
  final String nickname;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            child: Image.network(
              avatarUrl.toString(),
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

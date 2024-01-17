import 'package:flutter/material.dart';

class CurrentUserGreeting extends StatelessWidget {
  const CurrentUserGreeting({
    super.key,
    required this.nickName,
    required this.teamName,
    required this.avatarUrl,
  });

  final String nickName;
  final String teamName;
  final Uri avatarUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(text: "Welcome, "),
                    TextSpan(
                      text: nickName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(text: "of team "),
                    TextSpan(
                      text: teamName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Container(
          child: Image.network(avatarUrl.toString()),
        )
      ],
    ));
  }
}

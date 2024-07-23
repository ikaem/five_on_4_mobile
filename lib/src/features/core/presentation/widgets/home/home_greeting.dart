import 'package:five_on_4_mobile/src/style/utils/constants/color_constants.dart';
import 'package:five_on_4_mobile/src/style/utils/constants/text_size_constants.dart';
import 'package:flutter/material.dart';

class HomeGreeting extends StatefulWidget {
  const HomeGreeting({
    super.key,
    required this.nickName,
    required this.teamName,
    required this.avatarUrl,
  });

  final String nickName;
  final String teamName;
  final Uri avatarUrl;

  @override
  State<HomeGreeting> createState() => _HomeGreetingState();
}

class _HomeGreetingState extends State<HomeGreeting> {
  bool isErrorLoadingAvatar = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                style: const TextStyle(
                  fontSize: TextSizeConstants.EXTRA_EXTRA_LARGE,
                ),
                TextSpan(
                  children: [
                    const TextSpan(
                      text: "Welcome, ",
                    ),
                    TextSpan(
                      text: widget.nickName,
                      style: const TextStyle(
                        // TODO use theme
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Text.rich(
                style: const TextStyle(
                  fontSize: TextSizeConstants.LARGE,
                ),
                TextSpan(
                  children: [
                    const TextSpan(text: "of team "),
                    TextSpan(
                      text: widget.teamName,
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
        CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(
            widget.avatarUrl.toString(),
          ),
          backgroundColor: ColorConstants.BLUE_DARK,
          onBackgroundImageError: (e, s) {
            setState(() {
              isErrorLoadingAvatar = true;
            });
          },
          child: isErrorLoadingAvatar ? const Icon(Icons.error_outline) : null,
        ),
      ],
    );
  }
}

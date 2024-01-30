import 'package:five_on_4_mobile/src/features/matches/domain/models/match/match_model.dart';
import 'package:flutter/material.dart';

class HomeEventsContainer extends StatelessWidget {
  const HomeEventsContainer({
    super.key,
    required this.isToday,
    required this.matches,
  });

  final bool isToday;
  final List<MatchModel> matches;

  @override
  Widget build(BuildContext context) {
    if (matches.isEmpty) {
      final message = _getWhenMessage(isToday);

      return Column(
        children: [
          Text(message.message),
          Text(message.cta),
        ],
      );
    }

    return Container();
  }
}

({
  String message,
  String cta,
}) _getWhenMessage(bool isToday) {
  if (isToday) {
    return (
      message: "No matches today",
      cta: "Have a rest, you deserve it!",
    );
  }

  return (
    message: "No joined matches",
    cta: "Why not join one?",
  );
}

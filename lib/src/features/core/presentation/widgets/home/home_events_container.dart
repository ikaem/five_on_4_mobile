import 'package:five_on_4_mobile/src/features/core/presentation/widgets/home/home_events.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/widgets/loading_status.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/models/match/match_model.dart';
import 'package:flutter/material.dart';

class HomeEventsContainer extends StatelessWidget {
  const HomeEventsContainer({
    super.key,
    required this.isToday,
    required this.matches,
    required this.isLoading,
  });

  final bool isToday;
  final bool isLoading;
  final List<MatchModel> matches;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const LoadingStatus(
        message: "Loading matches...",
      );
    }
    if (matches.isEmpty) {
      final message = _getWhenMessage(isToday);

      return Column(
        children: [
          Text(message.message),
          Text(message.cta),
        ],
      );
    }

    return HomeEvents(matches: matches);
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

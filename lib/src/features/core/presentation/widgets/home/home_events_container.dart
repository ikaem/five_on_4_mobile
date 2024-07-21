import 'package:five_on_4_mobile/src/features/core/presentation/widgets/error_status.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/widgets/matches_list.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/widgets/loading_status.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/models/match/match_model.dart';
import 'package:flutter/material.dart';

class HomeEventsContainer extends StatelessWidget {
  const HomeEventsContainer({
    super.key,
    required this.isToday,
    required this.isError,
    required this.matches,
    required this.isLoading,
    required this.isSyncing,
    required this.onRetry,
  });

  final bool isToday;
  final bool isError;
  final bool isLoading;
  final List<MatchModel> matches;
  final bool isSyncing;

  final Future<void> Function() onRetry;

  @override
  Widget build(BuildContext context) {
    if (isError) {
      return ErrorStatus(
        message: "There was an issue retrieving matches",
        onRetry: onRetry,
      );
    }

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

    return Column(
      children: [
        Expanded(
          child: MatchesList(matches: matches),
        ),
        // TODO possibly not needed - because we will not have this sync thing - or will we?
        if (isSyncing)
          const LoadingStatus(
            message: "Synchronizing with remote data...",
            isLinear: true,
          ),
      ],
    );
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

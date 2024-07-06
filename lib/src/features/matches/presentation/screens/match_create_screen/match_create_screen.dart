import 'package:auto_route/auto_route.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/screens/match_create_screen/match_create_screen_view.dart';
import 'package:flutter/material.dart';

@RoutePage()
class MatchCreateScreen extends StatelessWidget {
  const MatchCreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: MatchCreateScreenView(),
    );
  }
}

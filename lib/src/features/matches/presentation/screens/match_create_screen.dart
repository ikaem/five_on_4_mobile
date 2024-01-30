import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match_create/match_create_view.dart';
import 'package:flutter/material.dart';

class MatchCreateScreen extends StatelessWidget {
  const MatchCreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: const MatchCreateView(),
      ),
    );
  }
}

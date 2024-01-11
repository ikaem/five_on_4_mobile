// TODO dont forget to test this

import 'package:five_on_4_mobile/src/features/core/utils/constants/route_paths_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MatchCreateScreen extends StatelessWidget {
  const MatchCreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      // TODO replace app bar by back button
      appBar: AppBar(
        title: const Text("Match Create Screen"),
      ),
      body: const Column(
        children: [
          Text("Match Create Screen"),
        ],
      ),
    ));
  }
}

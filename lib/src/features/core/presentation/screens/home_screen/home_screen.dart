import 'package:auto_route/auto_route.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/screens/home_screen/home_screen_view.dart';

import 'package:flutter/material.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(
    BuildContext context,
  ) {
    return const SafeArea(
      child: HomeScreenView(),
    );
  }
}

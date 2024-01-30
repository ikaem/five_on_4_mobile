import 'package:five_on_4_mobile/src/features/core/presentation/widgets/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    return const SafeArea(
      child: Scaffold(
        body: HomeView(
          matchesToday: [],
          matchesFollowing: [],
        ),
      ),
    );
  }
}

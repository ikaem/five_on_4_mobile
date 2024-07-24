import 'package:auto_route/auto_route.dart';
import 'package:five_on_4_mobile/src/features/auth/presentation/controllers/sign_out/sign_out_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
// class SettingsScreen extends StatelessWidget {
//   const SettingsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//       body: Column(
//         children: [
//           const Text("Settings Screen"),
//           ElevatedButton(
//             onPressed: () {
//               context.go(RoutePathsConstants.MATCH.value);
//             },
//             child: const Text("Go to match"),
//           ),
//           // TODO move this to elsewhere
//           // TextButton(
//           //   onPressed: () async =>
//           //       await ref.read(signOutControllerProvider.notifier).onSignOut(),
//           //   child: const Text("Logout"),
//           // ),
//         ],
//       ),
//     ));
//   }
// }

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          const Text("Settings Screen"),

          // TODO move this to elsewhere
          TextButton(
            onPressed: () async =>
                await ref.read(signOutControllerProvider.notifier).onSignOut(),
            child: const Text("Logout"),
          ),
        ],
      ),
    ));
  }
}

import 'package:five_on_4_mobile/src/style/utils/constants/spacing_constants.dart';
import 'package:flutter/material.dart';

class LoadingStatus extends StatelessWidget {
  const LoadingStatus({
    super.key,
    required this.message,
    this.isLinear = false,
  });

  final String message;
  final bool isLinear;

  @override
  Widget build(BuildContext context) {
    final indicator = isLinear == true
        ? const LinearProgressIndicator()
        : const CircularProgressIndicator();
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(message),
          const SizedBox(
            height: SpacingConstants.M,
          ),
          indicator,
        ],
      ),
    );
  }
}

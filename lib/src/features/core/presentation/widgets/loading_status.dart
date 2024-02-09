import 'package:flutter/material.dart';

class LoadingStatus extends StatelessWidget {
  const LoadingStatus({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(message),
          const SizedBox(
            height: 5,
          ),
          const CircularProgressIndicator(),
        ],
      ),
    );
  }
}

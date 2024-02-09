import 'package:flutter/material.dart';

class LoadingStatus extends StatelessWidget {
  const LoadingStatus({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(message),
    );
  }
}

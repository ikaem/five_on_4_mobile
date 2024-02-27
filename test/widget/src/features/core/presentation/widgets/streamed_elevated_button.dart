import 'package:flutter/material.dart';

class StreamedElevatedButton extends StatelessWidget {
  const StreamedElevatedButton({
    super.key,
    required this.isEnabledStream,
    required this.onPressed,
    required this.label,
  });

  final Stream<bool> isEnabledStream;
  final VoidCallback onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: isEnabledStream,
      builder: (context, snapshot) {
        final isError = snapshot.hasError;
        final isEnabled = !isError && snapshot.data == true;

        return ElevatedButton(
          onPressed: isEnabled ? onPressed : null,
          child: Text(label),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';

class DialogWrapper extends StatelessWidget {
  const DialogWrapper({
    super.key,
    required this.child,
    required this.title,
  });

  final Widget child;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      // TODO make color customizable eventually
      backgroundColor: const Color.fromARGB(255, 160, 197, 227),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: Text(title)),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.close_rounded,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}

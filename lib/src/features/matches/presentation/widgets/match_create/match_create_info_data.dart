import 'package:flutter/material.dart';

class MatchCreateInfoData extends StatelessWidget {
  const MatchCreateInfoData({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "MATCH NAME",
          ),
        ),
        SizedBox(
          height: 10,
        ),
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "MATCH DATE",
          ),
        ),
      ],
    );
  }
}

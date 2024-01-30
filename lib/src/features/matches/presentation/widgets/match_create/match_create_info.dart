import 'package:flutter/material.dart';

class MatchCreateInfo extends StatelessWidget {
  const MatchCreateInfo({super.key});

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
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "MATCH TIME",
          ),
        ),
        TextField(
          minLines: 5,
          maxLines: 5,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "MATCH DESCRIPTION",
          ),
        ),
      ],
    );
  }
}

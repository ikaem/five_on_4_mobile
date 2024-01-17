import 'package:flutter/material.dart';

class MatchBriefExtended extends StatelessWidget {
  const MatchBriefExtended({
    super.key,
    required this.date,
    required this.dayName,
    required this.time,
  });

  final String date;
  final String dayName;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      children: [
        _DateElement(
          date: date,
          dayName: dayName,
          time: time,
        ),
      ],
    ));
  }
}

class _DateElement extends StatelessWidget {
  const _DateElement({
    required this.date,
    required this.dayName,
    required this.time,
  });

  final String date;
  final String dayName;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.blue,
          child: Column(
            children: [
              Text(
                date,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                dayName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Text(
          time,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

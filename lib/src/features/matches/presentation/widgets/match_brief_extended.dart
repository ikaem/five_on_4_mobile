import 'package:flutter/material.dart';

class MatchBriefExtended extends StatelessWidget {
  const MatchBriefExtended({
    super.key,
    required this.date,
    required this.dayName,
    required this.time,
    required this.title,
    required this.location,
  });

  final String date;
  final String dayName;
  final String time;
  final String title;
  final String location;

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
        Expanded(
          child: Column(
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                location,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
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

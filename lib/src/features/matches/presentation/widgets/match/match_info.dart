import 'package:flutter/material.dart';

class MatchInfo extends StatelessWidget {
  const MatchInfo({
    super.key,
    required this.date,
    required this.dayName,
    required this.time,
    required this.title,
    required this.location,
    required this.organizer,
    required this.arrivingPlayersNumber,
  });

  final String date;
  final String dayName;
  final String time;
  final String title;
  final String location;
  final String organizer;
  final int arrivingPlayersNumber;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      children: [
        Expanded(
          child: _DateElement(
            date: date,
            dayName: dayName,
            time: time,
          ),
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
              Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                      text: "Organized by: ",
                    ),
                    TextSpan(
                      text: organizer,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                      text: "Arriving players: ",
                    ),
                    TextSpan(
                      text: arrivingPlayersNumber.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
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

import 'package:flutter/material.dart';

class TripDayCard extends StatelessWidget {
  final int day;
  final String place1;
  final String place2;

  const TripDayCard({
    super.key,
    required this.day,
    required this.place1,
    required this.place2,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "📅 Day $day",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Text(
              "📍 $place1",
              style: const TextStyle(fontSize: 17),
            ),

            const SizedBox(height: 8),

            Text(
              "⭐ $place2",
              style: const TextStyle(fontSize: 17),
            ),
          ],
        ),
      ),
    );
  }
}
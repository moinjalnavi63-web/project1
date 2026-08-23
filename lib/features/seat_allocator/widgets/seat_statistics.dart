import 'package:flutter/material.dart';

class SeatStatistics extends StatelessWidget {
  final int occupiedSeats;
  final int availableSeats;

  const SeatStatistics({
    super.key,
    required this.occupiedSeats,
    required this.availableSeats,
  });

  Widget statisticCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Expanded(
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 18,
            horizontal: 12,
          ),
          child: Column(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: color.withAlpha(30),
                child: Icon(
                  icon,
                  color: color,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                title,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                value,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          statisticCard(
            icon: Icons.person,
            title: "Occupied",
            value: occupiedSeats.toString(),
            color: Colors.red,
          ),

          const SizedBox(width: 12),

          statisticCard(
            icon: Icons.event_seat,
            title: "Available",
            value: availableSeats.toString(),
            color: Colors.green,
          ),
        ],
      ),
    );
  }
}
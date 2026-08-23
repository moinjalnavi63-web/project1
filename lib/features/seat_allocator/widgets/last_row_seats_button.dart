import 'package:flutter/material.dart';

import '../pages/last_row_seats_screen.dart';

class LastRowSeatsButton extends StatelessWidget {
  final String busId;
  final String tripDate;

  const LastRowSeatsButton({
    super.key,
    required this.busId,
    required this.tripDate,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 54,
        child: FilledButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LastRowSeatsScreen(
                  busId: busId,
                  tripDate: tripDate,
                ),
              ),
            );
          },
          icon: const Icon(
            Icons.event_seat_rounded,
          ),
          label: const Text(
            'Last Row Seats',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          style: FilledButton.styleFrom(
            backgroundColor: const Color(0xFF7C3AED),
            foregroundColor: Colors.white,
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
            ),
          ),
        ),
      ),
    );
  }
}
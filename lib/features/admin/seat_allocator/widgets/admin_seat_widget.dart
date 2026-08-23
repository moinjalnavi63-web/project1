import 'package:flutter/material.dart';

import '../models/admin_seat_model.dart';

class AdminSeatWidget extends StatelessWidget {
  final AdminSeatModel seat;
  final VoidCallback onTap;

  const AdminSeatWidget({
    super.key,
    required this.seat,
    required this.onTap,
  });

  Color _borderColor() {
    if (seat.isBuddySeat) {
      return Colors.deepPurple;
    }

    switch (seat.zone) {
      case AdminSeatZone.faculty:
        return Colors.blue;
      case AdminSeatZone.girls:
        return Colors.pink;
      case AdminSeatZone.boys:
        return Colors.green;
    }
  }

  Color _iconColor() {
    if (seat.isBuddySeat) {
      return Colors.deepPurple;
    }

    switch (seat.zone) {
      case AdminSeatZone.faculty:
        return Colors.blue;
      case AdminSeatZone.girls:
        return Colors.pink;
      case AdminSeatZone.boys:
        return Colors.green;
    }
  }

  Color _backgroundColor() {
    if (seat.isBuddySeat) {
      return Colors.deepPurple.withValues(alpha: 0.10);
    }

    if (!seat.isOccupied) {
      return Colors.white;
    }

    switch (seat.zone) {
      case AdminSeatZone.faculty:
        return Colors.blue.withValues(alpha: 0.08);
      case AdminSeatZone.girls:
        return Colors.pink.withValues(alpha: 0.08);
      case AdminSeatZone.boys:
        return Colors.green.withValues(alpha: 0.08);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 82,
        height: 102,
        margin: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: _backgroundColor(),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: _borderColor(),
            width: seat.isBuddySeat ? 3 : 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.event_seat,
                size: 21,
                color: _iconColor(),
              ),

              const SizedBox(height: 3),

              Text(
                seat.seatId,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: _iconColor(),
                ),
              ),

              const SizedBox(height: 3),

              Text(
                seat.isOccupied
                    ? (seat.studentName ?? 'Occupied')
                    : 'Available',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),

              if (seat.isOccupied &&
                  seat.studentUsn != null) ...[
                const SizedBox(height: 2),
                Text(
                  seat.studentUsn!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 8,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],

              if (seat.isBuddySeat) ...[
                const SizedBox(height: 2),
                const Icon(
                  Icons.groups,
                  size: 13,
                  color: Colors.deepPurple,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
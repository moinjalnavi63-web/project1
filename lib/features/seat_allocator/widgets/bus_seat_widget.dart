import 'package:flutter/material.dart';

import '../models/seat_model.dart';
import '../utils/seat_colors.dart';

class BusSeatWidget extends StatelessWidget {
  final SeatModel seat;
  final VoidCallback? onTap;

  const BusSeatWidget({
    super.key,
    required this.seat,
    this.onTap,
  });

  Color get seatColor {
    switch (seat.zone) {
      case SeatZone.faculty:
        return SeatColors.faculty;

      case SeatZone.girls:
        return SeatColors.girls;

      case SeatZone.boys:
        return SeatColors.boys;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isMySeat =
        seat.isCurrentUserSeat && seat.isClickable;

    return GestureDetector(
      onTap: isMySeat
          ? () {
        _showSeatConfirmation(context);
      }
          : null,

      child: Container(
        // IMPORTANT:
        // Keep this small so multiple seats can fit in one row.
        width: 68,

        height: 82,

        margin: const EdgeInsets.symmetric(
          horizontal: 1,
          vertical: 2,
        ),

        decoration: BoxDecoration(
          color: isMySeat
              ? Colors.amber.shade100
              : Colors.white,

          borderRadius: BorderRadius.circular(11),

          border: Border.all(
            color: isMySeat
                ? Colors.amber.shade700
                : seatColor,
            width: isMySeat ? 3 : 1.5,
          ),

          boxShadow: [
            BoxShadow(
              color: isMySeat
                  ? Colors.amber.withOpacity(0.35)
                  : seatColor.withOpacity(0.12),
              blurRadius: isMySeat ? 8 : 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),

        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 2,
            vertical: 2,
          ),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              // ============================
              // SEAT ICON
              // ============================

              Icon(
                Icons.event_seat,
                size: 15,
                color: isMySeat
                    ? Colors.amber.shade800
                    : seatColor,
              ),

              const SizedBox(height: 1),

              // ============================
              // SEAT NUMBER
              // ============================

              Text(
                seat.seatId,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: isMySeat
                      ? Colors.amber.shade900
                      : seatColor,
                ),
              ),

              const SizedBox(height: 2),

              // ============================
              // NAME
              // ============================

              Text(
                seat.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 8.5,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 1),

              // ============================
              // USN / EMPLOYEE ID
              // ============================

              Text(
                seat.id,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 7.5,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),

              // ============================
              // USER SEAT INDICATOR
              // ============================

              if (isMySeat)
                Icon(
                  Icons.star,
                  size: 10,
                  color: Colors.amber.shade800,
                ),
            ],
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // SEAT CONFIRMATION
  // ==========================================================

  void _showSeatConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),

          title: const Center(
            child: Text(
              "You Got a Seat",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              Icon(
                Icons.event_seat,
                size: 55,
                color: Colors.amber.shade700,
              ),

              const SizedBox(height: 10),

              Text(
                "Your seat is ${seat.seatId}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              const Text(
                "You got a seat. Yes / No?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),

          actionsAlignment: MainAxisAlignment.spaceEvenly,

          actions: [

            // ============================
            // YES
            // ============================

            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(dialogContext);

                ScaffoldMessenger.of(context)
                    .showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.green,
                    duration: Duration(seconds: 3),
                    content: Text(
                      "Thanks! Happy Journey 😊",
                    ),
                  ),
                );
              },

              icon: const Icon(Icons.check),

              label: const Text("YES"),

              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
            ),

            // ============================
            // NO
            // ============================

            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(dialogContext);

                ScaffoldMessenger.of(context)
                    .showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.orange,
                    duration: Duration(seconds: 3),
                    content: Text(
                      "Please confirm your attendance.",
                    ),
                  ),
                );
              },

              icon: const Icon(Icons.close),

              label: const Text("NO"),

              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        );
      },
    );
  }
}
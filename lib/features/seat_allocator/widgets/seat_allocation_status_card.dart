import 'package:flutter/material.dart';

class SeatAllocationStatusCard extends StatelessWidget {
  final bool? comingToday;
  final String seatNumber;

  const SeatAllocationStatusCard({
    super.key,
    required this.comingToday,
    required this.seatNumber,
  });

  @override
  Widget build(BuildContext context) {
    // User has not selected YES or NO yet.
    if (comingToday == null) {
      return const SizedBox.shrink();
    }

    // =========================================================
    // USER IS NOT COMING
    // =========================================================

    if (comingToday == false) {
      return Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [

              const Icon(
                Icons.cancel,
                color: Colors.red,
                size: 50,
              ),

              const SizedBox(height: 12),

              const Text(
                "Attendance Marked Absent",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                "No seat allocated today.",
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    // =========================================================
    // USER IS COMING
    // =========================================================

    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 50,
            ),

            const SizedBox(height: 12),

            const Text(
              "Attendance Confirmed",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Seat Allocated Successfully",
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 18),

            // =================================================
            // SEAT NUMBER
            // =================================================

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 14,
              ),

              decoration: BoxDecoration(
                color: Colors.amber.shade100,
                borderRadius: BorderRadius.circular(15),

                border: Border.all(
                  color: Colors.amber.shade700,
                  width: 2,
                ),
              ),

              child: Text(
                seatNumber.isEmpty
                    ? "Seat Pending"
                    : seatNumber,

                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: seatNumber.isEmpty
                      ? Colors.grey
                      : Colors.amber.shade900,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
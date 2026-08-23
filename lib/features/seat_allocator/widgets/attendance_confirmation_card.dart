import 'package:flutter/material.dart';

class AttendanceConfirmationCard extends StatelessWidget {
  final VoidCallback onYes;
  final VoidCallback onNo;

  const AttendanceConfirmationCard({
    super.key,
    required this.onYes,
    required this.onNo,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [

            const Icon(
              Icons.notifications_active,
              color: Colors.orange,
              size: 42,
            ),

            const SizedBox(height: 12),

            const Text(
              "Today's Attendance",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Are you coming to college today?",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 20),

            Row(
              children: [

                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: onYes,
                    icon: const Icon(Icons.check_circle),
                    label: const Text("YES"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      minimumSize: const Size.fromHeight(50),
                    ),
                  ),
                ),

                const SizedBox(width: 15),

                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: onNo,
                    icon: const Icon(Icons.cancel),
                    label: const Text("NO"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      minimumSize: const Size.fromHeight(50),
                    ),
                  ),
                ),

              ],
            ),

          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class SeatGroupCard extends StatelessWidget {
  final String seatId;
  final Color color;
  final IconData icon;
  final List<String> members;

  const SeatGroupCard({
    super.key,
    required this.seatId,
    required this.color,
    required this.icon,
    required this.members,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            Row(
              children: [

                CircleAvatar(
                  backgroundColor: color.withAlpha(35),
                  child: Icon(
                    icon,
                    color: color,
                  ),
                ),

                const SizedBox(width: 12),

                Text(
                  seatId,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

              ],
            ),

            const SizedBox(height: 16),

            ...members.map(
                  (member) => ListTile(
                dense: true,
                leading: Icon(
                  Icons.person,
                  color: color,
                ),
                title: Text(member),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
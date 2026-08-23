import 'package:flutter/material.dart';

class BusInfoCard extends StatelessWidget {
  final String busNumber;
  final String routeName;
  final int totalSeats;
  final int facultySeats;
  final int girlsSeats;
  final int boysSeats;

  const BusInfoCard({
    super.key,
    required this.busNumber,
    required this.routeName,
    required this.totalSeats,
    required this.facultySeats,
    required this.girlsSeats,
    required this.boysSeats,
  });

  Widget infoItem(
      IconData icon,
      String title,
      String value,
      Color color,
      ) {
    return Expanded(
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

          const SizedBox(height: 8),

          Text(
            title,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 13,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [

            Row(
              children: [
                const Icon(
                  Icons.directions_bus,
                  color: Colors.indigo,
                ),

                const SizedBox(width: 10),

                Text(
                  "Bus No. $busNumber",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Route: $routeName",
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),

            const Divider(height: 30),

            Row(
              children: [
                infoItem(
                  Icons.event_seat,
                  "Seats",
                  totalSeats.toString(),
                  Colors.deepPurple,
                ),
                infoItem(
                  Icons.school,
                  "Faculty",
                  facultySeats.toString(),
                  Colors.blue,
                ),
              ],
            ),

            const SizedBox(height: 18),

            Row(
              children: [
                infoItem(
                  Icons.girl,
                  "Girls",
                  girlsSeats.toString(),
                  Colors.pink,
                ),
                infoItem(
                  Icons.boy,
                  "Boys",
                  boysSeats.toString(),
                  Colors.green,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
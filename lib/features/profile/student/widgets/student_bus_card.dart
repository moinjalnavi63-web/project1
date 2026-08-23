import 'package:flutter/material.dart';

class StudentBusCard extends StatelessWidget {
  const StudentBusCard({super.key});

  Widget tile(
      IconData icon,
      String title,
      String value,
      ) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: const Color(0xFFD1FAE5),
        child: Icon(
          icon,
          color: Colors.green,
        ),
      ),
      title: Text(title),
      subtitle: Text(
        value,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
        ),
        child: Column(
          children: [

            tile(
              Icons.directions_bus,
              "Bus Number",
              "Bus 01",
            ),

            tile(
              Icons.route,
              "Route",
              "Hospet Route",
            ),

          ],
        ),
      ),
    );
  }
}
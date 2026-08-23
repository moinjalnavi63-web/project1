import 'package:flutter/material.dart';

class StudentInfoCard extends StatelessWidget {
  const StudentInfoCard({super.key});

  Widget buildTile(
      IconData icon,
      String title,
      String value,
      ) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: const Color(0xFFEDE9FE),
        child: Icon(
          icon,
          color: const Color(0xFF5B5FEF),
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

            buildTile(
              Icons.school,
              "Department",
              "CSE",
            ),

            buildTile(
              Icons.calendar_today,
              "Admission Year",
              "2024",
            ),

            buildTile(
              Icons.workspace_premium,
              "Current Year",
              "3rd Year",
            ),

          ],
        ),
      ),
    );
  }
}
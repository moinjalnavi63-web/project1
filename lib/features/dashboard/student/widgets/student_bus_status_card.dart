import 'package:flutter/material.dart';

class StudentBusStatusCard extends StatelessWidget {
  const StudentBusStatusCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.92),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.06),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [

          Row(
            children: const [

              CircleAvatar(
                radius: 25,
                backgroundColor: Color(0xFFE0F2FE),
                child: Icon(
                  Icons.directions_bus,
                  color: Color(0xFF0284C7),
                ),
              ),

              SizedBox(width: 15),

              Expanded(
                child: Text(
                  "Today's Bus Status",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

            ],
          ),

          const SizedBox(height: 20),

          _buildRow("Bus Number", "Bus 01"),
          _buildRow("Route", "Hospet Route"),
          _buildRow("Driver", "Driver Name"),
          _buildRow("Current Stop", "Mariyammanahalli"),
          _buildRow("Expected Arrival", "08:15 AM"),
          _buildRow("Status", "On Time"),

        ],
      ),
    );
  }

  Widget _buildRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        children: [

          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          Text(
            value,
            style: const TextStyle(
              color: Colors.blueGrey,
            ),
          ),

        ],
      ),
    );
  }
}
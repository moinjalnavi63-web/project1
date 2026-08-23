import 'package:flutter/material.dart';

class WelcomeCard extends StatelessWidget {
  const WelcomeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF5B5FEF),
            Color(0xFF7C83FD),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [

          Text(
            "Welcome",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),

          SizedBox(height: 8),

          Text(
            "Mohammed Moinuddin",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),

          SizedBox(height: 20),

          Row(
            children: [

              Icon(
                Icons.badge,
                color: Colors.white,
              ),

              SizedBox(width: 10),

              Text(
                "USN : KUB24CSE118",
                style: TextStyle(
                  color: Colors.white,
                ),
              )

            ],
          ),

          SizedBox(height: 12),

          Row(
            children: [

              Icon(
                Icons.directions_bus,
                color: Colors.white,
              ),

              SizedBox(width: 10),

              Text(
                "Bus : Bus 01",
                style: TextStyle(
                  color: Colors.white,
                ),
              )

            ],
          ),

          SizedBox(height: 12),

          Row(
            children: [

              Icon(
                Icons.route,
                color: Colors.white,
              ),

              SizedBox(width: 10),

              Text(
                "Route : Hospet",
                style: TextStyle(
                  color: Colors.white,
                ),
              )

            ],
          ),
        ],
      ),
    );
  }
}
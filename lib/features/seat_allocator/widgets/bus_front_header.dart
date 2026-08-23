import 'package:flutter/material.dart';

class BusFrontHeader extends StatelessWidget {
  const BusFrontHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 18,
      ),
      child: Column(
        children: [

          Row(
            children: [

              const Expanded(
                child: Divider(
                  color: Colors.white24,
                  thickness: 1,
                ),
              ),

              const SizedBox(width: 12),

              const Icon(
                Icons.arrow_drop_up,
                color: Colors.white70,
              ),

              const SizedBox(width: 4),

              const Text(
                "FRONT OF BUS",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  letterSpacing: 3,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(width: 12),

              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white24,
                    width: 2,
                  ),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.settings,
                  color: Colors.white70,
                  size: 30,
                ),
              ),

              const SizedBox(width: 12),

              const Expanded(
                child: Divider(
                  color: Colors.white24,
                  thickness: 1,
                ),
              ),

            ],
          ),

          const SizedBox(height: 12),

          const Text(
            "Driver Cabin",
            style: TextStyle(
              color: Colors.white54,
              letterSpacing: 2,
            ),
          ),

        ],
      ),
    );
  }
}
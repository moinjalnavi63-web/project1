import 'package:flutter/material.dart';

class DriverTripStatusCard extends StatelessWidget {
  const DriverTripStatusCard({super.key});

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
                backgroundColor: Color(0xFFE0F2FE),
                child: Icon(
                  Icons.alt_route,
                  color: Color(0xFF0284C7),
                ),
              ),

              SizedBox(width: 12),

              Text(
                "Today's Trip",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              )

            ],
          ),

          const SizedBox(height: 20),

          _StatusRow(
            title: "Bus Number",
            value: "Bus 01",
          ),

          _StatusRow(
            title: "Route",
            value: "Hospet Route",
          ),

          _StatusRow(
            title: "Current Stop",
            value: "Mariyammanahalli",
          ),

          _StatusRow(
            title: "Students",
            value: "48/60",
          ),

          _StatusRow(
            title: "Trip Status",
            value: "Running",
          ),

          const SizedBox(height: 20),

          Row(
            children: [

              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.play_arrow),
                  label: const Text("Start"),
                ),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.flag),
                  label: const Text("End"),
                ),
              ),

            ],
          )

        ],
      ),
    );
  }
}

class _StatusRow extends StatelessWidget {
  final String title;
  final String value;

  const _StatusRow({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
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

          Text(value),

        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';

import '../models/bus_model.dart';
import '../widgets/stop_tile.dart';

class BusDetailsScreen extends StatelessWidget {
  final BusModel bus;

  const BusDetailsScreen({
    super.key,
    required this.bus,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bus No. ${bus.busNumber}"),
        centerTitle: true,
      ),

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFD1FAE5),
              Color(0xFFE0E7FF),
              Color(0xFFCFFAFE),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child: ListView(
          padding: const EdgeInsets.all(20),

          children: [

            const CircleAvatar(
              radius: 55,
              child: Icon(
                Icons.person,
                size: 60,
              ),
            ),

            const SizedBox(height: 15),

            Center(
              child: Text(
                bus.driverName,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 6),

            Center(
              child: Text(
                bus.driverMobile,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),

            const SizedBox(height: 25),

            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),

              child: Padding(
                padding: const EdgeInsets.all(16),

                child: Column(
                  children: [

                    ListTile(
                      leading: const Icon(Icons.directions_bus),
                      title: Text("Bus No. ${bus.busNumber}"),
                    ),

                    ListTile(
                      leading: const Icon(Icons.route),
                      title: Text(bus.routeName),
                    ),

                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              "Pickup Stops",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),

            const SizedBox(height: 12),

            ...bus.stops.map(
                  (stop) => StopTile(
                stopName: stop.name,
                arrivalTime: stop.time,
              ),
            ),

          ],
        ),
      ),
    );
  }
}
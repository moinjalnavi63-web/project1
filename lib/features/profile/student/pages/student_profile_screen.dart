import 'package:flutter/material.dart';

import '../widgets/student_profile_header.dart';
import '../widgets/student_info_card.dart';
import '../widgets/student_bus_card.dart';
import '../../../gps_tracking/widgets/live_bus_route_map.dart';
import '../../../gps_tracking/widgets/live_bus_route_map.dart';
import '../../../gps_tracking/pages/hospet_route_data.dart';
class StudentProfileScreen extends StatelessWidget {
  const StudentProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFD1FAE5),
              Color(0xFFE0E7FF),
              Color(0xFFCFFAFE),
            ],
          ),
        ),

        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const StudentProfileHeader(),

                const SizedBox(height: 25),

                const Text(
                  "Academic Information",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                const StudentInfoCard(),

                const SizedBox(height: 25),

                const Text(
                  "Transport Information",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),


                const SizedBox(height: 12),

                const StudentBusCard(),
                const SizedBox(height: 20),

                const LiveBusRouteMap(
                  busNumber: 'Bus 01',
                  routeName: 'Hospet Route',
                  stops: hospetRouteStops,
                ),


                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
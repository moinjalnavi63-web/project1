import 'package:flutter/material.dart';

import '../widgets/driver_drawer.dart';
import '../widgets/driver_quick_actions.dart';
import '../widgets/driver_trip_status_card.dart';
import '../widgets/driver_announcement_card.dart';
import '../widgets/driver_assigned_bus_screen.dart';
import '../widgets/driver_assigned_route_screen.dart';
import 'driver_profile_screen.dart';

class DriverDashboardScreen extends StatefulWidget {
  const DriverDashboardScreen({super.key});

  @override
  State<DriverDashboardScreen> createState() =>
      _DriverDashboardScreenState();
}

class _DriverDashboardScreenState
    extends State<DriverDashboardScreen> {

  int selectedIndex = 0;

  late final List<Widget> pages;

  final List<String> titles = const [
    "Welcome to KUTS",
    "Driver Profile",
    "Assigned Bus",
    "Assigned Route",
    "Bus Student Group",
    "Live GPS Sharing",
    "Trip Status",
    "Bus Announcements",
  ];

  @override
  void initState() {
    super.initState();

    pages = [
      _dashboardPage(),
      const DriverProfileScreen(),
      const DriverAssignedBusScreen(),
      const DriverAssignedRouteScreen(),
      const Center(
        child: Text("Bus Student Group"),
      ),
      const Center(
        child: Text("Live GPS Sharing"),
      ),
      const Center(
        child: Text("Trip Status"),
      ),
      const Center(
        child: Text("Bus Announcements"),
      ),
    ];
  }

  void changePage(int index) {
    setState(() {
      selectedIndex = index;
    });

    Navigator.pop(context);
  }

  Widget _dashboardPage() {
    return Container(
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
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [

              const SizedBox(height: 10),

              // =====================================================
              // ADMIN ANNOUNCEMENTS ONLY
              // =====================================================

              const Text(
                "Admin Announcements",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              const DriverAnnouncementCard(),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DriverDrawer(
        selectedIndex: selectedIndex,
        onItemSelected: changePage,
      ),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          titles[selectedIndex],
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_none,
            ),
          ),
        ],
      ),

      body: AnimatedSwitcher(
        duration: const Duration(
          milliseconds: 300,
        ),
        child: pages[selectedIndex],
      ),
    );
  }
}
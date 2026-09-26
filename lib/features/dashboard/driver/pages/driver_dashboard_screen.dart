import 'package:flutter/material.dart';

import '../widgets/driver_drawer.dart';
import '../widgets/driver_quick_actions.dart';
import '../widgets/driver_trip_status_card.dart';
import '../widgets/driver_announcement_card.dart';
import '../widgets/driver_assigned_bus_screen.dart';
import '../widgets/driver_assigned_route_screen.dart';
import 'driver_profile_screen.dart';

import 'driver_gps_screen.dart';

import '../../../admin/announcements/data/demo_announcements.dart';

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

      const DriverGpsScreen(),

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

  void openSearch() {
    showAnnouncementSearch(
      context,
      'driver',
    );
  }

  void openNotifications() {
    showAnnouncementNotifications(
      context,
      'driver',
    );
  }

  Widget _dashboardPage() {
    return SizedBox.expand(
      child: Container(
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
            padding:
            const EdgeInsets.all(18),

            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: const [
                SizedBox(height: 10),

                Text(
                  "Admin Announcements",

                  style: TextStyle(
                    fontSize: 22,
                    fontWeight:
                    FontWeight.bold,
                  ),
                ),

                SizedBox(height: 15),

                DriverAnnouncementCard(),

                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final driverAnnouncements =
    announcementsForRole(
      'driver',
    );

    final unread =
    AnnouncementInteractionStore
        .unreadCount(
      driverAnnouncements,
    );

    return Scaffold(
      drawer: DriverDrawer(
        selectedIndex: selectedIndex,
        onItemSelected: changePage,
      ),

      appBar: AppBar(
        elevation: 0,

        backgroundColor:
        Colors.transparent,

        centerTitle: true,

        title: Text(
          titles[selectedIndex],

          style: const TextStyle(
            fontWeight:
            FontWeight.bold,
          ),
        ),

        actions: [
          IconButton(
            onPressed: openSearch,

            icon: const Icon(
              Icons.search,
            ),
          ),

          Stack(
            children: [
              IconButton(
                onPressed:
                openNotifications,

                icon: const Icon(
                  Icons.notifications_none,
                ),
              ),

              if (unread > 0)
                Positioned(
                  right: 7,
                  top: 7,

                  child: Container(
                    width: 17,
                    height: 17,

                    alignment:
                    Alignment.center,

                    decoration:
                    const BoxDecoration(
                      color: Colors.red,
                      shape:
                      BoxShape.circle,
                    ),

                    child: Text(
                      unread > 9
                          ? '9+'
                          : '$unread',

                      style:
                      const TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),

      body: AnimatedSwitcher(
        duration:
        const Duration(
          milliseconds: 300,
        ),

        child:
        pages[selectedIndex],
      ),
    );
  }
}
import 'package:flutter/material.dart';

import '../widgets/faculty_drawer.dart';
import '../widgets/faculty_announcement_card.dart';

import '../../../profile/faculty/pages/faculty_profile_screen.dart';
import '../../../bus_directory/pages/bus_directory_screen.dart';
import '../pages/faculty_seat_allocator_screen.dart';
import '../../../raise_token/screens/raise_token_screen.dart';
import '../../../gps_tracking/pages/live_gps_tracking_screen.dart';

class FacultyDashboardScreen extends StatefulWidget {
  const FacultyDashboardScreen({super.key});

  @override
  State<FacultyDashboardScreen> createState() =>
      _FacultyDashboardScreenState();
}

class _FacultyDashboardScreenState
    extends State<FacultyDashboardScreen> {

  int selectedIndex = 0;

  final List<Widget> pages = const [
    FacultyAnnouncementPage(),
    FacultyProfileScreen(),
    BusDirectoryScreen(),
    FacultySeatAllocatorScreen(),

    Center(
      child: Text(
        "Bus Group",
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),

    const LiveGpsTrackingScreen(),
    RaiseTokenScreen(),

    Center(
      child: Text(
        "Announcements",
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),

    Center(
      child: Text(
        "Student Directory",
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  ];

  final List<String> titles = const [
    "Welcome to KUTS",
    "Faculty Profile",
    "Bus Directory",
    "Seat Allocator",
    "Bus Group",
    "Live GPS Tracking",
    "Raise Token",
    "Announcements",
    "Student Directory",
  ];

  void changePage(int index) {
    if (index == -1) {
      setState(() {
        selectedIndex = 0;
      });

      Navigator.pop(context);
      return;
    }

    setState(() {
      selectedIndex = index;
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: FacultyDrawer(
        selectedIndex: selectedIndex,
        onItemSelected: changePage,
      ),

      appBar: AppBar(
        title: Text(
          titles[selectedIndex],
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications_none,
            ),
            onPressed: () {},
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


// ============================================================
// FACULTY HOME / ADMIN ANNOUNCEMENTS
// ============================================================

class FacultyAnnouncementPage extends StatelessWidget {
  const FacultyAnnouncementPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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

            children: const [

              SizedBox(height: 10),

              Text(
                "Admin Announcements",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF111827),
                ),
              ),

              SizedBox(height: 6),

              Text(
                "Latest announcements from administration",
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF4B5563),
                ),
              ),

              SizedBox(height: 20),

              FacultyAnnouncementCard(),

              SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}
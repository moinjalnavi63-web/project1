import 'package:flutter/material.dart';

import '../widgets/student_drawer.dart';
import '../widgets/student_home.dart';

import '../../../seat_allocator/pages/seat_allocator_screen.dart';
import '../../../profile/student/pages/student_profile_screen.dart';
import '../../../bus_directory/pages/bus_directory_screen.dart';
import '../../../raise_token/screens/raise_token_screen.dart';
import '../../../gps_tracking/pages/live_gps_tracking_screen.dart';
class StudentDashboardScreen extends StatefulWidget {
  const StudentDashboardScreen({super.key});

  @override
  State<StudentDashboardScreen> createState() =>
      _StudentDashboardScreenState();
}

class _StudentDashboardScreenState
    extends State<StudentDashboardScreen> {

  int selectedIndex = 0;

  final List<Widget> pages = const [
    StudentHome(),
    StudentProfileScreen(),
    BusDirectoryScreen(),
    SeatAllocatorScreen(),
    Center(
      child: Text("Bus Group"),
    ),
    const LiveGpsTrackingScreen(),
    RaiseTokenScreen(),
    Center(
      child: Text("Announcements"),
    ),
    Center(
      child: Text("Student Directory"),
    ),
  ];

  final List<String> titles = const [
    "Welcome to KUTS",
    "Profile",
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
        selectedIndex = -1;
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
      drawer: StudentDrawer(
        selectedIndex: selectedIndex,
        onItemSelected: changePage,
      ),

      appBar: AppBar(
        title: Text(
          selectedIndex == -1
              ? "Welcome to KUTS"
              : titles[selectedIndex],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              Icons.notifications_none,
            ),
            onPressed: () {},
          ),
        ],
      ),

      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: selectedIndex == -1
            ? const StudentHome()
            : pages[selectedIndex],
      ),
    );
  }
}
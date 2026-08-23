import 'package:flutter/material.dart';

import '../widgets/student_filter_bar.dart';
import '../widgets/student_profile_card.dart';

class AdminStudentProfilesScreen extends StatefulWidget {
  const AdminStudentProfilesScreen({
    super.key,
  });

  @override
  State<AdminStudentProfilesScreen> createState() =>
      _AdminStudentProfilesScreenState();
}

class _AdminStudentProfilesScreenState
    extends State<AdminStudentProfilesScreen> {

  final TextEditingController searchController =
  TextEditingController();

  String searchText = '';

  String selectedBranch = 'All';
  String selectedYear = 'All';
  String selectedBus = 'All';

  // ============================================================
  // DEMO STUDENT DATA
  // ============================================================

  final List<Map<String, String>> students = [

    {
      'name': 'Moin',
      'usn': 'KUB24CSE118',
      'branch': 'CSE',
      'year': '3rd Year',
      'email': 'moin@example.com',
      'mobile': '9876543210',
      'bus': 'Bus 1',
      'route': 'Hospet → Kishkinda University',
      'stop': 'Hospet',
      'seat': '11B',
    },

    {
      'name': 'Mohammed Mansoor',
      'usn': 'KUB24CSE119',
      'branch': 'CSE',
      'year': '3rd Year',
      'email': 'mansoor@example.com',
      'mobile': '9876543211',
      'bus': 'Bus 1',
      'route': 'Hospet → Kishkinda University',
      'stop': 'Hospet',
      'seat': '11C',
    },

    {
      'name': 'Rahul Kumar',
      'usn': 'KUB25ECE101',
      'branch': 'ECE',
      'year': '2nd Year',
      'email': 'rahul@example.com',
      'mobile': '9876543212',
      'bus': 'Bus 2',
      'route': 'Gangavathi → Kishkinda University',
      'stop': 'Gangavathi',
      'seat': '8A',
    },

    {
      'name': 'Anjali',
      'usn': 'KUB25ISE104',
      'branch': 'ISE',
      'year': '2nd Year',
      'email': 'anjali@example.com',
      'mobile': '9876543213',
      'bus': 'Bus 2',
      'route': 'Gangavathi → Kishkinda University',
      'stop': 'Gangavathi',
      'seat': '8B',
    },

    {
      'name': 'Arun',
      'usn': 'KUB26AIML110',
      'branch': 'AIML',
      'year': '1st Year',
      'email': 'arun@example.com',
      'mobile': '9876543214',
      'bus': 'Bus 3',
      'route': 'Koppal → Kishkinda University',
      'stop': 'Koppal',
      'seat': '5A',
    },
  ];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // ============================================================
  // FILTERING
  // ============================================================

  List<Map<String, String>> get filteredStudents {

    final search = searchText.trim().toLowerCase();

    return students.where(
          (student) {

        final name =
        student['name']!.toLowerCase();

        final usn =
        student['usn']!.toLowerCase();

        final branch =
        student['branch']!;

        final year =
        student['year']!;

        final bus =
        student['bus']!;

        final matchesSearch =
            search.isEmpty ||
                name.contains(search) ||
                usn.contains(search);

        final matchesBranch =
            selectedBranch == 'All' ||
                branch == selectedBranch;

        final matchesYear =
            selectedYear == 'All' ||
                year == selectedYear;

        final matchesBus =
            selectedBus == 'All' ||
                bus == selectedBus;

        return matchesSearch &&
            matchesBranch &&
            matchesYear &&
            matchesBus;
      },
    ).toList();
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {

    final filtered = filteredStudents;

    return Scaffold(

      body: Container(

        width: double.infinity,

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xffd1fae5),
              Color(0xffe0e7ff),
              Color(0xffcffafe),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child: SafeArea(

          child: Column(
            children: [

              // ==================================================
              // HEADER
              // ==================================================

              Padding(
                padding: const EdgeInsets.fromLTRB(
                  10,
                  8,
                  16,
                  10,
                ),

                child: Row(
                  children: [

                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back_rounded,
                      ),

                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),

                    const Expanded(
                      child: Text(
                        'Student Profiles',
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 11,
                        vertical: 7,
                      ),

                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                        BorderRadius.circular(20),
                      ),

                      child: Text(
                        '${filtered.length} Students',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ==================================================
              // CONTENT
              // ==================================================

              Expanded(

                child: RefreshIndicator(

                  onRefresh: () async {

                    await Future.delayed(
                      const Duration(
                        milliseconds: 400,
                      ),
                    );

                    if (mounted) {
                      setState(() {});
                    }
                  },

                  child: ListView(

                    physics:
                    const AlwaysScrollableScrollPhysics(),

                    padding: const EdgeInsets.fromLTRB(
                      18,
                      5,
                      18,
                      30,
                    ),

                    children: [

                      // ==================================================
                      // SEARCH + FILTER
                      // ==================================================

                      StudentFilterBar(

                        searchController:
                        searchController,

                        selectedBranch:
                        selectedBranch,

                        selectedYear:
                        selectedYear,

                        selectedBus:
                        selectedBus,

                        onSearchChanged:
                            (value) {

                          setState(() {
                            searchText = value;
                          });
                        },

                        onBranchChanged:
                            (value) {

                          setState(() {
                            selectedBranch = value;
                          });
                        },

                        onYearChanged:
                            (value) {

                          setState(() {
                            selectedYear = value;
                          });
                        },

                        onBusChanged:
                            (value) {

                          setState(() {
                            selectedBus = value;
                          });
                        },
                      ),

                      const SizedBox(height: 20),

                      // ==================================================
                      // RESULTS
                      // ==================================================

                      if (filtered.isEmpty)

                        _emptyState()

                      else

                        ...filtered.map(
                              (student) {

                            return StudentProfileCard(

                              name:
                              student['name']!,

                              usn:
                              student['usn']!,

                              branch:
                              student['branch']!,

                              year:
                              student['year']!,

                              busNumber:
                              student['bus']!,

                              pickupStop:
                              student['stop']!,

                              seatNumber:
                              student['seat']!,

                              // ==========================================
                              // ONLY > BUTTON OPENS PROFILE
                              // ==========================================

                              onOpenProfile: () {

                                Navigator.push(
                                  context,

                                  MaterialPageRoute(
                                    builder: (_) =>
                                        StudentCompleteProfileScreen(
                                          student: student,
                                        ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // EMPTY STATE
  // ============================================================

  Widget _emptyState() {

    return Container(

      margin: const EdgeInsets.only(
        top: 40,
      ),

      padding: const EdgeInsets.all(30),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
        BorderRadius.circular(22),
      ),

      child: Column(
        children: [

          Icon(
            Icons.person_search_outlined,
            size: 60,
            color: Colors.grey.shade400,
          ),

          const SizedBox(height: 15),

          const Text(
            'No Students Found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 7),

          Text(
            'Try another name, USN, branch, year or bus.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}

// ================================================================
// COMPLETE STUDENT PROFILE SCREEN
// ================================================================

class StudentCompleteProfileScreen
    extends StatelessWidget {

  final Map<String, String> student;

  const StudentCompleteProfileScreen({
    super.key,
    required this.student,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          'Student Profile',
        ),
        centerTitle: true,
      ),

      body: Container(

        width: double.infinity,

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xffd1fae5),
              Color(0xffe0e7ff),
              Color(0xffcffafe),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child: SingleChildScrollView(

          padding: const EdgeInsets.all(18),

          child: Column(
            children: [

              // ==================================================
              // PROFILE HEADER
              // ==================================================

              Container(

                width: double.infinity,

                padding: const EdgeInsets.all(22),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                  BorderRadius.circular(24),
                ),

                child: Column(
                  children: [

                    CircleAvatar(
                      radius: 45,

                      backgroundColor:
                      const Color(0xffede9fe),

                      child: Text(
                        student['name']!
                            .substring(0, 1)
                            .toUpperCase(),

                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight:
                          FontWeight.bold,
                          color:
                          Colors.deepPurple,
                        ),
                      ),
                    ),

                    const SizedBox(height: 14),

                    Text(
                      student['name']!,
                      style: const TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      student['usn']!,
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 15),

              // ==================================================
              // PERSONAL INFORMATION
              // ==================================================

              _section(
                title: 'Personal Information',
                icon: Icons.person_outline,
                children: [

                  _detail(
                    'Full Name',
                    student['name']!,
                  ),

                  _detail(
                    'USN',
                    student['usn']!,
                  ),

                  _detail(
                    'Email',
                    student['email']!,
                  ),

                  _detail(
                    'Mobile',
                    student['mobile']!,
                  ),

                  _detail(
                    'Branch',
                    student['branch']!,
                  ),

                  _detail(
                    'Year',
                    student['year']!,
                  ),
                ],
              ),

              const SizedBox(height: 15),

              // ==================================================
              // TRANSPORT INFORMATION
              // ==================================================

              _section(
                title: 'Transport Information',
                icon: Icons.directions_bus_outlined,
                children: [

                  _detail(
                    'Bus',
                    student['bus']!,
                  ),

                  _detail(
                    'Route',
                    student['route']!,
                  ),

                  _detail(
                    'Pickup Stop',
                    student['stop']!,
                  ),

                  _detail(
                    'Seat Number',
                    student['seat']!,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _section({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {

    return Container(

      width: double.infinity,

      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
        BorderRadius.circular(22),
      ),

      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [

          Row(
            children: [

              Icon(
                icon,
                color: Colors.deepPurple,
              ),

              const SizedBox(width: 9),

              Text(
                title,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

          ...children,
        ],
      ),
    );
  }

  Widget _detail(
      String label,
      String value,
      ) {

    return Padding(

      padding: const EdgeInsets.only(
        bottom: 13,
      ),

      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [

          SizedBox(
            width: 105,

            child: Text(
              label,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 13,
              ),
            ),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
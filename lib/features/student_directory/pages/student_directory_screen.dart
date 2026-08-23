import 'package:flutter/material.dart';

import '../models/student_directory_model.dart';
import '../widgets/student_directory_card.dart';
import '../widgets/student_stop_section.dart';

class StudentDirectoryScreen extends StatefulWidget {
  final String role;

  const StudentDirectoryScreen({
    super.key,
    this.role = "student",
  });

  @override
  State<StudentDirectoryScreen> createState() =>
      _StudentDirectoryScreenState();
}

class _StudentDirectoryScreenState
    extends State<StudentDirectoryScreen> {

  // ==========================================================
  // FRONTEND DEMO DATA
  //
  // IMPORTANT:
  // This is temporary frontend data.
  //
  // Later this list must be populated from the existing
  // Registration / Student data.
  // ==========================================================

  final List<StudentDirectoryModel> allStudents = const [
    StudentDirectoryModel(
      name: "Mohammed Moinuddin",
      usn: "KUB24CSE118",
      year: "3rd Year",
      branch: "CSE",
      busNumber: "1",
      pickupStop: "Hospet",
      profilePhoto: null,
    ),

    StudentDirectoryModel(
      name: "Mansoor",
      usn: "KUB24CSE120",
      year: "3rd Year",
      branch: "CSE",
      busNumber: "1",
      pickupStop: "Hospet",
      profilePhoto: null,
    ),

    StudentDirectoryModel(
      name: "Rahul",
      usn: "KUB24ISE121",
      year: "3rd Year",
      branch: "ISE",
      busNumber: "1",
      pickupStop: "Hospet",
      profilePhoto: null,
    ),

    StudentDirectoryModel(
      name: "Chand",
      usn: "KUB25CSE201",
      year: "2nd Year",
      branch: "CSE",
      busNumber: "1",
      pickupStop: "Gangavathi",
      profilePhoto: null,
    ),

    StudentDirectoryModel(
      name: "Ayesha",
      usn: "KUB24ECE145",
      year: "3rd Year",
      branch: "ECE",
      busNumber: "1",
      pickupStop: "Gangavathi",
      profilePhoto: null,
    ),

    StudentDirectoryModel(
      name: "Arjun",
      usn: "KUB24CSE155",
      year: "3rd Year",
      branch: "CSE",
      busNumber: "1",
      pickupStop: "Koppal",
      profilePhoto: null,
    ),

    // ========================================================
    // BUS 2
    // ========================================================

    StudentDirectoryModel(
      name: "Ravi",
      usn: "KUB25ISE108",
      year: "2nd Year",
      branch: "ISE",
      busNumber: "2",
      pickupStop: "Hospet",
      profilePhoto: null,
    ),

    StudentDirectoryModel(
      name: "Sneha",
      usn: "KUB24CSE135",
      year: "3rd Year",
      branch: "CSE",
      busNumber: "2",
      pickupStop: "Koppal",
      profilePhoto: null,
    ),
  ];

  // ==========================================================
  // FRONTEND DEMO BUS
  //
  // Later this must come from Registration/Auth.
  // ==========================================================

  String get currentBusNumber {
    return "1";
  }

  // ==========================================================
  // ROLE
  // ==========================================================

  bool get isStudent {
    return widget.role.toLowerCase() == "student";
  }

  bool get isAdmin {
    return widget.role.toLowerCase() == "admin";
  }

  bool get isDriver {
    return widget.role.toLowerCase() == "driver";
  }

  bool get isAdminOrDriver {
    return isAdmin || isDriver;
  }

  // ==========================================================
  // SEARCH
  // ==========================================================

  String searchQuery = "";

  // ==========================================================
  // BUS FILTER
  // ==========================================================

  List<StudentDirectoryModel> get busStudents {
    return allStudents
        .where(
          (student) =>
      student.busNumber == currentBusNumber,
    )
        .toList();
  }

  // ==========================================================
  // SEARCH FILTER
  // ==========================================================

  List<StudentDirectoryModel> get filteredStudents {
    final query =
    searchQuery.trim().toLowerCase();

    if (query.isEmpty) {
      return busStudents;
    }

    return busStudents.where((student) {
      return student.name
          .toLowerCase()
          .contains(query) ||
          student.usn
              .toLowerCase()
              .contains(query) ||
          student.branch
              .toLowerCase()
              .contains(query) ||
          student.pickupStop
              .toLowerCase()
              .contains(query) ||
          student.year
              .toLowerCase()
              .contains(query);
    }).toList();
  }

  // ==========================================================
  // GROUP BY STOP
  // ==========================================================

  Map<String, List<StudentDirectoryModel>>
  get studentsByStop {

    final Map<
        String,
        List<StudentDirectoryModel>
    > grouped = {};

    for (final student in filteredStudents) {
      grouped.putIfAbsent(
        student.pickupStop,
            () => [],
      );

      grouped[student.pickupStop]!
          .add(student);
    }

    return grouped;
  }

  // ==========================================================
  // BUILD
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
      const Color(0xFFF6F8FC),

      appBar: AppBar(
        title: const Text(
          "Student Directory",

          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        centerTitle: true,

        elevation: 0,

        backgroundColor:
        Colors.transparent,

        foregroundColor:
        const Color(0xFF111827),
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

        child: SafeArea(
          top: false,

          child: Column(
            children: [
              // =================================================
              // HEADER
              // =================================================

              _buildHeader(),

              // =================================================
              // SEARCH
              //
              // Search is available for Admin/Driver only.
              // =================================================

              if (isAdminOrDriver)
                _buildSearchBar(),

              // =================================================
              // CONTENT
              // =================================================

              Expanded(
                child: filteredStudents.isEmpty
                    ? _buildEmptyState()
                    : isStudent
                    ? _buildStudentView()
                    : _buildAdminDriverView(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // HEADER
  // ==========================================================

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        16,
        8,
        16,
        12,
      ),

      child: Container(
        width: double.infinity,

        padding: const EdgeInsets.all(17),

        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFF7C3AED),
              Color(0xFF5B5FEF),
              Color(0xFF4F46E5),
            ],

            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),

          borderRadius:
          BorderRadius.circular(20),

          boxShadow: [
            BoxShadow(
              color: const Color(0xFF5B5FEF)
                  .withValues(alpha: 0.20),

              blurRadius: 12,

              offset: const Offset(0, 5),
            ),
          ],
        ),

        child: Row(
          children: [
            // ICON

            Container(
              width: 48,
              height: 48,

              decoration: BoxDecoration(
                color: Colors.white
                    .withValues(alpha: 0.18),

                shape: BoxShape.circle,
              ),

              child: const Icon(
                Icons.groups_rounded,
                color: Colors.white,
                size: 26,
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [
                  const Text(
                    "Student Directory",

                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 3),

                  Text(
                    isStudent
                        ? "Students in your bus"
                        : "Students grouped by pickup stop",

                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 11,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Row(
                    children: [
                      const Icon(
                        Icons
                            .directions_bus_rounded,
                        color: Colors.white,
                        size: 14,
                      ),

                      const SizedBox(width: 5),

                      Text(
                        "Bus No: $currentBusNumber",

                        style:
                        const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight:
                          FontWeight.w600,
                        ),
                      ),

                      const SizedBox(width: 10),

                      Container(
                        padding:
                        const EdgeInsets
                            .symmetric(
                          horizontal: 7,
                          vertical: 3,
                        ),

                        decoration:
                        BoxDecoration(
                          color: Colors.white
                              .withValues(
                            alpha: 0.16,
                          ),

                          borderRadius:
                          BorderRadius
                              .circular(
                            20,
                          ),
                        ),

                        child: Text(
                          "${busStudents.length} Students",

                          style:
                          const TextStyle(
                            color:
                            Colors.white,
                            fontSize: 9.5,
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // SEARCH BAR
  // ==========================================================

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        16,
        0,
        16,
        12,
      ),

      child: TextField(
        onChanged: (value) {
          setState(() {
            searchQuery = value;
          });
        },

        style: const TextStyle(
          color: Color(0xFF111827),
          fontSize: 13,
        ),

        decoration: InputDecoration(
          hintText:
          "Search name, USN, stop or branch",

          hintStyle: const TextStyle(
            color: Color(0xFF9CA3AF),
            fontSize: 12,
          ),

          prefixIcon: const Icon(
            Icons.search_rounded,
            color: Color(0xFF5B5FEF),
          ),

          suffixIcon:
          searchQuery.isNotEmpty
              ? IconButton(
            onPressed: () {
              setState(() {
                searchQuery = "";
              });
            },

            icon: const Icon(
              Icons.clear_rounded,
            ),
          )
              : null,

          filled: true,

          fillColor: Colors.white,

          contentPadding:
          const EdgeInsets.symmetric(
            vertical: 14,
          ),

          border: OutlineInputBorder(
            borderRadius:
            BorderRadius.circular(15),

            borderSide: const BorderSide(
              color: Color(0xFFE5E7EB),
            ),
          ),

          enabledBorder:
          OutlineInputBorder(
            borderRadius:
            BorderRadius.circular(15),

            borderSide: const BorderSide(
              color: Color(0xFFE5E7EB),
            ),
          ),

          focusedBorder:
          OutlineInputBorder(
            borderRadius:
            BorderRadius.circular(15),

            borderSide: const BorderSide(
              color: Color(0xFF5B5FEF),
              width: 1.5,
            ),
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // STUDENT VIEW
  //
  // NO PROFILE PHOTOS
  // NO BRANCH
  // NO STOP
  //
  // Only:
  // Name + USN + Year
  // ==========================================================

  Widget _buildStudentView() {
    return ListView(
      physics:
      const BouncingScrollPhysics(),

      padding: const EdgeInsets.fromLTRB(
        16,
        0,
        16,
        25,
      ),

      children: [
        _buildSectionTitle(
          "Students in Bus $currentBusNumber",
          Icons.groups_rounded,
        ),

        const SizedBox(height: 10),

        ...filteredStudents.map(
              (student) => StudentDirectoryCard(
            student: student,

            // Student must NOT see photo.
            showProfilePhoto: false,
          ),
        ),
      ],
    );
  }

  // ==========================================================
  // ADMIN / DRIVER VIEW
  //
  // PROFILE PHOTOS ENABLED
  // GROUPED BY STOP
  // ==========================================================

  Widget _buildAdminDriverView() {
    final groups = studentsByStop;

    return ListView(
      physics:
      const BouncingScrollPhysics(),

      padding: const EdgeInsets.fromLTRB(
        16,
        0,
        16,
        25,
      ),

      children: [
        _buildSectionTitle(
          isAdmin
              ? "Students by Pickup Stop"
              : "Bus Students by Pickup Stop",

          Icons.location_on_rounded,
        ),

        const SizedBox(height: 10),

        ...groups.entries.map(
              (entry) => StudentStopSection(
            stopName: entry.key,

            students: entry.value,
          ),
        ),
      ],
    );
  }

  // ==========================================================
  // SECTION TITLE
  // ==========================================================

  Widget _buildSectionTitle(
      String title,
      IconData icon,
      ) {
    return Row(
      children: [
        Icon(
          icon,

          color:
          const Color(0xFF5B5FEF),

          size: 21,
        ),

        const SizedBox(width: 8),

        Expanded(
          child: Text(
            title,

            style: const TextStyle(
              color: Color(0xFF111827),
              fontSize: 15,
              fontWeight:
              FontWeight.bold,
            ),
          ),
        ),

        Text(
          "${filteredStudents.length}",

          style: const TextStyle(
            color: Color(0xFF5B5FEF),
            fontSize: 13,
            fontWeight:
            FontWeight.bold,
          ),
        ),
      ],
    );
  }

  // ==========================================================
  // EMPTY STATE
  // ==========================================================

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding:
        const EdgeInsets.all(30),

        child: Column(
          mainAxisAlignment:
          MainAxisAlignment.center,

          children: [
            Container(
              width: 82,
              height: 82,

              decoration:
              const BoxDecoration(
                color: Color(0xFFEDE9FE),
                shape: BoxShape.circle,
              ),

              child: const Icon(
                Icons
                    .people_outline_rounded,

                color:
                Color(0xFF7C3AED),

                size: 42,
              ),
            ),

            const SizedBox(height: 16),

            Text(
              searchQuery.isNotEmpty
                  ? "No students found"
                  : "No students found for this bus.",

              textAlign:
              TextAlign.center,

              style: const TextStyle(
                color: Color(0xFF111827),
                fontSize: 17,
                fontWeight:
                FontWeight.bold,
              ),
            ),

            const SizedBox(height: 7),

            Text(
              searchQuery.isNotEmpty
                  ? "Try searching with another name, USN, stop or branch."
                  : "Registered students for this bus will appear here.",

              textAlign:
              TextAlign.center,

              style: const TextStyle(
                color: Color(0xFF6B7280),
                fontSize: 12,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
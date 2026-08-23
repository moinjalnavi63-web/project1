import 'package:flutter/material.dart';

class DriverAssignedRouteScreen extends StatelessWidget {
  const DriverAssignedRouteScreen({super.key});

  // ============================================================
  // SEAT DATA
  // ============================================================

  final List<Map<String, String>> passengers = const [
    {
      "seat": "1A",
      "name": "Moinuddin",
      "type": "Student",
      "id": "KUB24CSE118",
    },
    {
      "seat": "1B",
      "name": "Rahul Kumar",
      "type": "Student",
      "id": "KUB25ECE101",
    },
    {
      "seat": "1C",
      "name": "Dr. Ramesh",
      "type": "Faculty",
      "id": "FAC001",
    },
    {
      "seat": "2A",
      "name": "Mohammed Mansoor",
      "type": "Student",
      "id": "KUB24CSE119",
    },
    {
      "seat": "2B",
      "name": "Anjali",
      "type": "Student",
      "id": "KUB25ISE104",
    },
    {
      "seat": "2C",
      "name": "Dr. Priya",
      "type": "Faculty",
      "id": "FAC002",
    },
    {
      "seat": "3A",
      "name": "Arun Kumar",
      "type": "Student",
      "id": "KUB26AIML110",
    },
    {
      "seat": "3B",
      "name": "Sneha",
      "type": "Student",
      "id": "KUB25CSE120",
    },
  ];

  @override
  Widget build(BuildContext context) {
    const int totalSeats = 60;

    final int occupiedSeats = passengers.length;

    final int remainingSeats =
        totalSeats - occupiedSeats;

    // ============================================================
    // SEPARATE FACULTY AND STUDENTS
    // ============================================================

    final faculty = passengers
        .where(
          (passenger) =>
      passenger["type"] == "Faculty",
    )
        .toList();

    final students = passengers
        .where(
          (passenger) =>
      passenger["type"] == "Student",
    )
        .toList();

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

              // ==================================================
              // ROUTE CARD
              // ==================================================

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF5B5FEF),
                      Color(0xFF7C83FD),
                    ],
                  ),
                  borderRadius:
                  BorderRadius.circular(24),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.route_rounded,
                      color: Colors.white,
                      size: 42,
                    ),

                    SizedBox(width: 15),

                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Assigned Route",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),

                          SizedBox(height: 4),

                          Text(
                            "Hospet Route",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight:
                              FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),

                          SizedBox(height: 4),

                          Text(
                            "Bus 01",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 22),

              // ==================================================
              // SEAT STATISTICS
              // ==================================================

              Row(
                children: [
                  Expanded(
                    child: _statCard(
                      icon: Icons.event_seat,
                      title: "Total Seats",
                      value:
                      totalSeats.toString(),
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: _statCard(
                      icon: Icons.person,
                      title: "Occupied",
                      value:
                      occupiedSeats.toString(),
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: _statCard(
                      icon:
                      Icons.event_seat_outlined,
                      title: "Remaining",
                      value:
                      remainingSeats.toString(),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              const Text(
                "Seat Allocation",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 18),

              // ==================================================
              // FACULTY SECTION
              // ==================================================

              _sectionHeader(
                title: "Faculty",
                count: faculty.length,
                icon: Icons.badge_outlined,
                color: Colors.orange,
              ),

              const SizedBox(height: 12),

              if (faculty.isEmpty)
                _emptySection(
                  "No faculty members assigned",
                )
              else
                ...faculty.map(
                      (passenger) =>
                      _passengerCard(passenger),
                ),

              const SizedBox(height: 28),

              // ==================================================
              // STUDENT SECTION
              // ==================================================

              _sectionHeader(
                title: "Students",
                count: students.length,
                icon: Icons.school_outlined,
                color: const Color(0xFF5B5FEF),
              ),

              const SizedBox(height: 12),

              if (students.isEmpty)
                _emptySection(
                  "No students assigned",
                )
              else
                ...students.map(
                      (passenger) =>
                      _passengerCard(passenger),
                ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SECTION HEADER
  // ============================================================

  Widget _sectionHeader({
    required String title,
    required int count,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withValues(
          alpha: 0.95,
        ),
        borderRadius:
        BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: color.withValues(
                alpha: 0.12,
              ),
              borderRadius:
              BorderRadius.circular(13),
            ),
            child: Icon(
              icon,
              color: color,
              size: 25,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          Container(
            padding:
            const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: color.withValues(
                alpha: 0.10,
              ),
              borderRadius:
              BorderRadius.circular(20),
            ),
            child: Text(
              "$count",
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // PASSENGER CARD
  // ============================================================

  Widget _passengerCard(
      Map<String, String> passenger,
      ) {
    final bool isFaculty =
        passenger["type"] == "Faculty";

    final Color primaryColor = isFaculty
        ? Colors.orange
        : const Color(0xFF5B5FEF);

    return Container(
      margin:
      const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white.withValues(
          alpha: 0.95,
        ),
        borderRadius:
        BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: 0.06,
            ),
            blurRadius: 10,
            offset:
            const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [

          // ==================================================
          // SEAT NUMBER
          // ==================================================

          Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(
              color: primaryColor.withValues(
                alpha: 0.12,
              ),
              borderRadius:
              BorderRadius.circular(15),
            ),
            child: Center(
              child: Text(
                passenger["seat"]!,
                style: TextStyle(
                  fontWeight:
                  FontWeight.bold,
                  fontSize: 18,
                  color: primaryColor,
                ),
              ),
            ),
          ),

          const SizedBox(width: 14),

          // ==================================================
          // NAME / ID
          // ==================================================

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [

                Text(
                  passenger["name"]!,
                  style: const TextStyle(
                    fontWeight:
                    FontWeight.bold,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  passenger["id"]!,
                  style: TextStyle(
                    color:
                    Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),

                const SizedBox(height: 6),

                Container(
                  padding:
                  const EdgeInsets
                      .symmetric(
                    horizontal: 9,
                    vertical: 4,
                  ),
                  decoration:
                  BoxDecoration(
                    color: primaryColor
                        .withValues(
                      alpha: 0.10,
                    ),
                    borderRadius:
                    BorderRadius.circular(
                      10,
                    ),
                  ),
                  child: Text(
                    passenger["type"]!,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight:
                      FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ==================================================
          // OCCUPIED
          // ==================================================

          const Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 24,
          ),
        ],
      ),
    );
  }

  // ============================================================
  // EMPTY SECTION
  // ============================================================

  Widget _emptySection(String message) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(
          alpha: 0.90,
        ),
        borderRadius:
        BorderRadius.circular(18),
      ),
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.grey.shade600,
          fontSize: 13,
        ),
      ),
    );
  }

  // ============================================================
  // STAT CARD
  // ============================================================

  Widget _statCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      padding:
      const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 8,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withValues(
          alpha: 0.95,
        ),
        borderRadius:
        BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color:
            const Color(0xFF5B5FEF),
            size: 26,
          ),

          const SizedBox(height: 7),

          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight:
              FontWeight.bold,
            ),
          ),

          const SizedBox(height: 3),

          Text(
            title,
            textAlign:
            TextAlign.center,
            style: TextStyle(
              color:
              Colors.grey.shade600,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}
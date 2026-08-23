import 'package:flutter/material.dart';

import '../data/demo_seats.dart';
import '../models/seat_model.dart';

import '../widgets/bus_info_card.dart';
import '../widgets/legend_card.dart';
import '../widgets/seat_statistics.dart';
import '../widgets/attendance_confirmation_card.dart';
import '../widgets/seat_allocation_status_card.dart';
import '../buddy_system/pages/buddy_system_screen.dart';
import '../widgets/last_row_seats_button.dart';
import 'seat_layout_screen.dart';

class SeatAllocatorScreen extends StatefulWidget {
  const SeatAllocatorScreen({super.key});

  @override
  State<SeatAllocatorScreen> createState() =>
      _SeatAllocatorScreenState();
}

class _SeatAllocatorScreenState
    extends State<SeatAllocatorScreen> {
  // null = user has not answered attendance yet
  bool? comingToday;

  // Always keep this as a non-null String.
  String allocatedSeat = "";

  // ==========================================================
  // BUS / TRIP INFORMATION
  // ==========================================================

  // Currently using Bus 1 because your existing screen
  // displays Bus Number 1.
  final String busId = "1";

  String get tripDate {
    final now = DateTime.now();

    return '${now.year}-'
        '${now.month.toString().padLeft(2, '0')}-'
        '${now.day.toString().padLeft(2, '0')}';
  }

  // ==========================================================
  // ATTENDANCE
  // ==========================================================

  void markAttendance(bool value) {
    setState(() {
      comingToday = value;

      if (value == true) {
        // Find a student seat.
        // Faculty seats are NEVER allocated to students.
        final studentSeat = demoSeats.firstWhere(
              (seat) =>
          seat.zone == SeatZone.girls ||
              seat.zone == SeatZone.boys,
          orElse: () => demoSeats.first,
        );

        allocatedSeat = studentSeat.seatId;
      } else {
        // User is not coming.
        allocatedSeat = "";
      }
    });
  }

  // ==========================================================
  // OPEN BUDDY SYSTEM
  // ==========================================================

  void openBuddySystem() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const BuddySystemScreen(),
      ),
    );
  }

  // ==========================================================
  // VIEW
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    const int totalSeats = 60;
    const int facultySeats = 8;
    const int girlsSeats = 25;
    const int boysSeats = 27;

    // Number of seats currently present in demo data.
    final int occupiedSeats = demoSeats.length;

    final int availableSeats =
        totalSeats - occupiedSeats;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FC),

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
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),

            child: Column(
              children: [
                // =================================================
                // BUS INFORMATION
                // =================================================

                BusInfoCard(
                  busNumber: "1",
                  routeName: "Hospet → KUTS",
                  totalSeats: totalSeats,
                  facultySeats: facultySeats,
                  girlsSeats: girlsSeats,
                  boysSeats: boysSeats,
                ),

                // =================================================
                // SEAT STATISTICS
                // =================================================

                SeatStatistics(
                  occupiedSeats: occupiedSeats,
                  availableSeats: availableSeats,
                ),

                const SizedBox(height: 15),

                // =================================================
                // LEGEND
                // =================================================

                const LegendCard(),

                const SizedBox(height: 15),

                // =================================================
                // ATTENDANCE
                // =================================================

                AttendanceConfirmationCard(
                  onYes: () {
                    markAttendance(true);
                  },
                  onNo: () {
                    markAttendance(false);
                  },
                ),

                const SizedBox(height: 16),

                // =================================================
                // BUDDY SYSTEM + LAST ROW SEATS
                // =================================================

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Row(
                    children: [
                      // =================================================
                      // BUDDY SYSTEM BUTTON
                      // =================================================

                      Expanded(
                        child: SizedBox(
                          height: 55,
                          child: ElevatedButton.icon(
                            icon: const Text(
                              "🤝",
                              style: TextStyle(
                                fontSize: 21,
                              ),
                            ),

                            label: const Text(
                              "Buddy System",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                              const Color(0xFF7C3AED),
                              foregroundColor: Colors.white,
                              elevation: 3,
                              padding:
                              const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              shape:
                              RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(15),
                              ),
                            ),

                            onPressed: openBuddySystem,
                          ),
                        ),
                      ),

                      const SizedBox(width: 12),

                      // =================================================
                      // LAST ROW SEATS BUTTON
                      // =================================================

                      Expanded(
                        child: SizedBox(
                          height: 55,
                          child: LastRowSeatsButton(
                            busId: busId,
                            tripDate: tripDate,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // =================================================
                // ALLOCATION STATUS
                // =================================================

                SeatAllocationStatusCard(
                  comingToday: comingToday,

                  // Never pass null.
                  seatNumber: allocatedSeat,
                ),

                const SizedBox(height: 20),

                // =================================================
                // VIEW ALL SEATS
                // =================================================

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton.icon(
                      icon: const Icon(
                        Icons.event_seat,
                      ),

                      label: const Text(
                        "View All Seats",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                        const Color(0xFF5B5FEF),

                        foregroundColor: Colors.white,

                        disabledBackgroundColor:
                        const Color(0xFFB9BCEB),

                        disabledForegroundColor:
                        Colors.white70,

                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(15),
                        ),
                      ),

                      // Button works only after YES.
                      onPressed:
                      comingToday == true &&
                          allocatedSeat.isNotEmpty
                          ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                SeatLayoutScreen(
                                  allocatedSeat:
                                  allocatedSeat,
                                ),
                          ),
                        );
                      }
                          : null,
                    ),
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // BUDDY SYSTEM CARD
  // ==========================================================

  Widget _buildBuddySystemCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: .95),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: const Color(0xFFE0E7FF),
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .07),
              blurRadius: 12,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            // ==================================================
            // TITLE
            // ==================================================

            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF5B5FEF),
                        Color(0xFF7C83FD),
                      ],
                    ),
                    borderRadius:
                    BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF5B5FEF)
                            .withValues(alpha: .20),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.people_alt_rounded,
                    color: Colors.white,
                    size: 26,
                  ),
                ),
                const SizedBox(width: 13),
                const Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Text(
                        "🤝 Buddy System",
                        style: TextStyle(
                          color: Color(0xFF111827),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Sit together with your friends",
                        style: TextStyle(
                          color: Color(0xFF4B5563),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            // ==================================================
            // DESCRIPTION
            // ==================================================

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(13),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F3FF),
                borderRadius:
                BorderRadius.circular(14),
              ),
              child: const Row(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    color: Color(0xFF5B5FEF),
                    size: 20,
                  ),
                  SizedBox(width: 9),
                  Expanded(
                    child: Text(
                      "Create or join a group with 1 or 2 friends "
                          "and try to get seats together.",
                      style: TextStyle(
                        color: Color(0xFF374151),
                        fontSize: 12,
                        height: 1.4,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            // ==================================================
            // OPEN BUTTON
            // ==================================================

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: openBuddySystem,
                icon: const Icon(
                  Icons.arrow_forward_rounded,
                  size: 21,
                ),
                label: const Text(
                  "Open Buddy System",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                  const Color(0xFF5B5FEF),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(14),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

import '../../../seat_allocator/data/demo_seats.dart';
import '../../../seat_allocator/models/seat_model.dart';

import '../../../seat_allocator/widgets/bus_info_card.dart';
import '../../../seat_allocator/widgets/legend_card.dart';
import '../../../seat_allocator/widgets/seat_statistics.dart';
import '../../../seat_allocator/widgets/last_row_seats_button.dart';

import '../../../seat_allocator/buddy_system/pages/buddy_system_screen.dart';
import '../../../seat_allocator/pages/seat_layout_screen.dart';

class FacultySeatAllocatorScreen extends StatefulWidget {
  const FacultySeatAllocatorScreen({super.key});

  @override
  State<FacultySeatAllocatorScreen> createState() =>
      _FacultySeatAllocatorScreenState();
}

class _FacultySeatAllocatorScreenState
    extends State<FacultySeatAllocatorScreen> {

  // ==========================================================
  // BUS INFORMATION
  // ==========================================================

  final String busId = "1";

  String get tripDate {
    final now = DateTime.now();

    return '${now.year}-'
        '${now.month.toString().padLeft(2, '0')}-'
        '${now.day.toString().padLeft(2, '0')}';
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
  // VIEW ALL SEATS
  // ==========================================================

  void openSeatLayout() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const SeatLayoutScreen(
          allocatedSeat: "",
        ),
      ),
    );
  }

  // ==========================================================
  // BUILD
  // ==========================================================

  @override
  Widget build(BuildContext context) {

    const int totalSeats = 60;
    const int facultySeats = 8;
    const int girlsSeats = 25;
    const int boysSeats = 27;

    // Existing demo seat data.
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

                const SizedBox(height: 20),

                // =================================================
                // FACULTY INFORMATION
                // =================================================

                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  padding: const EdgeInsets.all(18),

                  decoration: BoxDecoration(
                    color: Colors.white.withValues(
                      alpha: .95,
                    ),
                    borderRadius:
                    BorderRadius.circular(20),

                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(
                          alpha: .07,
                        ),
                        blurRadius: 12,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),

                  child: const Row(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,

                    children: [

                      Icon(
                        Icons.info_outline,
                        color: Color(0xFF5B5FEF),
                        size: 26,
                      ),

                      SizedBox(width: 12),

                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,

                          children: [

                            Text(
                              "Faculty Seat Access",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight:
                                FontWeight.bold,
                                color:
                                Color(0xFF111827),
                              ),
                            ),

                            SizedBox(height: 6),

                            Text(
                              "Faculty can view the bus seat "
                                  "allocation directly. Attendance "
                                  "confirmation is not required.",
                              style: TextStyle(
                                fontSize: 13,
                                height: 1.4,
                                color:
                                Color(0xFF4B5563),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),



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
                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),

                      style:
                      ElevatedButton.styleFrom(
                        backgroundColor:
                        const Color(
                          0xFF5B5FEF,
                        ),

                        foregroundColor:
                        Colors.white,

                        shape:
                        RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(
                            15,
                          ),
                        ),
                      ),

                      onPressed:
                      openSeatLayout,
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
}
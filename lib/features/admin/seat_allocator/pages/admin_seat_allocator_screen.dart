import 'package:flutter/material.dart';

import '../pages/admin_bus_seat_layout_screen.dart';

class AdminSeatAllocatorScreen extends StatelessWidget {
  const AdminSeatAllocatorScreen({super.key});

// ============================================================
// 24 BUSES
// ============================================================

  List get buses {
    return List.generate(
      24,
          (index) => 'Bus ${index + 1}',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff4f6fb),

      // ========================================================
      // APP BAR
      // ========================================================

      appBar: AppBar(
        title: const Text(
          'Seat Allocator',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff5B5FEF),
        foregroundColor: Colors.white,
        elevation: 0,
      ),

      // ========================================================
      // BODY
      // ========================================================

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
                  20,
                  20,
                  20,
                  10,
                ),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Bus Seat Management',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      'Select a bus to view its complete seat allocation.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // ==================================================
              // BUS LIST
              // ==================================================

              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.fromLTRB(
                    18,
                    10,
                    18,
                    30,
                  ),

                  itemCount: buses.length,

                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,

                    crossAxisSpacing: 14,

                    mainAxisSpacing: 14,

                    // IMPORTANT:
                    // Explicit card height prevents the
                    // RenderFlex overflow.
                    mainAxisExtent: 145,
                  ),

                  itemBuilder: (
                      context,
                      index,
                      ) {
                    final String busNumber =
                    buses[index];

                    return _busCard(
                      context,
                      busNumber,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

// ============================================================
// BUS CARD
// ============================================================

  Widget _busCard(
      BuildContext context,
      String busNumber,
      ) {
    return Material(
      color: Colors.transparent,

      child: Container(
        width: double.infinity,

        decoration: BoxDecoration(
          color: Colors.white.withValues(
            alpha: 0.94,
          ),

          borderRadius:
          BorderRadius.circular(22),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(
                alpha: 0.08,
              ),
              blurRadius: 15,
              offset: const Offset(
                0,
                7,
              ),
            ),
          ],
        ),

        padding: const EdgeInsets.all(14),

        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [
            // ==================================================
            // ICON
            // ==================================================

            Container(
              width: 44,
              height: 44,

              decoration: BoxDecoration(
                color: const Color(
                  0xff6366f1,
                ).withValues(
                  alpha: 0.12,
                ),

                borderRadius:
                BorderRadius.circular(14),
              ),

              child: const Icon(
                Icons.directions_bus_rounded,
                color: Color(0xff5B5FEF),
                size: 26,
              ),
            ),

            const SizedBox(height: 8),

            // ==================================================
            // BUS NUMBER
            // ==================================================

            Text(
              busNumber,

              maxLines: 1,

              overflow:
              TextOverflow.ellipsis,

              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Color(0xff111827),
                height: 1.0,
              ),
            ),

            const Spacer(),

            // ==================================================
            // VIEW SEAT LAYOUT
            // ==================================================

            Row(
              children: [
                Expanded(
                  child: Text(
                    'View seat layout',

                    maxLines: 1,

                    overflow:
                    TextOverflow.ellipsis,

                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey.shade600,
                      height: 1.0,
                    ),
                  ),
                ),

                const SizedBox(width: 6),

                // ==================================================
                // ONLY > BUTTON IS CLICKABLE
                // ==================================================

                Material(
                  color: Colors.transparent,

                  child: InkWell(
                    borderRadius:
                    BorderRadius.circular(10),

                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              AdminBusSeatLayoutScreen(
                                busNumber: busNumber,
                              ),
                        ),
                      );
                    },

                    child: Container(
                      width: 30,
                      height: 30,

                      alignment:
                      Alignment.center,

                      decoration: BoxDecoration(
                        color: const Color(
                          0xff6366f1,
                        ).withValues(
                          alpha: 0.10,
                        ),

                        borderRadius:
                        BorderRadius.circular(10),
                      ),

                      child: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 13,
                        color: Color(0xff5B5FEF),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
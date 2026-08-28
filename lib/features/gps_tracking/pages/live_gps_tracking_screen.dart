import 'package:flutter/material.dart';

class LiveGpsTrackingScreen extends StatefulWidget {
  const LiveGpsTrackingScreen({
    super.key,
  });

  @override
  State<LiveGpsTrackingScreen> createState() =>
      _LiveGpsTrackingScreenState();
}

class _LiveGpsTrackingScreenState
    extends State<LiveGpsTrackingScreen> {

  String selectedBus = "Bus 1";

  final List<String> buses = const [
    "Bus 1",
    "Bus 2",
    "Bus 3",
    "Bus 4",
    "Bus 5",
    "Bus 6",
    "Bus 7",
    "Bus 8",
    "Bus 9",
    "Bus 10",
    "Bus 11",
    "Bus 12",
    "Bus 13",
    "Bus 14",
    "Bus 15",
    "Bus 16",
    "Bus 17",
    "Bus 18",
    "Bus 19",
    "Bus 20",
    "Bus 21",
    "Bus 22",
    "Bus 23",
    "Bus 24",
  ];

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // ============================================
              // TITLE
              // ============================================

              const Text(
                "Live GPS Tracking",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF111827),
                ),
              ),

              const SizedBox(height: 6),

              const Text(
                "Track your university bus location",
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF4B5563),
                ),
              ),

              const SizedBox(height: 20),

              // ============================================
              // BUS SELECTION
              // ============================================

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.95),
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.07),
                      blurRadius: 12,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [

                    const Row(
                      children: [
                        Icon(
                          Icons.directions_bus,
                          color: Color(0xFF5B5FEF),
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Select Bus",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    DropdownButtonFormField<String>(
                      initialValue: selectedBus,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(12),
                        ),
                        contentPadding:
                        const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 14,
                        ),
                      ),
                      items: buses.map((bus) {
                        return DropdownMenuItem<String>(
                          value: bus,
                          child: Text(bus),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value == null) return;

                        setState(() {
                          selectedBus = value;
                        });
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // ============================================
              // GPS STATUS
              // ============================================

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.95),
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.07),
                      blurRadius: 12,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [

                    Row(
                      children: [

                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: Colors.green
                                .withValues(alpha: 0.12),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.location_on,
                            color: Colors.green,
                            size: 28,
                          ),
                        ),

                        const SizedBox(width: 14),

                        const Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                "GPS Status",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight:
                                  FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "Waiting for live location...",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Container(
                          padding:
                          const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.orange
                                .withValues(alpha: 0.12),
                            borderRadius:
                            BorderRadius.circular(20),
                          ),
                          child: const Text(
                            "OFFLINE",
                            style: TextStyle(
                              color: Colors.orange,
                              fontSize: 11,
                              fontWeight:
                              FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    // ======================================
                    // MAP PLACEHOLDER
                    // ======================================

                    Container(
                      width: double.infinity,
                      height: 300,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE5E7EB),
                        borderRadius:
                        BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xFFD1D5DB),
                        ),
                      ),
                      child: const Column(
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: [

                          Icon(
                            Icons.map_outlined,
                            size: 65,
                            color: Color(0xFF6B7280),
                          ),

                          SizedBox(height: 12),

                          Text(
                            "Live Map",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight:
                              FontWeight.bold,
                              color: Color(0xFF374151),
                            ),
                          ),

                          SizedBox(height: 6),

                          Text(
                            "GPS location will appear here",
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0xFF6B7280),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // ============================================
              // BUS INFORMATION
              // ============================================

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.95),
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.07),
                      blurRadius: 12,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [

                    Text(
                      selectedBus,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 15),

                    _infoRow(
                      Icons.location_on_outlined,
                      "Current Location",
                      "Not available",
                    ),

                    const Divider(height: 25),

                    _infoRow(
                      Icons.speed_outlined,
                      "Speed",
                      "0 km/h",
                    ),

                    const Divider(height: 25),

                    _infoRow(
                      Icons.access_time,
                      "Last Updated",
                      "Not available",
                    ),

                    const Divider(height: 25),

                    _infoRow(
                      Icons.route_outlined,
                      "Route",
                      "Hospet → University",
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoRow(
      IconData icon,
      String title,
      String value,
      ) {
    return Row(
      children: [

        Icon(
          icon,
          color: const Color(0xFF5B5FEF),
          size: 24,
        ),

        const SizedBox(width: 12),

        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF6B7280),
            ),
          ),
        ),

        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xFF111827),
          ),
        ),
      ],
    );
  }
}
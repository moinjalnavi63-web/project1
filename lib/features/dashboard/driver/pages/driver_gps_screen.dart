import 'package:flutter/material.dart';

class DriverGpsScreen extends StatefulWidget {
  const DriverGpsScreen({super.key});

  @override
  State<DriverGpsScreen> createState() => _DriverGpsScreenState();
}

class _DriverGpsScreenState extends State<DriverGpsScreen> {
  bool isSharing = false;

  // ==========================================================
  // DRIVER ASSIGNED BUS
  // ==========================================================

  final String busNumber = "Bus 1";
  final String driverId = "DR001";
  final String routeName = "Hospet → KUTS";

  // Frontend demo coordinates.
  // Real GPS coordinates will come from the GPS/backend later.
  double latitude = 15.2689;
  double longitude = 76.3909;

  // ==========================================================
  // START GPS SHARING
  // ==========================================================

  void startGpsSharing() {
    setState(() {
      isSharing = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "GPS sharing started",
        ),
        duration: Duration(seconds: 2),
      ),
    );
  }

  // ==========================================================
  // STOP GPS SHARING
  // ==========================================================

  void stopGpsSharing() {
    setState(() {
      isSharing = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "GPS sharing stopped",
        ),
        duration: Duration(seconds: 2),
      ),
    );
  }

  // ==========================================================
  // BUILD
  // ==========================================================

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
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ==================================================
              // PAGE TITLE
              // ==================================================

              const Text(
                "Live GPS Sharing",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF111827),
                ),
              ),

              const SizedBox(height: 6),

              const Text(
                "Share your assigned bus location with students and admin.",
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF4B5563),
                ),
              ),

              const SizedBox(height: 20),

              // ==================================================
              // GPS STATUS CARD
              // ==================================================

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.95),
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 15,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // GPS ICON
                    Container(
                      width: 75,
                      height: 75,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isSharing
                            ? const Color(0xFFDCFCE7)
                            : const Color(0xFFF3F4F6),
                      ),
                      child: Icon(
                        Icons.location_on,
                        size: 42,
                        color: isSharing
                            ? const Color(0xFF16A34A)
                            : const Color(0xFF6B7280),
                      ),
                    ),

                    const SizedBox(height: 15),

                    Text(
                      isSharing
                          ? "GPS Sharing Active"
                          : "GPS Sharing Inactive",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: isSharing
                            ? const Color(0xFF16A34A)
                            : const Color(0xFF374151),
                      ),
                    ),

                    const SizedBox(height: 7),

                    Text(
                      isSharing
                          ? "Your bus location is being shared."
                          : "Start sharing to send your bus location.",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // ==================================================
              // ASSIGNED BUS CARD
              // ==================================================

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.95),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.07),
                      blurRadius: 12,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.directions_bus,
                          color: Color(0xFF5B5FEF),
                          size: 25,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Assigned Bus",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    _infoRow(
                      Icons.directions_bus_outlined,
                      "Bus Number",
                      busNumber,
                    ),

                    const SizedBox(height: 12),

                    _infoRow(
                      Icons.badge_outlined,
                      "Driver ID",
                      driverId,
                    ),

                    const SizedBox(height: 12),

                    _infoRow(
                      Icons.route_outlined,
                      "Route",
                      routeName,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // ==================================================
              // CURRENT LOCATION CARD
              // ==================================================

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.95),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.07),
                      blurRadius: 12,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.my_location,
                          color: Color(0xFF5B5FEF),
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Current Location",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F3FF),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Column(
                        children: [
                          _locationRow(
                            "Latitude",
                            latitude.toStringAsFixed(6),
                          ),
                          const SizedBox(height: 10),
                          _locationRow(
                            "Longitude",
                            longitude.toStringAsFixed(6),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),

                    const Text(
                      "Demo location. Real device GPS will be connected later.",
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ==================================================
              // START / STOP BUTTON
              // ==================================================

              SizedBox(
                width: double.infinity,
                height: 58,
                child: ElevatedButton.icon(
                  onPressed: isSharing
                      ? stopGpsSharing
                      : startGpsSharing,
                  icon: Icon(
                    isSharing
                        ? Icons.stop_circle_outlined
                        : Icons.location_on_outlined,
                  ),
                  label: Text(
                    isSharing
                        ? "Stop GPS Sharing"
                        : "Start GPS Sharing",
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isSharing
                        ? const Color(0xFFDC2626)
                        : const Color(0xFF5B5FEF),
                    foregroundColor: Colors.white,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // ==================================================
              // INFORMATION
              // ==================================================

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.90),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: Color(0xFF5B5FEF),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        "When GPS sharing is active, the driver's bus "
                            "location will be available for tracking. "
                            "The actual GPS service and backend connection "
                            "will be added in the next stage.",
                        style: TextStyle(
                          fontSize: 13,
                          height: 1.5,
                          color: Color(0xFF374151),
                        ),
                      ),
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

  // ==========================================================
  // INFORMATION ROW
  // ==========================================================

  Widget _infoRow(
      IconData icon,
      String title,
      String value,
      ) {
    return Row(
      children: [
        Icon(
          icon,
          color: const Color(0xFF6B7280),
          size: 21,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 13,
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

  // ==========================================================
  // LOCATION ROW
  // ==========================================================

  Widget _locationRow(
      String title,
      String value,
      ) {
    return Row(
      children: [
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
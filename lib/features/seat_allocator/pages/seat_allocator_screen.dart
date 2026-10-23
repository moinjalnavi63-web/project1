
import 'package:flutter/material.dart';

import '../data/demo_seats.dart';
import '../models/seat_model.dart';
import '../widgets/bus_info_card.dart';
import '../widgets/legend_card.dart';
import '../widgets/seat_statistics.dart';
import '../widgets/seat_allocation_status_card.dart';
import '../buddy_system/pages/buddy_system_screen.dart';
import '../widgets/last_row_seats_button.dart';
import 'seat_layout_screen.dart';
import 'student_pass_scanner_screen.dart';

class SeatAllocatorScreen extends StatefulWidget {
  const SeatAllocatorScreen({super.key});

  @override
  State<SeatAllocatorScreen> createState() =>
      _SeatAllocatorScreenState();
}

class _SeatAllocatorScreenState extends State<SeatAllocatorScreen> {
  bool? comingToday;
  String allocatedSeat = '';
  String? scannedStudentId;
  String? scanMessage;
  bool isScanning = false;

  final String busId = '1';

  // DEMO SCHEDULE ONLY:
  // Replace with the signed-in student's actual assigned stop time
  // when the existing route schedule data is connected.
  static const int scheduledStopHour = 7;
  static const int scheduledStopMinute = 40;

  DateTime get scheduledStopDateTime {
    final now = DateTime.now();

    return DateTime(
      now.year,
      now.month,
      now.day,
      scheduledStopHour,
      scheduledStopMinute,
    );
  }

  DateTime get scannerOpensAt =>
      scheduledStopDateTime.subtract(const Duration(minutes: 5));

  DateTime get scannerClosesAt =>
      scheduledStopDateTime.add(const Duration(minutes: 5));

  String get tripDate {
    final now = DateTime.now();

    return '${now.year}-'
        '${now.month.toString().padLeft(2, '0')}-'
        '${now.day.toString().padLeft(2, '0')}';
  }

  String formatTime(DateTime value) {
    final hour = value.hour % 12 == 0 ? 12 : value.hour % 12;
    final minute = value.minute.toString().padLeft(2, '0');
    final period = value.hour >= 12 ? 'PM' : 'AM';

    return '$hour:$minute $period';
  }

  bool get isWithinScanWindow {
    final now = DateTime.now();

    return !now.isBefore(scannerOpensAt) &&
        !now.isAfter(scannerClosesAt);
  }

  String get scanWindowStatus {
    final now = DateTime.now();

    if (now.isBefore(scannerOpensAt)) {
      return 'Scanner opens at ${formatTime(scannerOpensAt)}';
    }

    if (now.isAfter(scannerClosesAt)) {
      return 'Scanning closed at ${formatTime(scannerClosesAt)}';
    }

    return 'Scanner is open';
  }

  Future<void> openBarcodeScanner() async {
    if (isScanning) return;

    if (!isWithinScanWindow) {
      setState(() {
        scanMessage = scanWindowStatus;
      });
      return;
    }

    setState(() {
      scanMessage = null;
      isScanning = true;
    });

    try {
      final scannedCode = await Navigator.push<String>(
        context,
        MaterialPageRoute(
          builder: (_) => StudentPassScannerScreen(
            opensAt: scannerOpensAt,
            closesAt: scannerClosesAt,
          ),
        ),
      );

      if (!mounted || scannedCode == null) return;

      processScannedBarcode(scannedCode);
    } finally {
      if (mounted) {
        setState(() {
          isScanning = false;
        });
      }
    }
  }

  void processScannedBarcode(String barcode) {
    final normalizedCode = barcode.trim();

    if (normalizedCode.isEmpty) {
      setState(() {
        scanMessage = 'The scanned barcode is empty.';
      });
      return;
    }

    // Check the time again after returning from the scanner.
    if (!isWithinScanWindow) {
      setState(() {
        scanMessage =
        'Scanning is not allowed outside your stop time window.';
      });
      return;
    }

    // This demo uses the existing SeatModel.id as the barcode value.
    // Connect this lookup to real student/pass data for production.
    final matchingSeat = demoSeats.cast<SeatModel?>().firstWhere(
          (seat) =>
      seat != null &&
          seat.id.trim().toLowerCase() ==
              normalizedCode.toLowerCase(),
      orElse: () => null,
    );

    if (matchingSeat == null) {
      setState(() {
        scanMessage =
        'Student pass not found. Please scan a valid registered pass.';
      });
      return;
    }

    // Students must never receive faculty seats.
    if (matchingSeat.zone == SeatZone.faculty) {
      setState(() {
        scanMessage =
        'This pass is not eligible for student seat allocation.';
      });
      return;
    }

    // Avoid repeated scans for the same student during this screen session.
    if (scannedStudentId == normalizedCode) {
      setState(() {
        scanMessage = 'This pass has already been scanned.';
      });
      return;
    }

    setState(() {
      scannedStudentId = normalizedCode;
      allocatedSeat = matchingSeat.seatId;
      comingToday = true;
      scanMessage =
      'Pass scanned successfully. Seat ${matchingSeat.seatId} assigned.';
    });
  }

  void resetAttendance() {
    setState(() {
      comingToday = null;
      allocatedSeat = '';
      scannedStudentId = null;
      scanMessage = null;
    });
  }

  void openBuddySystem() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const BuddySystemScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const int totalSeats = 60;
    const int facultySeats = 8;
    const int girlsSeats = 25;
    const int boysSeats = 27;

    final int occupiedSeats = demoSeats.length;
    final int availableSeats =
    (totalSeats - occupiedSeats).clamp(0, totalSeats);

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
                BusInfoCard(
                  busNumber: '1',
                  routeName: 'Hospet → KUTS',
                  totalSeats: totalSeats,
                  facultySeats: facultySeats,
                  girlsSeats: girlsSeats,
                  boysSeats: boysSeats,
                ),

                SeatStatistics(
                  occupiedSeats: occupiedSeats,
                  availableSeats: availableSeats,
                ),

                const SizedBox(height: 15),
                const LegendCard(),
                const SizedBox(height: 15),

                // STUDENT BARCODE ATTENDANCE
                _buildBarcodeAttendanceCard(),

                const SizedBox(height: 16),

                // BUDDY SYSTEM + LAST ROW SEATS
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 55,
                          child: ElevatedButton.icon(
                            icon: const Text(
                              '🤝',
                              style: TextStyle(fontSize: 21),
                            ),
                            label: const Text(
                              'Buddy System',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF7C3AED),
                              foregroundColor: Colors.white,
                              elevation: 3,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            onPressed: openBuddySystem,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
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

                SeatAllocationStatusCard(
                  comingToday: comingToday,
                  seatNumber: allocatedSeat,
                ),

                const SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.event_seat),
                      label: const Text(
                        'View All Seats',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF5B5FEF),
                        foregroundColor: Colors.white,
                        disabledBackgroundColor:
                        const Color(0xFFB9BCEB),
                        disabledForegroundColor: Colors.white70,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed:
                      comingToday == true && allocatedSeat.isNotEmpty
                          ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => SeatLayoutScreen(
                              allocatedSeat: allocatedSeat,
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

  Widget _buildBarcodeAttendanceCard() {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            const Icon(
              Icons.qr_code_scanner_rounded,
              color: Color(0xFF5B5FEF),
              size: 46,
            ),
            const SizedBox(height: 12),
            const Text(
              "Today's Bus Attendance",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Scan the barcode on your university bus pass '
                  'to confirm boarding and receive your seat.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, height: 1.4),
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF3F4FF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Text(
                    'Scheduled stop: ${formatTime(scheduledStopDateTime)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Scan window: ${formatTime(scannerOpensAt)} - '
                        '${formatTime(scannerClosesAt)}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 13),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    scanWindowStatus,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: isWithinScanWindow
                          ? Colors.green.shade700
                          : Colors.orange.shade800,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: isScanning ? null : openBarcodeScanner,
                icon: Icon(
                  isScanning
                      ? Icons.hourglass_top
                      : Icons.document_scanner_outlined,
                ),
                label: Text(
                  isScanning ? 'Opening Scanner...' : 'Scan Bus Pass',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5B5FEF),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),
            if (scanMessage != null) ...[
              const SizedBox(height: 12),
              Text(
                scanMessage!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: scanMessage!.contains('successfully')
                      ? Colors.green.shade700
                      : Colors.red.shade700,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
            if (comingToday == true) ...[
              const SizedBox(height: 10),
              TextButton.icon(
                onPressed: resetAttendance,
                icon: const Icon(Icons.refresh),
                label: const Text('Reset demo attendance'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

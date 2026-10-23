
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class StudentPassScannerScreen extends StatefulWidget {
  final DateTime opensAt;
  final DateTime closesAt;

  const StudentPassScannerScreen({
    super.key,
    required this.opensAt,
    required this.closesAt,
  });

  @override
  State<StudentPassScannerScreen> createState() =>
      _StudentPassScannerScreenState();
}

class _StudentPassScannerScreenState
    extends State<StudentPassScannerScreen> {
  final MobileScannerController _controller = MobileScannerController();

  bool _hasScanned = false;

  bool get _isWithinWindow {
    final now = DateTime.now();

    return !now.isBefore(widget.opensAt) &&
        !now.isAfter(widget.closesAt);
  }

  String _formatTime(DateTime time) {
    final hour = time.hour % 12 == 0 ? 12 : time.hour % 12;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.hour >= 12 ? 'PM' : 'AM';

    return '$hour:$minute $period';
  }

  void _onDetect(BarcodeCapture capture) {
    if (_hasScanned || !_isWithinWindow) return;

    for (final barcode in capture.barcodes) {
      final value = barcode.rawValue?.trim();

      if (value != null && value.isNotEmpty) {
        _hasScanned = true;

        // Return the barcode to SeatAllocatorScreen.
        Navigator.of(context).pop(value);
        return;
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isOpen = _isWithinWindow;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan University Bus Pass'),
        backgroundColor: const Color(0xFF5B5FEF),
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Text(
                'Position your bus-pass barcode inside the scanning frame.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Allowed: ${_formatTime(widget.opensAt)} - '
                    '${_formatTime(widget.closesAt)}',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: isOpen
                      ? MobileScanner(
                    controller: _controller,
                    onDetect: _onDetect,
                  )
                      : Container(
                    width: double.infinity,
                    color: const Color(0xFFF3F4F6),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.lock_clock,
                          size: 60,
                          color: Color(0xFF5B5FEF),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          DateTime.now().isBefore(widget.opensAt)
                              ? 'The scanner is not open yet.'
                              : 'The scanning window has closed.',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton.icon(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Cancel Scanning'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../models/last_row_seat_model.dart';
import '../services/last_row_seat_service.dart';

class LastRowSeatsScreen extends StatefulWidget {
  final String busId;
  final String tripDate;

  const LastRowSeatsScreen({
    super.key,
    required this.busId,
    required this.tripDate,
  });

  @override
  State<LastRowSeatsScreen> createState() =>
      _LastRowSeatsScreenState();
}

class _LastRowSeatsScreenState extends State<LastRowSeatsScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController =
  TextEditingController();

  final TextEditingController _usnController =
  TextEditingController();

  final LastRowSeatService _seatService =
  LastRowSeatService();

  LastRowSeat? _allocatedSeat;

  bool _isLoading = false;
  bool _attendanceConfirmed = false;

  @override
  void dispose() {
    _nameController.dispose();
    _usnController.dispose();
    super.dispose();
  }

  int get _allocatedCount {
    return _seatService.getAllocatedCount(
      busId: widget.busId,
      tripDate: widget.tripDate,
    );
  }

  int get _availableCount {
    return _seatService.getAvailableCount(
      busId: widget.busId,
      tripDate: widget.tripDate,
    );
  }

  Future<void> _getLastRowSeat() async {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
      _allocatedSeat = null;
      _attendanceConfirmed = false;
    });

    try {
      final seat =
      await _seatService.allocateSeatAndConfirmAttendance(
        name: _nameController.text,
        usn: _usnController.text,
        busId: widget.busId,
        tripDate: widget.tripDate,
      );

      if (!mounted) return;

      if (seat == null) {
        _showMessage(
          'Last row seats are full.',
          isError: true,
        );

        setState(() {
          _isLoading = false;
        });

        return;
      }

      setState(() {
        _allocatedSeat = seat;
        _attendanceConfirmed = true;
        _isLoading = false;
      });

      _showMessage(
        'Seat allocated successfully. '
            'Your attendance has been confirmed.',
      );
    } catch (e) {
      if (!mounted) return;

      String message = e
          .toString()
          .replaceFirst('Exception: ', '');

      if (message.isEmpty) {
        message =
        'Unable to allocate the last-row seat.';
      }

      setState(() {
        _isLoading = false;
      });

      _showMessage(
        message,
        isError: true,
      );
    }
  }

  void _showMessage(
      String message, {
        bool isError = false,
      }) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 3),
        ),
      );
  }

  String? _validateName(String? value) {
    final name = value?.trim() ?? '';

    if (name.isEmpty) {
      return 'Please enter your name.';
    }

    if (name.length < 2) {
      return 'Enter a valid name.';
    }

    return null;
  }

  String? _validateUsn(String? value) {
    final usn = value?.trim() ?? '';

    if (usn.isEmpty) {
      return 'Please enter your USN.';
    }

    if (usn.length < 5) {
      return 'Enter a valid USN.';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Last Row Seats',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
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
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildHeaderCard(),
                const SizedBox(height: 16),
                _buildSeatAvailabilityCard(),
                const SizedBox(height: 16),
                _buildRequestCard(),
                if (_allocatedSeat != null) ...[
                  const SizedBox(height: 16),
                  _buildAllocatedSeatCard(),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderCard() {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF6366F1),
                    Color(0xFF8B5CF6),
                  ],
                ),
              ),
              child: const Icon(
                Icons.event_seat_rounded,
                color: Colors.white,
                size: 30,
              ),
            ),
            const SizedBox(width: 16),
            const Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    'Last Row Seats',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Reserve one of the 6 available last-row seats.',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSeatAvailabilityCard() {
    final bool isFull = _availableCount == 0;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            Row(
              children: [
                const Icon(
                  Icons.airline_seat_recline_normal_rounded,
                  size: 24,
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: Text(
                    'Seat Availability',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    borderRadius:
                    BorderRadius.circular(20),
                    color: isFull
                        ? Colors.red.withValues(alpha: 0.12)
                        : Colors.green.withValues(alpha: 0.12),
                  ),
                  child: Text(
                    isFull ? 'FULL' : 'AVAILABLE',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: isFull
                          ? Colors.red.shade700
                          : Colors.green.shade700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildAvailabilityItem(
                    title: 'Allocated',
                    value: '$_allocatedCount',
                    icon: Icons.person_rounded,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildAvailabilityItem(
                    title: 'Available',
                    value: '$_availableCount',
                    icon: Icons.event_seat_rounded,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildAvailabilityItem(
                    title: 'Total',
                    value: '6',
                    icon: Icons.groups_rounded,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvailabilityItem({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 14,
        horizontal: 8,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.black.withValues(alpha: 0.04),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 20,
            color: Colors.indigo,
          ),
          const SizedBox(height: 7),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            title,
            style: const TextStyle(
              fontSize: 11,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequestCard() {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              const Text(
                'Request a Seat',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 18),

              TextFormField(
                controller: _nameController,
                textCapitalization:
                TextCapitalization.words,
                validator: _validateName,
                decoration: InputDecoration(
                  labelText: 'Name',
                  hintText: 'Enter your name',
                  prefixIcon: const Icon(
                    Icons.person_outline_rounded,
                  ),
                  border: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(16),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: Colors.grey.shade300,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 14),

              TextFormField(
                controller: _usnController,
                textCapitalization:
                TextCapitalization.characters,
                validator: _validateUsn,
                decoration: InputDecoration(
                  labelText: 'USN',
                  hintText: 'Enter your USN',
                  prefixIcon: const Icon(
                    Icons.badge_outlined,
                  ),
                  border: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(16),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: Colors.grey.shade300,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 54,
                child: FilledButton.icon(
                  onPressed:
                  (_isLoading || _availableCount == 0)
                      ? null
                      : _getLastRowSeat,
                  icon: _isLoading
                      ? const SizedBox(
                    width: 20,
                    height: 20,
                    child:
                    CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: Colors.white,
                    ),
                  )
                      : const Icon(
                    Icons.event_seat_rounded,
                  ),
                  label: Text(
                    _isLoading
                        ? 'Allocating...'
                        : 'Get Last Row Seat',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF7C3AED),
                    foregroundColor: Colors.white,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                    ),
                  ),
                ),
              ),

              if (_availableCount == 0) ...[
                const SizedBox(height: 12),
                const Center(
                  child: Text(
                    'Last row seats are full.',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAllocatedSeatCard() {
    final seat = _allocatedSeat!;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: Colors.green.withValues(alpha: 0.35),
            width: 1.5,
          ),
        ),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green.withValues(
                      alpha: 0.12,
                    ),
                  ),
                  child: const Icon(
                    Icons.check_circle_rounded,
                    color: Colors.green,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'Seat Allocated Successfully',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            _buildSeatDetail(
              label: 'Student Name',
              value: seat.name,
              icon: Icons.person_rounded,
            ),

            _buildSeatDetail(
              label: 'USN',
              value: seat.usn,
              icon: Icons.badge_rounded,
            ),

            _buildSeatDetail(
              label: 'Seat',
              value:
              'Last Row - Seat ${seat.seatNumber}',
              icon: Icons.event_seat_rounded,
            ),

            _buildSeatDetail(
              label: 'Status',
              value: 'Allocated',
              icon: Icons.check_circle_rounded,
              valueColor: Colors.green.shade700,
            ),

            if (_attendanceConfirmed) ...[
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.circular(14),
                  color: Colors.green.withValues(
                    alpha: 0.10,
                  ),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.verified_rounded,
                      color: Colors.green,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Your attendance has been confirmed.',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSeatDetail({
    required String label,
    required String value,
    required IconData icon,
    Color? valueColor,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 21,
            color: Colors.indigo,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: valueColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
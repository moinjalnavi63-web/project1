import 'package:flutter/foundation.dart';

import '../models/last_row_seat_model.dart';

class LastRowSeatService {
  static const List<String> lastRowSeatIds = [
    '11A',
    '11B',
    '11C',
    '11D',
    '11E',
    '11F',
  ];

  static const int maxSeats = 6;

  static final Map<String, List<LastRowSeat>> _allocations = {};

  String _tripKey({
    required String busId,
    required String tripDate,
  }) {
    return '${busId.trim()}-${tripDate.trim()}';
  }

  List<LastRowSeat> getAllocations({
    required String busId,
    required String tripDate,
  }) {
    final key = _tripKey(
      busId: busId,
      tripDate: tripDate,
    );

    return List.unmodifiable(
      _allocations[key] ?? [],
    );
  }

  int getAllocatedCount({
    required String busId,
    required String tripDate,
  }) {
    return getAllocations(
      busId: busId,
      tripDate: tripDate,
    ).length;
  }

  int getAvailableCount({
    required String busId,
    required String tripDate,
  }) {
    return maxSeats -
        getAllocatedCount(
          busId: busId,
          tripDate: tripDate,
        );
  }

  LastRowSeat? findSeatByUsn({
    required String usn,
    required String busId,
    required String tripDate,
  }) {
    final normalizedUsn =
    usn.trim().toUpperCase();

    for (final seat in getAllocations(
      busId: busId,
      tripDate: tripDate,
    )) {
      if (seat.usn.trim().toUpperCase() ==
          normalizedUsn) {
        return seat;
      }
    }

    return null;
  }

  // ==========================================================
  // FIND NEXT ACTUAL BUS SEAT
  // ==========================================================

  String? _getNextAvailableSeatId({
    required String busId,
    required String tripDate,
  }) {
    final allocations = getAllocations(
      busId: busId,
      tripDate: tripDate,
    );

    final occupiedSeats = allocations
        .map((seat) => seat.seatNumber)
        .toSet();

    for (final seatId in lastRowSeatIds) {
      if (!occupiedSeats.contains(seatId)) {
        return seatId;
      }
    }

    return null;
  }

  // ==========================================================
  // ALLOCATE LAST ROW SEAT
  // ==========================================================

  Future<LastRowSeat?> allocateSeat({
    required String name,
    required String usn,
    required String busId,
    required String tripDate,
  }) async {
    final cleanName = name.trim();
    final cleanUsn =
    usn.trim().toUpperCase();

    if (cleanName.isEmpty) {
      throw Exception(
        'Please enter your name.',
      );
    }

    if (cleanUsn.isEmpty) {
      throw Exception(
        'Please enter your USN.',
      );
    }

    if (busId.trim().isEmpty) {
      throw Exception(
        'Bus information is missing.',
      );
    }

    if (tripDate.trim().isEmpty) {
      throw Exception(
        'Trip date is missing.',
      );
    }

    // ========================================================
    // DUPLICATE USN CHECK
    // ========================================================

    final existingSeat = findSeatByUsn(
      usn: cleanUsn,
      busId: busId,
      tripDate: tripDate,
    );

    if (existingSeat != null) {
      throw Exception(
        'You already have a last-row seat allocated.',
      );
    }

    // ========================================================
    // FIND NEXT ACTUAL SEAT
    // ========================================================

    final nextSeatId =
    _getNextAvailableSeatId(
      busId: busId,
      tripDate: tripDate,
    );

    // All six seats occupied.
    if (nextSeatId == null) {
      return null;
    }

    // ========================================================
    // CREATE ALLOCATION
    // ========================================================

    final seat = LastRowSeat(
      id: '${busId}_${tripDate}_$nextSeatId',
      name: cleanName,
      usn: cleanUsn,
      busId: busId,
      tripDate: tripDate,
      seatNumber: nextSeatId,
      isAllocated: true,
      allocatedAt: DateTime.now(),
    );

    final key = _tripKey(
      busId: busId,
      tripDate: tripDate,
    );

    _allocations.putIfAbsent(
      key,
          () => [],
    );

    _allocations[key]!.add(seat);

    debugPrint(
      'Last row seat allocated: '
          '$cleanUsn -> $nextSeatId',
    );

    return seat;
  }

  // ==========================================================
  // RELEASE SEAT
  // ==========================================================

  Future<bool> releaseSeat({
    required String usn,
    required String busId,
    required String tripDate,
  }) async {
    final key = _tripKey(
      busId: busId,
      tripDate: tripDate,
    );

    final allocations =
    _allocations[key];

    if (allocations == null ||
        allocations.isEmpty) {
      return false;
    }

    final normalizedUsn =
    usn.trim().toUpperCase();

    final index =
    allocations.indexWhere(
          (seat) =>
      seat.usn.trim().toUpperCase() ==
          normalizedUsn,
    );

    if (index == -1) {
      return false;
    }

    allocations.removeAt(index);

    if (allocations.isEmpty) {
      _allocations.remove(key);
    }

    return true;
  }

  // ==========================================================
  // RESET TRIP
  // ==========================================================

  Future<void> resetTrip({
    required String busId,
    required String tripDate,
  }) async {
    final key = _tripKey(
      busId: busId,
      tripDate: tripDate,
    );

    _allocations.remove(key);
  }

  // ==========================================================
  // ATTENDANCE
  // ==========================================================

  Future<bool> confirmAttendance({
    required String usn,
    required String busId,
    required String tripDate,
  }) async {
    final seat = findSeatByUsn(
      usn: usn,
      busId: busId,
      tripDate: tripDate,
    );

    if (seat == null ||
        !seat.isAllocated) {
      return false;
    }

    debugPrint(
      'Attendance confirmed for '
          '$usn - Bus $busId - $tripDate',
    );

    // TODO:
    // Connect this to your existing Attendance service.

    return true;
  }

  // ==========================================================
  // ALLOCATE + ATTENDANCE
  // ==========================================================

  Future<LastRowSeat?>
  allocateSeatAndConfirmAttendance({
    required String name,
    required String usn,
    required String busId,
    required String tripDate,
  }) async {
    final seat = await allocateSeat(
      name: name,
      usn: usn,
      busId: busId,
      tripDate: tripDate,
    );

    // No seat available.
    if (seat == null) {
      return null;
    }

    // Attendance only after seat allocation.
    final attendanceConfirmed =
    await confirmAttendance(
      usn: usn,
      busId: busId,
      tripDate: tripDate,
    );

    // Roll back allocation if attendance fails.
    if (!attendanceConfirmed) {
      await releaseSeat(
        usn: usn,
        busId: busId,
        tripDate: tripDate,
      );

      throw Exception(
        'Attendance could not be confirmed. '
            'The seat was not allocated.',
      );
    }

    return seat;
  }

  // ==========================================================
  // DEVELOPMENT RESET
  // ==========================================================

  static void clearAllForTesting() {
    _allocations.clear();
  }
}
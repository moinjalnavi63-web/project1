import '../models/admin_seat_model.dart';

class AdminSeatData {
  static List<AdminSeatModel> getSeatsForBus(
      String busNumber,
      ) {
    final seats = <AdminSeatModel>[];

    // ============================================================
    // FACULTY
    // ============================================================
    //
    // Faculty seats:
    //
    // 1A  1B  1C
    //
    // 2A  2B      2C  2D
    //
    // ============================================================

    seats.addAll([
      _faculty(
        '1A',
        busNumber,
        'Faculty 1',
        'EMP001',
      ),

      _faculty(
        '1B',
        busNumber,
        'Faculty 2',
        'EMP002',
      ),

      _faculty(
        '1C',
        busNumber,
        'Faculty 3',
        'EMP003',
      ),

      _faculty(
        '2A',
        busNumber,
        'Faculty 4',
        'EMP004',
      ),

      _faculty(
        '2B',
        busNumber,
        'Faculty 5',
        'EMP005',
      ),

      _faculty(
        '2C',
        busNumber,
        'Faculty 6',
        'EMP006',
      ),

      _faculty(
        '2D',
        busNumber,
        'Faculty 7',
        'EMP007',
      ),
    ]);

    // ============================================================
    // GIRLS
    // ============================================================
    //
    // Girls occupy rows:
    //
    // 3A - 3F
    // 4A - 4F
    // 5A - 5F
    // 6A - 6F
    //
    // ============================================================

    for (int row = 3; row <= 6; row++) {
      for (int col = 0; col < 6; col++) {
        final String letter =
        String.fromCharCode(
          'A'.codeUnitAt(0) + col,
        );

        final String seatId = '$row$letter';

        seats.add(
          _studentSeat(
            seatId: seatId,
            zone: AdminSeatZone.girls,
            busNumber: busNumber,
          ),
        );
      }
    }

    // ============================================================
    // BOYS
    // ============================================================
    //
    // Boys occupy rows:
    //
    // 7A - 7F
    // 8A - 8F
    // 9A - 9F
    // 10A - 10F
    // 11A - 11F
    //
    // 11 is the LAST ROW.
    //
    // ============================================================

    for (int row = 7; row <= 11; row++) {
      for (int col = 0; col < 6; col++) {
        final String letter =
        String.fromCharCode(
          'A'.codeUnitAt(0) + col,
        );

        final String seatId = '$row$letter';

        seats.add(
          _studentSeat(
            seatId: seatId,
            zone: AdminSeatZone.boys,
            busNumber: busNumber,
          ),
        );
      }
    }

    // ============================================================
    // DEMO ALLOCATIONS
    // ============================================================

    return _applyDemoAllocations(
      seats,
      busNumber,
    );
  }

  // ============================================================
  // FACULTY SEAT
  // ============================================================

  static AdminSeatModel _faculty(
      String seatId,
      String busNumber,
      String name,
      String employeeId,
      ) {
    return AdminSeatModel(
      seatId: seatId,
      zone: AdminSeatZone.faculty,
      isOccupied: true,
      isBuddySeat: false,
      busNumber: busNumber,
      studentName: name,
      studentUsn: employeeId,
      branch: 'Faculty',
      year: '-',
      pickupStop: 'Assigned',
    );
  }

  // ============================================================
  // STUDENT SEAT
  // ============================================================

  static AdminSeatModel _studentSeat({
    required String seatId,
    required AdminSeatZone zone,
    required String busNumber,
  }) {
    return AdminSeatModel(
      seatId: seatId,
      zone: zone,
      isOccupied: false,
      isBuddySeat: false,
      busNumber: busNumber,
    );
  }

  // ============================================================
  // DEMO ALLOCATIONS
  // ============================================================
  //
  // These are only sample allocations for Bus 1.
  //
  // Later this will come from the actual database/
  // attendance + seat allocation system.
  //
  // ============================================================

  static List<AdminSeatModel> _applyDemoAllocations(
      List<AdminSeatModel> seats,
      String busNumber,
      ) {
    if (busNumber != 'Bus 1') {
      return seats;
    }

    final allocations = <String, Map<String, String>>{
      // ----------------------------------------------------------
      // GIRLS
      // ----------------------------------------------------------

      '3A': {
        'name': 'Moin',
        'usn': 'KUB24CSE118',
        'branch': 'CSE',
        'year': '3rd Year',
        'stop': 'Hospet',
      },

      '3B': {
        'name': 'Mohammed Mansoor',
        'usn': 'KUB24CSE119',
        'branch': 'CSE',
        'year': '3rd Year',
        'stop': 'Hospet',
      },

      '4A': {
        'name': 'Rahul Kumar',
        'usn': 'KUB25ECE101',
        'branch': 'ECE',
        'year': '2nd Year',
        'stop': 'Gangavathi',
      },

      '4B': {
        'name': 'Anjali',
        'usn': 'KUB25ISE104',
        'branch': 'ISE',
        'year': '2nd Year',
        'stop': 'Gangavathi',
      },

      // ----------------------------------------------------------
      // BOYS
      // ----------------------------------------------------------

      '7A': {
        'name': 'Arun',
        'usn': 'KUB26AIML110',
        'branch': 'AIML',
        'year': '1st Year',
        'stop': 'Koppal',
      },
    };

    return seats.map((seat) {
      final data = allocations[seat.seatId];

      if (data == null) {
        return seat;
      }

      // ----------------------------------------------------------
      // BUDDY SEATS
      // ----------------------------------------------------------

      final bool buddy =
          seat.seatId == '3A' ||
              seat.seatId == '3B';

      return AdminSeatModel(
        seatId: seat.seatId,
        zone: seat.zone,
        isOccupied: true,
        isBuddySeat: buddy,
        busNumber: busNumber,

        studentName: data['name'],
        studentUsn: data['usn'],
        branch: data['branch'],
        year: data['year'],
        pickupStop: data['stop'],

        buddyGroupName:
        buddy
            ? 'Moin & Mohammed Buddy Group'
            : null,
      );
    }).toList();
  }
}
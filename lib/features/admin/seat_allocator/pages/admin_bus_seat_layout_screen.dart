import 'package:flutter/material.dart';

import '../data/admin_seat_data.dart';
import '../models/admin_seat_model.dart';

class AdminBusSeatLayoutScreen extends StatefulWidget {
  final String busNumber;

  const AdminBusSeatLayoutScreen({
    super.key,
    required this.busNumber,
  });

  @override
  State<AdminBusSeatLayoutScreen> createState() =>
      _AdminBusSeatLayoutScreenState();
}

class _AdminBusSeatLayoutScreenState
    extends State<AdminBusSeatLayoutScreen> {
  late List<AdminSeatModel> seats;

  @override
  void initState() {
    super.initState();

    seats = AdminSeatData.getSeatsForBus(
      widget.busNumber,
    );
  }

  @override
  Widget build(BuildContext context) {
    final faculty = seats
        .where((seat) => seat.zone == AdminSeatZone.faculty)
        .toList();

    final girls = seats
        .where((seat) => seat.zone == AdminSeatZone.girls)
        .toList();

    final boys = seats
        .where((seat) => seat.zone == AdminSeatZone.boys)
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xfff4f6fb),
      appBar: AppBar(
        title: Text(
          '${widget.busNumber} • Seat Allocator',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff6366f1),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: 650,
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  _driver(),

                  const SizedBox(height: 25),

                  // ==============================
                  // FACULTY
                  // ==============================

                  _zoneTitle(
                    'Faculty Zone',
                    Colors.blue,
                  ),

                  _facultyLayout(faculty),

                  const SizedBox(height: 20),

                  // ==============================
                  // GIRLS
                  // ==============================

                  _zoneTitle(
                    'Girls Zone',
                    Colors.pink,
                  ),

                  _studentLayout(girls),

                  const SizedBox(height: 25),

                  // ==============================
                  // BOYS
                  // ==============================

                  _zoneTitle(
                    'Boys Zone',
                    Colors.green,
                  ),

                  _studentLayout(boys),

                  const SizedBox(height: 25),

                  // ==============================
                  // LAST ROW
                  // ==============================

                  _lastRow(boys),

                  const SizedBox(height: 35),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // DRIVER
  // ============================================================

  Widget _driver() {
    return Container(
      width: 215,
      height: 70,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withValues(alpha: 0.25),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '🚌',
            style: TextStyle(fontSize: 27),
          ),
          SizedBox(width: 8),
          Text(
            'DRIVER',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // ZONE TITLE
  // ============================================================

  Widget _zoneTitle(
      String title,
      Color color,
      ) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 10,
          bottom: 12,
        ),
        child: Row(
          children: [
            Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // FACULTY LAYOUT
  //
  //              1A       1B       1C
  //
  //       2A     2B                 2C     2D
  // ============================================================

  Widget _facultyLayout(
      List<AdminSeatModel> seats,
      ) {
    if (seats.length < 7) {
      return const Text(
        'Faculty seats are incomplete.',
        style: TextStyle(
          color: Colors.red,
        ),
      );
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _seatBox(seats[0]),
            Row(
              children: [
                _seatBox(seats[1]),
                _seatBox(seats[2]),
              ],
            ),
          ],
        ),

        const SizedBox(height: 15),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                _seatBox(seats[3]),
                _seatBox(seats[4]),
              ],
            ),
            Row(
              children: [
                _seatBox(seats[5]),
                _seatBox(seats[6]),
              ],
            ),
          ],
        ),

        const SizedBox(height: 20),

        const Divider(
          thickness: 2,
        ),

        const SizedBox(height: 15),
      ],
    );
  }

  // ============================================================
  // STUDENT LAYOUT
  //
  // 3A 3B 3C       3D 3E 3F
  // 4A 4B 4C       4D 4E 4F
  // ...
  // ============================================================

  Widget _studentLayout(
      List<AdminSeatModel> seats,
      ) {
    final normalSeats = seats
        .where(
          (seat) => !seat.seatId.startsWith('11'),
    )
        .toList();

    final List<Widget> rows = [];

    for (int i = 0; i + 5 < normalSeats.length; i += 6) {
      final rowSeats = normalSeats.sublist(
        i,
        i + 6,
      );

      rows.add(
        Padding(
          padding: const EdgeInsets.only(
            bottom: 15,
          ),
          child: Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  _seatBox(rowSeats[0]),
                  _seatBox(rowSeats[1]),
                  _seatBox(rowSeats[2]),
                ],
              ),

              const SizedBox(
                width: 30,
                child: Icon(
                  Icons.more_vert,
                  color: Colors.grey,
                  size: 30,
                ),
              ),

              Row(
                children: [
                  _seatBox(rowSeats[3]),
                  _seatBox(rowSeats[4]),
                  _seatBox(rowSeats[5]),
                ],
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      children: rows,
    );
  }

  // ============================================================
  // LAST ROW
  // ============================================================

  Widget _lastRow(
      List<AdminSeatModel> seats,
      ) {
    final lastSeats = seats
        .where(
          (seat) => seat.seatId.startsWith('11'),
    )
        .toList();

    if (lastSeats.isEmpty) {
      return const SizedBox();
    }

    return Column(
      children: [
        const Divider(
          thickness: 2,
        ),

        const SizedBox(height: 15),

        const Text(
          'Last Row',
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 15),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: lastSeats.map(
                (seat) {
              return _seatBox(seat);
            },
          ).toList(),
        ),
      ],
    );
  }

  // ============================================================
  // SEAT BOX
  // ============================================================

  Widget _seatBox(
      AdminSeatModel seat,
      ) {
    return GestureDetector(
      onTap: () {
        _showSeatDetails(seat);
      },
      child: Container(
        width: 94,
        height: 104,
        margin: const EdgeInsets.symmetric(
          horizontal: 3,
        ),
        decoration: BoxDecoration(
          color: _seatBackground(seat),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: _seatBorder(seat),
            width: seat.isBuddySeat ? 3 : 2,
          ),
          boxShadow: [
            if (seat.isBuddySeat)
              BoxShadow(
                color: Colors.deepPurple.withValues(
                  alpha: 0.25,
                ),
                blurRadius: 10,
              ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.event_seat,
              size: 23,
              color: _seatIconColor(seat),
            ),

            const SizedBox(height: 4),

            Text(
              seat.seatId,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: _seatTextColor(seat),
              ),
            ),

            const SizedBox(height: 4),

            if (seat.isOccupied)
              Text(
                seat.studentName ?? 'Occupied',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: _seatTextColor(seat),
                ),
              )
            else
              Text(
                'Available',
                style: TextStyle(
                  fontSize: 10,
                  color: _seatTextColor(seat),
                ),
              ),

            if (seat.isBuddySeat)
              const Padding(
                padding: EdgeInsets.only(top: 3),
                child: Icon(
                  Icons.people,
                  size: 15,
                  color: Colors.deepPurple,
                ),
              ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SEAT COLORS
  // ============================================================

  Color _seatBackground(
      AdminSeatModel seat,
      ) {
    if (seat.isBuddySeat) {
      return Colors.deepPurple.shade50;
    }

    if (seat.zone == AdminSeatZone.faculty) {
      return Colors.blue.shade50;
    }

    if (!seat.isOccupied) {
      return Colors.white;
    }

    if (seat.zone == AdminSeatZone.girls) {
      return Colors.pink.shade50;
    }

    return Colors.green.shade50;
  }

  Color _seatBorder(
      AdminSeatModel seat,
      ) {
    if (seat.isBuddySeat) {
      return Colors.deepPurple;
    }

    if (seat.zone == AdminSeatZone.faculty) {
      return Colors.blue;
    }

    if (seat.zone == AdminSeatZone.girls) {
      return Colors.pink;
    }

    return Colors.green;
  }

  Color _seatIconColor(
      AdminSeatModel seat,
      ) {
    if (seat.isBuddySeat) {
      return Colors.deepPurple;
    }

    if (seat.zone == AdminSeatZone.faculty) {
      return Colors.blue;
    }

    if (seat.zone == AdminSeatZone.girls) {
      return Colors.pink;
    }

    return Colors.green;
  }

  Color _seatTextColor(
      AdminSeatModel seat,
      ) {
    if (seat.isBuddySeat) {
      return Colors.deepPurple;
    }

    if (seat.zone == AdminSeatZone.faculty) {
      return Colors.blue.shade900;
    }

    if (seat.zone == AdminSeatZone.girls) {
      return Colors.pink.shade900;
    }

    return Colors.green.shade900;
  }

  // ============================================================
  // SEAT DETAILS
  // ============================================================

  void _showSeatDetails(
      AdminSeatModel seat,
      ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.fromLTRB(
            22,
            20,
            22,
            30,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(28),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 45,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius:
                    BorderRadius.circular(10),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Row(
                children: [
                  Container(
                    width: 55,
                    height: 55,
                    decoration: BoxDecoration(
                      color: _seatBackground(seat),
                      borderRadius:
                      BorderRadius.circular(15),
                      border: Border.all(
                        color: _seatBorder(seat),
                        width: 2,
                      ),
                    ),
                    child: Icon(
                      Icons.event_seat,
                      color: _seatIconColor(seat),
                    ),
                  ),

                  const SizedBox(width: 15),

                  Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Seat ${seat.seatId}',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        seat.isBuddySeat
                            ? 'Buddy Seat'
                            : _zoneName(seat.zone),
                        style: TextStyle(
                          color:
                          _seatBorder(seat),
                          fontWeight:
                          FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 22),

              if (!seat.isOccupied)
                _infoRow(
                  Icons.check_circle_outline,
                  'Status',
                  'Available',
                )
              else ...[
                _infoRow(
                  Icons.person_outline,
                  'Student',
                  seat.studentName ?? '-',
                ),

                _infoRow(
                  Icons.badge_outlined,
                  'USN',
                  seat.studentUsn ?? '-',
                ),

                _infoRow(
                  Icons.school_outlined,
                  'Branch',
                  seat.branch ?? '-',
                ),

                _infoRow(
                  Icons.calendar_today_outlined,
                  'Year',
                  seat.year ?? '-',
                ),

                _infoRow(
                  Icons.location_on_outlined,
                  'Pickup Stop',
                  seat.pickupStop ?? '-',
                ),

                if (seat.isBuddySeat)
                  _infoRow(
                    Icons.groups_outlined,
                    'Buddy Group',
                    seat.buddyGroupName ?? '-',
                  ),
              ],

              const SizedBox(height: 15),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close),
                  label: const Text('Close'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // ============================================================
  // INFO ROW
  // ============================================================

  Widget _infoRow(
      IconData icon,
      String title,
      String value,
      ) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 13,
      ),
      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 21,
            color: Colors.grey.shade700,
          ),

          const SizedBox(width: 12),

          SizedBox(
            width: 105,
            child: Text(
              title,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _zoneName(
      AdminSeatZone zone,
      ) {
    switch (zone) {
      case AdminSeatZone.faculty:
        return 'Faculty Zone';
      case AdminSeatZone.girls:
        return 'Girls Zone';
      case AdminSeatZone.boys:
        return 'Boys Zone';
    }
  }
}
import 'package:flutter/material.dart';

import '../data/demo_seats.dart';
import '../models/seat_model.dart';
import '../widgets/bus_seat_widget.dart';

class SeatLayoutScreen extends StatelessWidget {
  final String allocatedSeat;

  const SeatLayoutScreen({
    super.key,
    required this.allocatedSeat,
  });

  @override
  Widget build(BuildContext context) {
    // ==========================================================
    // CREATE DISPLAY SEATS
    // ==========================================================
    //
    // Only the seat allocated to this user becomes:
    //
    // 1. Golden
    // 2. Clickable
    //
    // Every other seat remains normal and cannot be clicked.
    //

    final List<SeatModel> seats = demoSeats.map((seat) {

      final bool isMySeat =
          seat.seatId == allocatedSeat;

      return SeatModel(
        seatId: seat.seatId,
        zone: seat.zone,
        name: seat.name,
        id: seat.id,

        isCurrentUserSeat: isMySeat,

        isClickable: isMySeat,
      );

    }).toList();

    // ==========================================================
    // SEPARATE ZONES
    // ==========================================================

    final faculty = seats
        .where((seat) =>
    seat.zone == SeatZone.faculty)
        .toList();

    final girls = seats
        .where((seat) =>
    seat.zone == SeatZone.girls)
        .toList();

    final boys = seats
        .where((seat) =>
    seat.zone == SeatZone.boys)
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xfff4f6fb),

      // ========================================================
      // APP BAR
      // ========================================================

      appBar: AppBar(
        title: const Text(
          "Bus Seat Layout",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        centerTitle: true,

        backgroundColor:
        const Color(0xff5B5FEF),

        foregroundColor: Colors.white,
      ),

      // ========================================================
      // BODY
      // ========================================================

      body: SingleChildScrollView(
        child: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,

            child: SizedBox(
              width: 550,

              child: Column(
                children: [

                  const SizedBox(height: 15),

                  // =================================================
                  // DRIVER
                  // =================================================

                  driver(),

                  const SizedBox(height: 25),

                  // =================================================
                  // FACULTY
                  // =================================================

                  facultyRows(faculty),

                  const SizedBox(height: 20),

                  // =================================================
                  // GIRLS
                  // =================================================

                  zoneTitle(
                    "Girls Zone",
                    Colors.pink,
                  ),

                  studentRows(girls),

                  const SizedBox(height: 20),

                  // =================================================
                  // BOYS
                  // =================================================

                  zoneTitle(
                    "Boys Zone",
                    Colors.green,
                  ),

                  studentRows(boys),

                  const SizedBox(height: 20),

                  // =================================================
                  // LAST ROW
                  // =================================================

                  lastRow(boys),

                  const SizedBox(height: 30),
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

  Widget driver() {
    return Center(
      child: Container(
        width: 170,
        height: 65,

        decoration: BoxDecoration(
          color: Colors.orange,
          borderRadius:
          BorderRadius.circular(18),
        ),

        alignment: Alignment.center,

        child: const Text(
          "🚌 DRIVER",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // ============================================================
  // ZONE TITLE
  // ============================================================

  Widget zoneTitle(
      String title,
      Color color,
      ) {
    return Align(
      alignment: Alignment.centerLeft,

      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 12,
          left: 8,
        ),

        child: Row(
          children: [

            CircleAvatar(
              radius: 8,
              backgroundColor: color,
            ),

            const SizedBox(width: 10),

            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // FACULTY
  //
  // EXACT STRUCTURE:
  //
  //                  1A     1B     1C
  //
  //       2A     2B          2C     2D
  //
  // ============================================================

  Widget facultyRows(
      List<SeatModel> seats,
      ) {
    if (seats.length < 7) {
      return const Text(
        "Faculty seats are incomplete.",
        style: TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.bold,
        ),
      );
    }

    return Column(
      children: [

        // ========================================================
        // ROW 1
        //
        // 1A                         1B     1C
        //
        // 1A MUST STAY ON LEFT
        // ========================================================

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            // LEFT SIDE - ONLY 1A
            seatBox(seats[0]),

            // RIGHT SIDE - 1B 1C
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                seatBox(seats[1]),
                seatBox(seats[2]),
              ],
            ),
          ],
        ),

        const SizedBox(height: 12),

        // ========================================================
        // ROW 2
        //
        // 2A  2B             2C  2D
        // ========================================================

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            // LEFT SIDE
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                seatBox(seats[3]),
                seatBox(seats[4]),
              ],
            ),

            // RIGHT SIDE
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                seatBox(seats[5]),
                seatBox(seats[6]),
              ],
            ),
          ],
        ),

        const SizedBox(height: 20),

        const Divider(
          thickness: 2,
        ),
      ],
    );
  }
  // ============================================================
  // STUDENT ROWS
  //
  // 3A  3B  3C       3D  3E  3F
  //
  // Same structure until row 10.
  //
  // ============================================================

  Widget studentRows(
      List<SeatModel> seats,
      ) {
    final normalSeats = seats
        .where(
          (seat) =>
      !seat.seatId.startsWith("11"),
    )
        .toList();

    // Safety check.
    if (normalSeats.isEmpty) {
      return const SizedBox();
    }

    final int rowCount =
    (normalSeats.length / 6).floor();

    return Column(
      children: List.generate(
        rowCount,

            (rowIndex) {

          final int start =
              rowIndex * 6;

          final int end =
              start + 6;

          if (end > normalSeats.length) {
            return const SizedBox();
          }

          final rowSeats =
          normalSeats.sublist(
            start,
            end,
          );

          return Padding(
            padding:
            const EdgeInsets.only(
              bottom: 15,
            ),

            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,

              children: [

                // ==============================================
                // LEFT
                // A B C
                // ==============================================

                Row(
                  children: [

                    seatBox(rowSeats[0]),

                    seatBox(rowSeats[1]),

                    seatBox(rowSeats[2]),
                  ],
                ),

                // ==============================================
                // AISLE
                // ==============================================

                const SizedBox(
                  width: 20,

                  child: Icon(
                    Icons.more_vert,
                    color: Colors.grey,
                    size: 28,
                  ),
                ),

                // ==============================================
                // RIGHT
                // D E F
                // ==============================================

                Row(
                  children: [

                    seatBox(rowSeats[3]),

                    seatBox(rowSeats[4]),

                    seatBox(rowSeats[5]),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // ============================================================
  // LAST ROW
  //
  // 11A  11B  11C  11D  11E  11F  11G
  //
  // ============================================================

  Widget lastRow(
      List<SeatModel> seats,
      ) {
    final lastSeats = seats
        .where(
          (seat) =>
          seat.seatId.startsWith("11"),
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
          "Last Row",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 14),

        Row(
          mainAxisAlignment:
          MainAxisAlignment.center,

          children: lastSeats.map(
                (seat) {
              return seatBox(seat);
            },
          ).toList(),
        ),
      ],
    );
  }

  // ============================================================
  // COMMON SEAT BOX
  // ============================================================

  Widget seatBox(
      SeatModel seat,
      ) {
    return SizedBox(
      width: 80,
      child: BusSeatWidget(
        seat: seat,
      ),
    );
  }
  }

import '../models/seat_model.dart';

final List<SeatModel> demoSeats = [

  // =====================================================
  // FACULTY
  // 2 MEMBERS PER SEAT
  // =====================================================

  const SeatModel(
    seatId: "1A",
    zone: SeatZone.faculty,
    name: "Faculty 1",
    id: "EMP001",
  ),

  const SeatModel(
    seatId: "1B",
    zone: SeatZone.faculty,
    name: "Faculty 2",
    id: "EMP002",
  ),

  const SeatModel(
    seatId: "1C",
    zone: SeatZone.faculty,
    name: "Faculty 3",
    id: "EMP003",
  ),

  const SeatModel(
    seatId: "2A",
    zone: SeatZone.faculty,
    name: "Faculty 4",
    id: "EMP004",
  ),

  const SeatModel(
    seatId: "2B",
    zone: SeatZone.faculty,
    name: "Faculty 5",
    id: "EMP005",
  ),

  const SeatModel(
    seatId: "2C",
    zone: SeatZone.faculty,
    name: "Faculty 6",
    id: "EMP006",
  ),

  const SeatModel(
    seatId: "2D",
    zone: SeatZone.faculty,
    name: "Faculty 7",
    id: "EMP007",
  ),

  // =====================================================
  // GIRLS
  // 3 MEMBERS PER SEAT
  // ROWS 3 - 6
  // =====================================================

  for (int row = 3; row <= 6; row++)
    for (String col in ["A", "B", "C", "D", "E", "F"])
      SeatModel(
        seatId: "$row$col",
        zone: SeatZone.girls,
        name: "Girl $row$col",
        id: "KUB24CSE$row$col",
      ),

  // =====================================================
  // BOYS
  // 3 MEMBERS PER SEAT
  // ROWS 7 - 10
  // =====================================================

  for (int row = 7; row <= 10; row++)
    for (String col in ["A", "B", "C", "D", "E", "F"])
      SeatModel(
        seatId: "$row$col",
        zone: SeatZone.boys,
        name: "Boy $row$col",
        id: "KUB24CSE$row$col",
      ),
  const SeatModel(
    seatId: "11A",
    zone: SeatZone.boys,
    name: "Boy 11A",
    id: "KUB24CSE401",
  ),

  const SeatModel(
    seatId: "11B",
    zone: SeatZone.boys,
    name: "Boy 11B",
    id: "KUB24CSE402",
  ),

  const SeatModel(
    seatId: "11C",
    zone: SeatZone.boys,
    name: "Boy 11C",
    id: "KUB24CSE403",
  ),

  const SeatModel(
    seatId: "11D",
    zone: SeatZone.boys,
    name: "Boy 11D",
    id: "KUB24CSE404",
  ),

  const SeatModel(
    seatId: "11E",
    zone: SeatZone.boys,
    name: "Boy 11E",
    id: "KUB24CSE405",
  ),

  const SeatModel(
    seatId: "11F",
    zone: SeatZone.boys,
    name: "Boy 11F",
    id: "KUB24CSE406",
  ),
];
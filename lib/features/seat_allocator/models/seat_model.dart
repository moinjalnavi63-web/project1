enum SeatZone {
  faculty,
  girls,
  boys,
}

class SeatModel {
  final String seatId;

  final SeatZone zone;

  final String name;

  final String id; // USN for students, Employee ID for faculty

  final bool isCurrentUserSeat;
  final bool isClickable;

  const SeatModel({
    required this.seatId,
    required this.zone,
    required this.name,
    required this.id,
    this.isCurrentUserSeat = false,
    this.isClickable = false,
  });

  bool get isFaculty => zone == SeatZone.faculty;

  bool get isGirl => zone == SeatZone.girls;

  bool get isBoy => zone == SeatZone.boys;
}
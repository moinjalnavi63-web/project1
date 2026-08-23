class BusStop {
  final String name;
  final String time;

  const BusStop({
    required this.name,
    required this.time,
  });
}

class BusModel {
  final int busNumber;
  final String driverName;
  final String driverPhoto;
  final String driverMobile;
  final String routeName;
  final List<BusStop> stops;

  const BusModel({
    required this.busNumber,
    required this.driverName,
    required this.driverPhoto,
    required this.driverMobile,
    required this.routeName,
    required this.stops,
  });
}
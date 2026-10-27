
class BusRoute {
  final String busNumber;
  final String routeName;
  final List<String> stops;

  const BusRoute({
    required this.busNumber,
    required this.routeName,
    required this.stops,
  });
}

class RouteList {
  static const List<BusRoute> buses = [
    BusRoute(
      busNumber: 'Bus 1',
      routeName: 'Ballari Route',
      stops: [
        'Old Bus Stand',
        'Royal Circle',
        'SP Circle',
        'Cowl Bazaar',
        'Kishkinda University',
      ],
    ),
    BusRoute(
      busNumber: 'Bus 2',
      routeName: 'Hospet Route',
      stops: [
        'Hospet Bus Stand',
        'Dam Road',
        'Tungabhadra Circle',
        'College Junction',
        'Kishkinda University',
      ],
    ),
    BusRoute(
      busNumber: 'Bus 3',
      routeName: 'Siruguppa Route',
      stops: [
        'Siruguppa Bus Stand',
        'Main Market',
        'Taluk Office',
        'Highway Junction',
        'Kishkinda University',
      ],
    ),
  ];

  static List<String> get routes =>
      buses.map((bus) => bus.routeName).toList();

  static BusRoute? findBus(String? busNumber) {
    for (final bus in buses) {
      if (bus.busNumber == busNumber) {
        return bus;
      }
    }
    return null;
  }
}

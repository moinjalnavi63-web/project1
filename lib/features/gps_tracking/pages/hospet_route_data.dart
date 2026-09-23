import 'package:latlong2/latlong.dart';

class BusStop {
  final String name;
  final String time;
  final LatLng location;

  const BusStop({
    required this.name,
    required this.time,
    required this.location,
  });
}

/// Hospet Route
///
/// IMPORTANT:
/// These coordinates are temporary placeholders.
/// Replace them with verified coordinates before
/// using this route for actual transportation.

const List<BusStop> hospetRouteStops = [
  BusStop(
    name: 'Benki Mareamma Temple',
    time: '7:40 AM',
    location: LatLng(15.2690, 76.3870),
  ),

  BusStop(
    name: 'Brucepet Police Station',
    time: '7:43 AM',
    location: LatLng(15.2675, 76.3910),
  ),

  BusStop(
    name: 'Kalyan Jewellers',
    time: '7:45 AM',
    location: LatLng(15.2660, 76.3940),
  ),

  BusStop(
    name: 'Fort Entrance',
    time: '7:50 AM',
    location: LatLng(15.2640, 76.3980),
  ),

  BusStop(
    name: 'Putti Hotel',
    time: '7:53 AM',
    location: LatLng(15.2620, 76.4020),
  ),

  BusStop(
    name: 'Mount View Campus',
    time: '—',
    location: LatLng(15.2500, 76.4300),
  ),
];

import 'package:flutter/foundation.dart';

class DriverRouteStop {
  final String stop;
  final String pickupTime;
  final String dropTime;

  const DriverRouteStop({
    required this.stop,
    required this.pickupTime,
    required this.dropTime,
  });
}

class DriverProfileData extends ChangeNotifier {
  DriverProfileData._();

  static final DriverProfileData instance = DriverProfileData._();

  // Existing driver information — preserved.
  String _driverName = 'Driver Name';
  final String driverId = 'DR001';
  final String email = 'driver@gmail.com';
  String _mobileNumber = 'Registered Mobile Number';

  // Existing assigned transport information — preserved.
  final String busNumber = 'Bus 01';
  final String route = 'Hospet Route';

  // Set when the driver selects a profile picture.
  String? _photoPath;

  // Populate this list with the exact existing route-stop data.
  // No stop names or timings have been invented.
  List<DriverRouteStop> _routeStops = [];

  String get driverName => _driverName;
  String get mobileNumber => _mobileNumber;
  String? get photoPath => _photoPath;
  List<DriverRouteStop> get routeStops =>
      List.unmodifiable(_routeStops);

  void updateProfile({
    required String name,
    required String mobile,
  }) {
    if (name.trim().isNotEmpty) {
      _driverName = name.trim();
    }

    if (mobile.trim().isNotEmpty) {
      _mobileNumber = mobile.trim();
    }

    notifyListeners();
  }

  void updatePhoto(String path) {
    _photoPath = path;
    notifyListeners();
  }

  // Use the existing stop names and timings when connecting
  // this shared profile to your assigned-bus data.
  void setRouteStops(List<DriverRouteStop> stops) {
    _routeStops = List<DriverRouteStop>.from(stops);
    notifyListeners();
  }
}

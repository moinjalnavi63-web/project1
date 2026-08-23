import 'package:ku_transport_system/features/bus_directory/models/bus_model.dart';

void main() {
  const bus = BusModel(
    busNumber: 1,
    driverName: 'Driver',
    driverPhoto: '',
    driverMobile: '9876543210',
    routeName: 'Route 1',
    stops: [],
  );

  print(bus.driverName);
}
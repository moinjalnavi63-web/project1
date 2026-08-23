import '../models/bus_model.dart';

final List<BusModel> busList = List.generate(
  24,
      (index) {
    final busNo = index + 1;

    return BusModel(
      busNumber: busNo,
      driverName: "Driver $busNo",
      driverPhoto: "",
      driverMobile: "98765432${busNo.toString().padLeft(2, '0')}",
      routeName: "Route $busNo",
      stops: [
        BusStop(
          name: "Stop A",
          time: "7:30 AM",
        ),
        BusStop(
          name: "Stop B",
          time: "7:45 AM",
        ),
        BusStop(
          name: "Stop C",
          time: "8:00 AM",
        ),
        BusStop(
          name: "Stop D",
          time: "8:15 AM",
        ),
        BusStop(
          name: "Kishkinda University",
          time: "8:45 AM",
        ),
      ],
    );
  },
);
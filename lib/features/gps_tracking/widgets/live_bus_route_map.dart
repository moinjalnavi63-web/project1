import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../pages/hospet_route_data.dart';

class LiveBusRouteMap extends StatefulWidget {
  final String busNumber;
  final String routeName;
  final List<BusStop> stops;

  const LiveBusRouteMap({
    super.key,
    required this.busNumber,
    required this.routeName,
    required this.stops,
  });

  @override
  State<LiveBusRouteMap> createState() => _LiveBusRouteMapState();
}

class _LiveBusRouteMapState extends State<LiveBusRouteMap> {
  final MapController _mapController = MapController();

  Timer? _timer;

  int _currentStopIndex = 0;

  late LatLng _busLocation;

  @override
  void initState() {
    super.initState();

    if (widget.stops.isNotEmpty) {
      _busLocation = LatLng(
        widget.stops.first.location.latitude,
        widget.stops.first.location.longitude,
      );
    }

    _startBusSimulation();
  }

  void _startBusSimulation() {
    _timer = Timer.periodic(
      const Duration(seconds: 2),
          (_) {
        if (!mounted || widget.stops.isEmpty) {
          return;
        }

        if (_currentStopIndex < widget.stops.length - 1) {
          setState(() {
            _currentStopIndex++;

            _busLocation = LatLng(
              widget.stops[_currentStopIndex].location.latitude,
              widget.stops[_currentStopIndex].location.longitude,
            );
          });

          _mapController.move(
            _busLocation,
            14,
          );
        } else {
          setState(() {
            _currentStopIndex = 0;

            _busLocation = LatLng(
              widget.stops.first.location.latitude,
              widget.stops.first.location.longitude,
            );
          });

          _mapController.move(
            _busLocation,
            14,
          );
        }
      },
    );
  }

  List<LatLng> _routePoints() {
    return widget.stops
        .map(
          (stop) => LatLng(
        stop.location.latitude,
        stop.location.longitude,
      ),
    )
        .toList();
  }

  @override
  void dispose() {
    _timer?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.stops.isEmpty) {
      return const SizedBox(
        height: 350,
        child: Center(
          child: Text('No route stops available'),
        ),
      );
    }

    final currentStop = widget.stops[_currentStopIndex];

    final firstLocation = LatLng(
      widget.stops.first.location.latitude,
      widget.stops.first.location.longitude,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // =========================
        // BUS INFORMATION
        // =========================

        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            gradient: const LinearGradient(
              colors: [
                Color(0xFF6366F1),
                Color(0xFF8B5CF6),
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.directions_bus,
                    color: Colors.white,
                    size: 27,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      widget.busNumber,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.gps_fixed,
                          color: Colors.white,
                          size: 14,
                        ),
                        SizedBox(width: 5),
                        Text(
                          'GPS ACTIVE',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                widget.routeName,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),

        // =========================
        // CURRENT LOCATION
        // =========================

        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                blurRadius: 8,
                color: Colors.black.withOpacity(0.08),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.location_on,
                  color: Colors.green,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Current Stop',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      currentStop.name,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                currentStop.time,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),

        // =========================
        // OPEN STREET MAP
        // =========================

        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: SizedBox(
            height: 400,
            child: FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: firstLocation,
                initialZoom: 13,
                interactionOptions: const InteractionOptions(
                  flags: InteractiveFlag.all,
                ),
              ),
              children: [
                TileLayer(
                  urlTemplate:
                  'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName:
                  'com.example.ku_transport_system',
                ),

                // Route
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: _routePoints(),
                      strokeWidth: 5,
                    ),
                  ],
                ),

                // Stop markers
                MarkerLayer(
                  markers: [
                    ...List.generate(
                      widget.stops.length,
                          (index) {
                        final stop = widget.stops[index];

                        final bool isCurrent =
                            index == _currentStopIndex;

                        return Marker(
                          point: LatLng(
                            stop.location.latitude,
                            stop.location.longitude,
                          ),
                          width: 55,
                          height: 65,
                          child: GestureDetector(
                            onTap: () {
                              _showStopDetails(
                                context,
                                stop,
                              );
                            },
                            child: Column(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: 38,
                                  color: isCurrent
                                      ? Colors.green
                                      : Colors.red,
                                ),
                                Container(
                                  padding:
                                  const EdgeInsets.symmetric(
                                    horizontal: 4,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                    BorderRadius.circular(5),
                                  ),
                                  child: Text(
                                    '${index + 1}',
                                    style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight:
                                      FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),

                    // BUS MARKER
                    Marker(
                      point: _busLocation,
                      width: 65,
                      height: 65,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 3,
                          ),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 8,
                              color:
                              Colors.black.withOpacity(0.25),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.directions_bus,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                    ),
                  ],
                ),

                // Attribution
                RichAttributionWidget(
                  attributions: [
                    TextSourceAttribution(
                      'OpenStreetMap contributors',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 12),

        // =========================
        // ROUTE STOPS
        // =========================

        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                blurRadius: 8,
                color: Colors.black.withOpacity(0.07),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              const Text(
                'Route Stops',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              ...List.generate(
                widget.stops.length,
                    (index) {
                  final stop = widget.stops[index];

                  final bool isCurrent =
                      index == _currentStopIndex;

                  return Row(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Container(
                            width: 14,
                            height: 14,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isCurrent
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ),
                          if (index !=
                              widget.stops.length - 1)
                            Container(
                              width: 2,
                              height: 35,
                              color: Colors.grey.shade300,
                            ),
                        ],
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: Padding(
                          padding:
                          const EdgeInsets.only(bottom: 12),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  stop.name,
                                  style: TextStyle(
                                    fontWeight: isCurrent
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                                ),
                              ),
                              Text(
                                stop.time,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: isCurrent
                                      ? Colors.green
                                      : Colors.grey,
                                  fontWeight: isCurrent
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),

        const SizedBox(height: 8),

        const Text(
          'Frontend GPS simulation • Bus location updates every 2 seconds',
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  void _showStopDetails(
      BuildContext context,
      BusStop stop,
      ) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.location_on,
                color: Colors.red,
                size: 35,
              ),
              const SizedBox(height: 10),
              Text(
                stop.name,
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                stop.time == '—'
                    ? 'Final Destination'
                    : 'Pickup Time: ${stop.time}',
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}
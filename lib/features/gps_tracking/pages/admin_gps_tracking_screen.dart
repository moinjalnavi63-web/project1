import 'package:flutter/material.dart';

class AdminGpsTrackingScreen extends StatefulWidget {
  const AdminGpsTrackingScreen({super.key});

  @override
  State<AdminGpsTrackingScreen> createState() =>
      _AdminGpsTrackingScreenState();
}

class _AdminGpsTrackingScreenState
    extends State<AdminGpsTrackingScreen> {

  // ==========================================================
  // SELECTED BUS
  // ==========================================================

  int selectedBusIndex = 0;

  // ==========================================================
  // 24 BUSES
  // ==========================================================
  //
  // These are demo GPS values for the UI.
  // Real GPS values will be connected later from the
  // driver app -> backend -> admin.
  //

  final List<Map<String, dynamic>> buses = [
    {
      'busNumber': '1',
      'route': 'Hospet → KUTS',
      'driver': 'Driver 1',
      'status': 'Live',
      'latitude': 15.2687,
      'longitude': 76.3909,
      'speed': 35,
      'lastUpdate': 'Just now',
    },
    {
      'busNumber': '2',
      'route': 'Hospet → KUTS',
      'driver': 'Driver 2',
      'status': 'Live',
      'latitude': 15.2701,
      'longitude': 76.3940,
      'speed': 28,
      'lastUpdate': '10 sec ago',
    },
    {
      'busNumber': '3',
      'route': 'Hospet → KUTS',
      'driver': 'Driver 3',
      'status': 'Offline',
      'latitude': 15.2740,
      'longitude': 76.3970,
      'speed': 0,
      'lastUpdate': '5 min ago',
    },
    {
      'busNumber': '4',
      'route': 'Hospet → KUTS',
      'driver': 'Driver 4',
      'status': 'Live',
      'latitude': 15.2765,
      'longitude': 76.4010,
      'speed': 32,
      'lastUpdate': '15 sec ago',
    },
    {
      'busNumber': '5',
      'route': 'Hospet → KUTS',
      'driver': 'Driver 5',
      'status': 'Live',
      'latitude': 15.2802,
      'longitude': 76.4052,
      'speed': 31,
      'lastUpdate': '12 sec ago',
    },
    {
      'busNumber': '6',
      'route': 'Hospet → KUTS',
      'driver': 'Driver 6',
      'status': 'Offline',
      'latitude': 15.2835,
      'longitude': 76.4091,
      'speed': 0,
      'lastUpdate': '8 min ago',
    },
    {
      'busNumber': '7',
      'route': 'Hospet → KUTS',
      'driver': 'Driver 7',
      'status': 'Live',
      'latitude': 15.2868,
      'longitude': 76.4128,
      'speed': 27,
      'lastUpdate': '8 sec ago',
    },
    {
      'busNumber': '8',
      'route': 'Hospet → KUTS',
      'driver': 'Driver 8',
      'status': 'Live',
      'latitude': 15.2901,
      'longitude': 76.4164,
      'speed': 38,
      'lastUpdate': '20 sec ago',
    },
    {
      'busNumber': '9',
      'route': 'Hospet → KUTS',
      'driver': 'Driver 9',
      'status': 'Offline',
      'latitude': 15.2935,
      'longitude': 76.4201,
      'speed': 0,
      'lastUpdate': '12 min ago',
    },
    {
      'busNumber': '10',
      'route': 'Hospet → KUTS',
      'driver': 'Driver 10',
      'status': 'Live',
      'latitude': 15.2968,
      'longitude': 76.4237,
      'speed': 30,
      'lastUpdate': '11 sec ago',
    },
    {
      'busNumber': '11',
      'route': 'Hospet → KUTS',
      'driver': 'Driver 11',
      'status': 'Live',
      'latitude': 15.3002,
      'longitude': 76.4273,
      'speed': 34,
      'lastUpdate': '9 sec ago',
    },
    {
      'busNumber': '12',
      'route': 'Hospet → KUTS',
      'driver': 'Driver 12',
      'status': 'Offline',
      'latitude': 15.3036,
      'longitude': 76.4308,
      'speed': 0,
      'lastUpdate': '7 min ago',
    },
    {
      'busNumber': '13',
      'route': 'Hospet → KUTS',
      'driver': 'Driver 13',
      'status': 'Live',
      'latitude': 15.3069,
      'longitude': 76.4344,
      'speed': 29,
      'lastUpdate': '14 sec ago',
    },
    {
      'busNumber': '14',
      'route': 'Hospet → KUTS',
      'driver': 'Driver 14',
      'status': 'Live',
      'latitude': 15.3103,
      'longitude': 76.4380,
      'speed': 36,
      'lastUpdate': '7 sec ago',
    },
    {
      'busNumber': '15',
      'route': 'Hospet → KUTS',
      'driver': 'Driver 15',
      'status': 'Offline',
      'latitude': 15.3137,
      'longitude': 76.4416,
      'speed': 0,
      'lastUpdate': '10 min ago',
    },
    {
      'busNumber': '16',
      'route': 'Hospet → KUTS',
      'driver': 'Driver 16',
      'status': 'Live',
      'latitude': 15.3170,
      'longitude': 76.4452,
      'speed': 33,
      'lastUpdate': '13 sec ago',
    },
    {
      'busNumber': '17',
      'route': 'Hospet → KUTS',
      'driver': 'Driver 17',
      'status': 'Live',
      'latitude': 15.3204,
      'longitude': 76.4488,
      'speed': 25,
      'lastUpdate': '16 sec ago',
    },
    {
      'busNumber': '18',
      'route': 'Hospet → KUTS',
      'driver': 'Driver 18',
      'status': 'Offline',
      'latitude': 15.3238,
      'longitude': 76.4524,
      'speed': 0,
      'lastUpdate': '6 min ago',
    },
    {
      'busNumber': '19',
      'route': 'Hospet → KUTS',
      'driver': 'Driver 19',
      'status': 'Live',
      'latitude': 15.3272,
      'longitude': 76.4560,
      'speed': 30,
      'lastUpdate': '10 sec ago',
    },
    {
      'busNumber': '20',
      'route': 'Hospet → KUTS',
      'driver': 'Driver 20',
      'status': 'Live',
      'latitude': 15.3306,
      'longitude': 76.4596,
      'speed': 37,
      'lastUpdate': '18 sec ago',
    },
    {
      'busNumber': '21',
      'route': 'Hospet → KUTS',
      'driver': 'Driver 21',
      'status': 'Offline',
      'latitude': 15.3340,
      'longitude': 76.4632,
      'speed': 0,
      'lastUpdate': '9 min ago',
    },
    {
      'busNumber': '22',
      'route': 'Hospet → KUTS',
      'driver': 'Driver 22',
      'status': 'Live',
      'latitude': 15.3374,
      'longitude': 76.4668,
      'speed': 26,
      'lastUpdate': '12 sec ago',
    },
    {
      'busNumber': '23',
      'route': 'Hospet → KUTS',
      'driver': 'Driver 23',
      'status': 'Live',
      'latitude': 15.3408,
      'longitude': 76.4704,
      'speed': 32,
      'lastUpdate': '6 sec ago',
    },
    {
      'busNumber': '24',
      'route': 'Hospet → KUTS',
      'driver': 'Driver 24',
      'status': 'Offline',
      'latitude': 15.3442,
      'longitude': 76.4740,
      'speed': 0,
      'lastUpdate': '11 min ago',
    },
  ];

  // ==========================================================
  // SELECTED BUS
  // ==========================================================

  Map<String, dynamic> get selectedBus {
    return buses[selectedBusIndex];
  }

  // ==========================================================
  // LIVE BUS COUNT
  // ==========================================================

  int get liveBusCount {
    return buses.where(
          (bus) => bus['status'] == 'Live',
    ).length;
  }

  // ==========================================================
  // OFFLINE BUS COUNT
  // ==========================================================

  int get offlineBusCount {
    return buses.where(
          (bus) => bus['status'] == 'Offline',
    ).length;
  }

  // ==========================================================
  // BUILD
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FC),

      appBar: AppBar(
        title: const Text(
          'Live GPS Tracking',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),

      body: Container(
        width: double.infinity,

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFD1FAE5),
              Color(0xFFE0E7FF),
              Color(0xFFCFFAFE),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),

            padding: const EdgeInsets.all(16),

            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [

                // ==================================================
                // HEADER
                // ==================================================

                const Text(
                  'University Bus Tracking',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF111827),
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  'Monitor all 24 buses',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade700,
                  ),
                ),

                const SizedBox(height: 18),

                // ==================================================
                // GPS SUMMARY
                // ==================================================

                Row(
                  children: [

                    Expanded(
                      child: _summaryCard(
                        icon: Icons.directions_bus,
                        title: 'Total Buses',
                        value: '${buses.length}',
                        iconColor:
                        const Color(0xFF5B5FEF),
                      ),
                    ),

                    const SizedBox(width: 10),

                    Expanded(
                      child: _summaryCard(
                        icon: Icons.gps_fixed,
                        title: 'Live',
                        value: '$liveBusCount',
                        iconColor: Colors.green,
                      ),
                    ),

                    const SizedBox(width: 10),

                    Expanded(
                      child: _summaryCard(
                        icon: Icons.gps_off,
                        title: 'Offline',
                        value: '$offlineBusCount',
                        iconColor: Colors.red,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 22),

                // ==================================================
                // BUS LIST TITLE
                // ==================================================

                const Text(
                  'All Buses',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF111827),
                  ),
                ),

                const SizedBox(height: 12),

                // ==================================================
                // ALL 24 BUSES
                // ==================================================

                SizedBox(
                  height: 145,

                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,

                    itemCount: buses.length,

                    itemBuilder: (
                        BuildContext context,
                        int index,
                        ) {

                      final bus = buses[index];

                      final bool selected =
                          selectedBusIndex == index;

                      final bool live =
                          bus['status'] == 'Live';

                      return GestureDetector(
                        onTap: () {

                          setState(() {
                            selectedBusIndex = index;
                          });
                        },

                        child: AnimatedContainer(
                          duration:
                          const Duration(
                            milliseconds: 250,
                          ),

                          width: 190,

                          margin:
                          const EdgeInsets.only(
                            right: 12,
                          ),

                          padding:
                          const EdgeInsets.all(16),

                          decoration:
                          BoxDecoration(

                            color: selected
                                ? const Color(
                              0xFF5B5FEF,
                            )
                                : Colors.white,

                            borderRadius:
                            BorderRadius.circular(
                              20,
                            ),

                            border: Border.all(
                              color: selected
                                  ? const Color(
                                0xFF5B5FEF,
                              )
                                  : Colors.white,
                            ),

                            boxShadow: [
                              BoxShadow(
                                color:
                                Colors.black
                                    .withValues(
                                  alpha: 0.06,
                                ),

                                blurRadius: 10,

                                offset:
                                const Offset(
                                  0,
                                  4,
                                ),
                              ),
                            ],
                          ),

                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,

                            children: [

                              Row(
                                children: [

                                  Container(
                                    width: 42,
                                    height: 42,

                                    decoration:
                                    BoxDecoration(
                                      color: selected
                                          ? Colors.white
                                          .withValues(
                                        alpha: 0.20,
                                      )
                                          : const Color(
                                        0xFFEDE9FE,
                                      ),

                                      borderRadius:
                                      BorderRadius
                                          .circular(
                                        13,
                                      ),
                                    ),

                                    child: Icon(
                                      Icons
                                          .directions_bus,

                                      color: selected
                                          ? Colors.white
                                          : const Color(
                                        0xFF5B5FEF,
                                      ),
                                    ),
                                  ),

                                  const SizedBox(
                                    width: 10,
                                  ),

                                  Expanded(
                                    child: Text(
                                      'Bus ${bus['busNumber']}',

                                      style:
                                      TextStyle(
                                        fontSize: 17,
                                        fontWeight:
                                        FontWeight
                                            .bold,

                                        color: selected
                                            ? Colors.white
                                            : const Color(
                                          0xFF111827,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(
                                height: 10,
                              ),

                              Row(
                                children: [

                                  Container(
                                    width: 8,
                                    height: 8,

                                    decoration:
                                    BoxDecoration(
                                      shape:
                                      BoxShape.circle,

                                      color: live
                                          ? Colors.green
                                          : Colors.red,
                                    ),
                                  ),

                                  const SizedBox(
                                    width: 6,
                                  ),

                                  Text(
                                    bus['status'],

                                    style:
                                    TextStyle(
                                      fontSize: 12,
                                      fontWeight:
                                      FontWeight.w600,

                                      color: selected
                                          ? Colors.white70
                                          : Colors
                                          .grey
                                          .shade700,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(
                                height: 5,
                              ),

                              Text(
                                bus['route'],

                                maxLines: 1,

                                overflow:
                                TextOverflow
                                    .ellipsis,

                                style: TextStyle(
                                  fontSize: 11,

                                  color: selected
                                      ? Colors.white70
                                      : Colors.grey
                                      .shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 20),

                // ==================================================
                // MAP
                // ==================================================

                Container(
                  width: double.infinity,
                  height: 320,

                  decoration: BoxDecoration(
                    color: Colors.white,

                    borderRadius:
                    BorderRadius.circular(22),

                    boxShadow: [
                      BoxShadow(
                        color:
                        Colors.black.withValues(
                          alpha: 0.07,
                        ),

                        blurRadius: 15,

                        offset:
                        const Offset(0, 6),
                      ),
                    ],
                  ),

                  child: ClipRRect(
                    borderRadius:
                    BorderRadius.circular(22),

                    child: Stack(
                      children: [

                        // ==================================================
                        // MAP BACKGROUND
                        // ==================================================

                        Container(
                          width: double.infinity,
                          height: double.infinity,

                          color:
                          const Color(
                            0xFFE8EEF5,
                          ),

                          child: CustomPaint(
                            painter:
                            _MapBackgroundPainter(),
                          ),
                        ),

                        // ==================================================
                        // MAP TITLE
                        // ==================================================

                        Positioned(
                          top: 15,
                          left: 15,

                          child: Container(
                            padding:
                            const EdgeInsets
                                .symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),

                            decoration:
                            BoxDecoration(
                              color: Colors.white,

                              borderRadius:
                              BorderRadius
                                  .circular(
                                12,
                              ),

                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black
                                      .withValues(
                                    alpha: 0.10,
                                  ),

                                  blurRadius: 8,
                                ),
                              ],
                            ),

                            child: const Row(
                              mainAxisSize:
                              MainAxisSize.min,

                              children: [

                                Icon(
                                  Icons.map_outlined,
                                  size: 18,
                                  color:
                                  Color(
                                    0xFF5B5FEF,
                                  ),
                                ),

                                SizedBox(
                                  width: 7,
                                ),

                                Text(
                                  'Live Map',
                                  style:
                                  TextStyle(
                                    fontWeight:
                                    FontWeight
                                        .bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // ==================================================
                        // BUS MARKER
                        // ==================================================

                        Positioned(
                          left: 150,
                          top: 125,

                          child: _busMarker(
                            selectedBus['status'] ==
                                'Live',
                          ),
                        ),

                        // ==================================================
                        // BUS LABEL
                        // ==================================================

                        Positioned(
                          left: 105,
                          top: 185,

                          child: Container(
                            padding:
                            const EdgeInsets
                                .symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),

                            decoration:
                            BoxDecoration(
                              color: Colors.white,

                              borderRadius:
                              BorderRadius
                                  .circular(
                                10,
                              ),

                              boxShadow: [
                                BoxShadow(
                                  color:
                                  Colors.black
                                      .withValues(
                                    alpha: 0.08,
                                  ),

                                  blurRadius: 8,
                                ),
                              ],
                            ),

                            child: Text(
                              'Bus ${selectedBus['busNumber']}',
                              style:
                              const TextStyle(
                                fontSize: 12,
                                fontWeight:
                                FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        // ==================================================
                        // MAP INFO
                        // ==================================================

                        Positioned(
                          bottom: 15,
                          left: 15,
                          right: 15,

                          child: Container(
                            padding:
                            const EdgeInsets
                                .all(10),

                            decoration:
                            BoxDecoration(
                              color: Colors.white
                                  .withValues(
                                alpha: 0.94,
                              ),

                              borderRadius:
                              BorderRadius
                                  .circular(
                                12,
                              ),
                            ),

                            child: Row(
                              children: [

                                const Icon(
                                  Icons.info_outline,
                                  size: 17,
                                  color:
                                  Color(
                                    0xFF5B5FEF,
                                  ),
                                ),

                                const SizedBox(
                                  width: 7,
                                ),

                                Expanded(
                                  child: Text(
                                    'Selected Bus ${selectedBus['busNumber']} • ${selectedBus['status']}',
                                    style:
                                    const TextStyle(
                                      fontSize: 11,
                                      color:
                                      Color(
                                        0xFF374151,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // ==================================================
                // SELECTED BUS INFORMATION
                // ==================================================

                const Text(
                  'Selected Bus Information',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF111827),
                  ),
                ),

                const SizedBox(height: 12),

                Container(
                  width: double.infinity,

                  padding:
                  const EdgeInsets.all(18),

                  decoration:
                  BoxDecoration(
                    color: Colors.white,

                    borderRadius:
                    BorderRadius.circular(20),

                    boxShadow: [
                      BoxShadow(
                        color:
                        Colors.black.withValues(
                          alpha: 0.06,
                        ),

                        blurRadius: 12,

                        offset:
                        const Offset(0, 5),
                      ),
                    ],
                  ),

                  child: Column(
                    children: [

                      _informationRow(
                        icon:
                        Icons.directions_bus,
                        title:
                        'Bus Number',
                        value:
                        'Bus ${selectedBus['busNumber']}',
                      ),

                      const Divider(
                        height: 22,
                      ),

                      _informationRow(
                        icon:
                        Icons.route_outlined,
                        title:
                        'Route',
                        value:
                        selectedBus['route'],
                      ),

                      const Divider(
                        height: 22,
                      ),

                      _informationRow(
                        icon:
                        Icons.person_outline,
                        title:
                        'Driver',
                        value:
                        selectedBus['driver'],
                      ),

                      const Divider(
                        height: 22,
                      ),

                      _informationRow(
                        icon:
                        Icons.speed_outlined,
                        title:
                        'Speed',
                        value:
                        '${selectedBus['speed']} km/h',
                      ),

                      const Divider(
                        height: 22,
                      ),

                      _informationRow(
                        icon:
                        Icons.access_time,
                        title:
                        'Last Update',
                        value:
                        selectedBus['lastUpdate'],
                      ),

                      const Divider(
                        height: 22,
                      ),

                      _informationRow(
                        icon:
                        Icons.location_on_outlined,
                        title:
                        'Latitude',
                        value:
                        '${selectedBus['latitude']}',
                      ),

                      const Divider(
                        height: 22,
                      ),

                      _informationRow(
                        icon:
                        Icons.explore_outlined,
                        title:
                        'Longitude',
                        value:
                        '${selectedBus['longitude']}',
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // ==================================================
                // GPS STATUS
                // ==================================================

                Container(
                  width: double.infinity,

                  padding:
                  const EdgeInsets.all(16),

                  decoration:
                  BoxDecoration(
                    color:
                    selectedBus['status'] ==
                        'Live'
                        ? const Color(
                      0xFFECFDF5,
                    )
                        : const Color(
                      0xFFFEF2F2,
                    ),

                    borderRadius:
                    BorderRadius.circular(18),

                    border: Border.all(
                      color:
                      selectedBus['status'] ==
                          'Live'
                          ? const Color(
                        0xFFA7F3D0,
                      )
                          : const Color(
                        0xFFFECACA,
                      ),
                    ),
                  ),

                  child: Row(
                    children: [

                      Icon(
                        selectedBus['status'] ==
                            'Live'
                            ? Icons.gps_fixed
                            : Icons.gps_off,

                        color:
                        selectedBus['status'] ==
                            'Live'
                            ? Colors.green
                            : Colors.red,
                      ),

                      const SizedBox(
                        width: 12,
                      ),

                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment
                              .start,

                          children: [

                            Text(
                              selectedBus['status'] ==
                                  'Live'
                                  ? 'GPS is active'
                                  : 'GPS is offline',

                              style:
                              const TextStyle(
                                fontWeight:
                                FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),

                            const SizedBox(
                              height: 3,
                            ),

                            Text(
                              selectedBus['status'] ==
                                  'Live'
                                  ? 'Location is being received from this bus.'
                                  : 'No recent GPS location received from this bus.',

                              style:
                              TextStyle(
                                fontSize: 11,
                                color:
                                Colors.grey
                                    .shade700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // SUMMARY CARD
  // ==========================================================

  Widget _summaryCard({
    required IconData icon,
    required String title,
    required String value,
    required Color iconColor,
  }) {
    return Container(
      padding:
      const EdgeInsets.all(14),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
        BorderRadius.circular(17),

        boxShadow: [
          BoxShadow(
            color:
            Colors.black.withValues(
              alpha: 0.05,
            ),

            blurRadius: 10,

            offset:
            const Offset(0, 4),
          ),
        ],
      ),

      child: Column(
        children: [

          Icon(
            icon,
            color: iconColor,
            size: 25,
          ),

          const SizedBox(height: 7),

          Text(
            value,

            style:
            const TextStyle(
              fontSize: 20,
              fontWeight:
              FontWeight.bold,
            ),
          ),

          const SizedBox(height: 2),

          Text(
            title,

            maxLines: 1,

            overflow:
            TextOverflow.ellipsis,

            style:
            TextStyle(
              fontSize: 10,
              color:
              Colors.grey.shade600,
              fontWeight:
              FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // BUS MARKER
  // ==========================================================

  Widget _busMarker(bool live) {
    return Container(
      width: 58,
      height: 58,

      decoration:
      BoxDecoration(
        shape: BoxShape.circle,

        color: live
            ? const Color(0xFF5B5FEF)
            : Colors.grey,

        boxShadow: [
          BoxShadow(
            color: (live
                ? const Color(0xFF5B5FEF)
                : Colors.grey)
                .withValues(
              alpha: 0.30,
            ),

            blurRadius: 15,

            spreadRadius: 5,
          ),
        ],
      ),

      child: const Icon(
        Icons.directions_bus,
        color: Colors.white,
        size: 28,
      ),
    );
  }

  // ==========================================================
  // INFORMATION ROW
  // ==========================================================

  Widget _informationRow({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Row(
      children: [

        Container(
          width: 42,
          height: 42,

          decoration:
          BoxDecoration(
            color:
            const Color(0xFFEDE9FE),

            borderRadius:
            BorderRadius.circular(
              12,
            ),
          ),

          child: Icon(
            icon,

            color:
            const Color(0xFF5B5FEF),

            size: 21,
          ),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: Text(
            title,

            style:
            TextStyle(
              fontSize: 13,
              color:
              Colors.grey.shade600,
            ),
          ),
        ),

        Flexible(
          child: Text(
            value,

            textAlign:
            TextAlign.right,

            style:
            const TextStyle(
              fontSize: 13,
              fontWeight:
              FontWeight.bold,
              color:
              Color(0xFF111827),
            ),
          ),
        ),
      ],
    );
  }
}

// ============================================================
// MAP BACKGROUND
// ============================================================

class _MapBackgroundPainter
    extends CustomPainter {

  @override
  void paint(
      Canvas canvas,
      Size size,
      ) {

    final roadPaint = Paint()
      ..color =
      const Color(0xFFD1D9E2)
      ..strokeWidth = 2;

    // Horizontal roads.

    for (
    double y = 30;
    y < size.height;
    y += 55
    ) {

      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        roadPaint,
      );
    }

    // Vertical roads.

    for (
    double x = 30;
    x < size.width;
    x += 65
    ) {

      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        roadPaint,
      );
    }

    // Main road.

    final mainRoadPaint = Paint()
      ..color =
      const Color(0xFFB7C3D0)
      ..strokeWidth = 8;

    canvas.drawLine(
      Offset(
        0,
        size.height * 0.80,
      ),

      Offset(
        size.width,
        size.height * 0.20,
      ),

      mainRoadPaint,
    );
  }

  @override
  bool shouldRepaint(
      covariant CustomPainter oldDelegate,
      ) {
    return false;
  }
}
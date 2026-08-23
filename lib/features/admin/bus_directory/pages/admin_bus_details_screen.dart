import 'package:flutter/material.dart';

class AdminBusDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> bus;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const AdminBusDetailsScreen({
    super.key,
    required this.bus,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  State<AdminBusDetailsScreen> createState() =>
      _AdminBusDetailsScreenState();
}

class _AdminBusDetailsScreenState
    extends State<AdminBusDetailsScreen> {

  late List<Map<String, dynamic>> stops;

  @override
  void initState() {
    super.initState();

    stops = List<Map<String, dynamic>>.from(
      widget.bus['stops'] ?? [],
    );
  }

  void _addStop() {
    final nameController =
    TextEditingController();

    final timeController =
    TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            'Add Stop',
          ),
          content: Column(
            mainAxisSize:
            MainAxisSize.min,
            children: [
              TextField(
                controller:
                nameController,
                decoration:
                const InputDecoration(
                  labelText:
                  'Stop Name',
                  prefixIcon:
                  Icon(
                    Icons.location_on_outlined,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              TextField(
                controller:
                timeController,
                decoration:
                const InputDecoration(
                  labelText:
                  'Pickup Time',
                  prefixIcon:
                  Icon(
                    Icons.access_time_outlined,
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                  dialogContext,
                );
              },
              child: const Text(
                'Cancel',
              ),
            ),

            ElevatedButton(
              onPressed: () {
                if (nameController
                    .text
                    .trim()
                    .isEmpty) {
                  return;
                }

                setState(() {
                  stops.add({
                    'name':
                    nameController
                        .text
                        .trim(),
                    'time':
                    timeController
                        .text
                        .trim(),
                  });

                  widget.bus['stops'] =
                      stops;
                });

                Navigator.pop(
                  dialogContext,
                );
              },
              child: const Text(
                'Add',
              ),
            ),
          ],
        );
      },
    );
  }

  void _deleteStop(int index) {
    setState(() {
      stops.removeAt(index);
      widget.bus['stops'] = stops;
    });
  }

  @override
  Widget build(BuildContext context) {
    final driver =
    widget.bus['driver']
    as Map<String, dynamic>?;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.bus['busNumber'] ??
              'Bus Details',
        ),
        actions: [
          IconButton(
            tooltip: 'Edit Bus',
            icon: const Icon(
              Icons.edit_outlined,
            ),
            onPressed: widget.onEdit,
          ),

          IconButton(
            tooltip: 'Delete Bus',
            icon: const Icon(
              Icons.delete_outline,
            ),
            onPressed: widget.onDelete,
          ),
        ],
      ),

      floatingActionButton:
      FloatingActionButton.extended(
        onPressed: _addStop,
        icon: const Icon(
          Icons.add_location_alt_outlined,
        ),
        label: const Text(
          'Add Stop',
        ),
      ),

      body: Container(
        width: double.infinity,

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xffd1fae5),
              Color(0xffe0e7ff),
              Color(0xffcffafe),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            18,
            18,
            18,
            100,
          ),

          child: Column(
            children: [
              // ==================================================
              // BUS INFORMATION
              // ==================================================

              _section(
                title: 'Bus Information',
                icon:
                Icons.directions_bus_outlined,
                children: [
                  _detail(
                    'Bus Number',
                    widget.bus[
                    'busNumber'] ??
                        '',
                  ),

                  _detail(
                    'Registration Number',
                    widget.bus[
                    'registrationNumber'] ??
                        '',
                  ),

                  _detail(
                    'Route',
                    widget.bus[
                    'route'] ??
                        '',
                  ),
                ],
              ),

              const SizedBox(height: 15),

              // ==================================================
              // DRIVER
              // ==================================================

              _section(
                title: 'Driver Information',
                icon:
                Icons.person_outline,
                children: [
                  _detail(
                    'Driver Name',
                    driver?['name'] ??
                        'Not Assigned',
                  ),

                  _detail(
                    'Mobile Number',
                    driver?['mobile'] ??
                        'Not Available',
                  ),
                ],
              ),

              const SizedBox(height: 15),

              // ==================================================
              // TIMINGS
              // ==================================================

              _section(
                title: 'Timings',
                icon:
                Icons.access_time_outlined,
                children: [
                  _detail(
                    'Pickup Time',
                    widget.bus[
                    'pickupTime'] ??
                        '',
                  ),

                  _detail(
                    'Departure',
                    widget.bus[
                    'departureTime'] ??
                        '',
                  ),

                  _detail(
                    'Arrival',
                    widget.bus[
                    'arrivalTime'] ??
                        '',
                  ),
                ],
              ),

              const SizedBox(height: 15),

              // ==================================================
              // STOPS
              // ==================================================

              Container(
                width: double.infinity,
                padding:
                const EdgeInsets.all(18),

                decoration:
                BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                  BorderRadius.circular(
                    22,
                  ),
                ),

                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          color:
                          Colors.deepPurple,
                        ),

                        const SizedBox(
                          width: 9,
                        ),

                        const Text(
                          'Route Stops',
                          style:
                          TextStyle(
                            fontSize: 17,
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 15,
                    ),

                    if (stops.isEmpty)
                      Text(
                        'No stops added.',
                        style:
                        TextStyle(
                          color:
                          Colors.grey.shade600,
                        ),
                      )
                    else
                      ...List.generate(
                        stops.length,
                            (index) {
                          final stop =
                          stops[index];

                          return Container(
                            margin:
                            const EdgeInsets.only(
                              bottom: 9,
                            ),

                            padding:
                            const EdgeInsets.all(
                              12,
                            ),

                            decoration:
                            BoxDecoration(
                              color:
                              const Color(
                                0xfff8fafc,
                              ),
                              borderRadius:
                              BorderRadius
                                  .circular(
                                14,
                              ),
                            ),

                            child: Row(
                              children: [
                                Container(
                                  width: 32,
                                  height: 32,
                                  alignment:
                                  Alignment
                                      .center,
                                  decoration:
                                  BoxDecoration(
                                    color:
                                    const Color(
                                      0xffede9fe,
                                    ),
                                    borderRadius:
                                    BorderRadius
                                        .circular(
                                      10,
                                    ),
                                  ),
                                  child:
                                  Text(
                                    '${index + 1}',
                                    style:
                                    const TextStyle(
                                      fontWeight:
                                      FontWeight.bold,
                                      color:
                                      Colors.deepPurple,
                                    ),
                                  ),
                                ),

                                const SizedBox(
                                  width: 12,
                                ),

                                Expanded(
                                  child:
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        stop[
                                        'name'] ??
                                            '',
                                        style:
                                        const TextStyle(
                                          fontWeight:
                                          FontWeight.w600,
                                        ),
                                      ),

                                      const SizedBox(
                                        height: 3,
                                      ),

                                      Text(
                                        stop[
                                        'time'] ??
                                            '',
                                        style:
                                        TextStyle(
                                          fontSize:
                                          12,
                                          color:
                                          Colors.grey.shade600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                IconButton(
                                  icon:
                                  const Icon(
                                    Icons.delete_outline,
                                    color:
                                    Colors.red,
                                    size: 20,
                                  ),
                                  onPressed: () {
                                    _deleteStop(
                                      index,
                                    );
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _section({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      padding:
      const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
        BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color:
                Colors.deepPurple,
              ),
              const SizedBox(width: 9),
              Text(
                title,
                style:
                const TextStyle(
                  fontSize: 17,
                  fontWeight:
                  FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

          ...children,
        ],
      ),
    );
  }

  Widget _detail(
      String label,
      String value,
      ) {
    return Padding(
      padding:
      const EdgeInsets.only(
        bottom: 12,
      ),
      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 125,
            child: Text(
              label,
              style: TextStyle(
                color:
                Colors.grey.shade600,
                fontSize: 13,
              ),
            ),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Text(
              value,
              style:
              const TextStyle(
                fontSize: 14,
                fontWeight:
                FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
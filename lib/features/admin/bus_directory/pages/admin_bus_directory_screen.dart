import 'package:flutter/material.dart';

import '../widgets/bus_card.dart';
import '../widgets/bus_form_dialog.dart';
import 'admin_bus_details_screen.dart';

class AdminBusDirectoryScreen extends StatefulWidget {
  const AdminBusDirectoryScreen({
    super.key,
  });

  @override
  State<AdminBusDirectoryScreen> createState() =>
      _AdminBusDirectoryScreenState();
}

class _AdminBusDirectoryScreenState
    extends State<AdminBusDirectoryScreen> {
  final TextEditingController searchController =
  TextEditingController();

  String searchText = '';

  late List<Map<String, dynamic>> buses;

  @override
  void initState() {
    super.initState();

    buses = _createDemoBuses();

    searchController.addListener(() {
      setState(() {
        searchText = searchController.text;
      });
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // ============================================================
  // CREATE 24 BUSES
  // ============================================================

  List<Map<String, dynamic>> _createDemoBuses() {
    final routes = [
      'Hospet → Kishkinda University',
      'Gangavathi → Kishkinda University',
      'Koppal → Kishkinda University',
      'Siruguppa → Kishkinda University',
      'Kampli → Kishkinda University',
      'Harapanahalli → Kishkinda University',
    ];

    final drivers = [
      {
        'name': 'Ramesh Kumar',
        'mobile': '9876500001',
      },
      {
        'name': 'Suresh Kumar',
        'mobile': '9876500002',
      },
      {
        'name': 'Mahesh Kumar',
        'mobile': '9876500003',
      },
      {
        'name': 'Basavaraj',
        'mobile': '9876500004',
      },
      {
        'name': 'Shivappa',
        'mobile': '9876500005',
      },
      {
        'name': 'Manjunath',
        'mobile': '9876500006',
      },
    ];

    return List.generate(
      24,
          (index) {
        final busNumber = index + 1;

        return {
          'busNumber': 'Bus $busNumber',

          'registrationNumber':
          'KA 35 AB ${1000 + busNumber}',

          'driver':
          drivers[index % drivers.length],

          'route':
          routes[index % routes.length],

          'pickupTime':
          '07:${30 + (index % 5)} AM',

          'departureTime':
          '08:${00 + (index % 5)} AM',

          'arrivalTime':
          '09:${00 + (index % 5)} AM',

          'stops': [
            {
              'name': 'Main Stop',
              'time': '07:30 AM',
            },
            {
              'name': 'Town Stop',
              'time': '07:45 AM',
            },
            {
              'name': 'University',
              'time': '09:00 AM',
            },
          ],
        };
      },
    );
  }

  // ============================================================
  // SEARCH
  // ============================================================

  List<Map<String, dynamic>> get filteredBuses {
    final search =
    searchText.trim().toLowerCase();

    if (search.isEmpty) {
      return buses;
    }

    return buses.where(
          (bus) {
        final busNumber =
        (bus['busNumber'] ?? '')
            .toString()
            .toLowerCase();

        final registration =
        (bus['registrationNumber'] ?? '')
            .toString()
            .toLowerCase();

        final route =
        (bus['route'] ?? '')
            .toString()
            .toLowerCase();

        final driver =
        bus['driver'] as Map<String, dynamic>?;

        final driverName =
        (driver?['name'] ?? '')
            .toString()
            .toLowerCase();

        return busNumber.contains(search) ||
            registration.contains(search) ||
            route.contains(search) ||
            driverName.contains(search);
      },
    ).toList();
  }

  // ============================================================
  // ADD BUS
  // ============================================================

  Future<void> _addBus() async {
    final result =
    await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (_) => const BusFormDialog(),
    );

    if (result == null) {
      return;
    }

    setState(() {
      buses.add(result);
    });

    _showMessage(
      'Bus added successfully',
    );
  }

  // ============================================================
  // EDIT BUS
  // ============================================================

  Future<void> _editBus(
      Map<String, dynamic> bus,
      ) async {
    final result =
    await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (_) => BusFormDialog(
        bus: bus,
      ),
    );

    if (result == null) {
      return;
    }

    final index = buses.indexOf(bus);

    if (index == -1) {
      return;
    }

    setState(() {
      buses[index] = result;
    });

    _showMessage(
      'Bus information updated',
    );
  }

  // ============================================================
  // DELETE BUS
  // ============================================================

  Future<void> _deleteBus(
      Map<String, dynamic> bus,
      ) async {
    final shouldDelete =
    await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            'Delete Bus?',
          ),
          content: Text(
            'Are you sure you want to remove ${bus['busNumber']}?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                  dialogContext,
                  false,
                );
              },
              child: const Text(
                'Cancel',
              ),
            ),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(
                  dialogContext,
                  true,
                );
              },
              child: const Text(
                'Delete',
              ),
            ),
          ],
        );
      },
    );

    if (shouldDelete != true) {
      return;
    }

    setState(() {
      buses.remove(bus);
    });

    _showMessage(
      'Bus removed',
    );
  }

  void _showMessage(
      String message,
      ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    final filtered =
        filteredBuses;

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addBus,
        icon: const Icon(
          Icons.add,
        ),
        label: const Text(
          'Add Bus',
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

        child: SafeArea(
          child: Column(
            children: [
              // ==================================================
              // HEADER
              // ==================================================

              Padding(
                padding: const EdgeInsets.fromLTRB(
                  10,
                  8,
                  16,
                  10,
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back_rounded,
                      ),
                      onPressed: () {
                        Navigator.pop(
                          context,
                        );
                      },
                    ),

                    const Expanded(
                      child: Text(
                        'Bus Directory',
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 11,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                        BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${buses.length} Buses',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ==================================================
              // SEARCH
              // ==================================================

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                ),
                child: TextField(
                  controller:
                  searchController,
                  decoration: InputDecoration(
                    hintText:
                    'Search bus, registration, driver or route',
                    prefixIcon: const Icon(
                      Icons.search_rounded,
                    ),
                    suffixIcon:
                    searchController.text.isNotEmpty
                        ? IconButton(
                      icon: const Icon(
                        Icons.clear,
                      ),
                      onPressed: () {
                        searchController.clear();
                      },
                    )
                        : null,
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.circular(18),
                      borderSide:
                      BorderSide.none,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // ==================================================
              // BUS LIST
              // ==================================================

              Expanded(
                child: filtered.isEmpty
                    ? _emptyState()
                    : ListView.builder(
                  padding:
                  const EdgeInsets.fromLTRB(
                    18,
                    0,
                    18,
                    100,
                  ),
                  itemCount:
                  filtered.length,
                  itemBuilder:
                      (context, index) {
                    final bus =
                    filtered[index];

                    return Dismissible(
                      key: ValueKey(
                        '${bus['busNumber']}_${bus['registrationNumber']}',
                      ),

                      direction:
                      DismissDirection.endToStart,

                      confirmDismiss:
                          (_) async {
                        await _deleteBus(
                          bus,
                        );
                        return false;
                      },

                      background:
                      Container(
                        margin:
                        const EdgeInsets.only(
                          bottom: 12,
                        ),
                        decoration:
                        BoxDecoration(
                          color: Colors.red,
                          borderRadius:
                          BorderRadius.circular(
                            20,
                          ),
                        ),
                        alignment:
                        Alignment.centerRight,
                        padding:
                        const EdgeInsets.only(
                          right: 25,
                        ),
                        child:
                        const Icon(
                          Icons.delete_outline,
                          color:
                          Colors.white,
                          size: 30,
                        ),
                      ),

                      child: BusCard(
                        bus: bus,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  AdminBusDetailsScreen(
                                    bus: bus,
                                    onEdit: () {
                                      Navigator.pop(
                                        context,
                                      );
                                      _editBus(
                                        bus,
                                      );
                                    },
                                    onDelete: () {
                                      Navigator.pop(
                                        context,
                                      );
                                      _deleteBus(
                                        bus,
                                      );
                                    },
                                  ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _emptyState() {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(25),
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
          BorderRadius.circular(22),
        ),
        child: Column(
          mainAxisSize:
          MainAxisSize.min,
          children: [
            Icon(
              Icons.directions_bus_outlined,
              size: 60,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 15),
            const Text(
              'No Buses Found',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Try another search.',
              style: TextStyle(
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
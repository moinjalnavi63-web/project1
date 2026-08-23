import 'package:flutter/material.dart';

import '../data/demo_student_directory.dart';
import '../widgets/admin_bus_directory_card.dart';
import 'admin_bus_directory_students_screen.dart';

class AdminStudentDirectoryScreen extends StatefulWidget {
  const AdminStudentDirectoryScreen({
    super.key,
  });

  @override
  State<AdminStudentDirectoryScreen> createState() =>
      _AdminStudentDirectoryScreenState();
}

class _AdminStudentDirectoryScreenState
    extends State<AdminStudentDirectoryScreen> {
  final TextEditingController searchController =
  TextEditingController();

  late final List<DirectoryBus> buses;

  @override
  void initState() {
    super.initState();

    buses = DemoStudentDirectory.buses;

    searchController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  List<DirectoryBus> get filteredBuses {
    final search =
    searchController.text.trim().toLowerCase();

    if (search.isEmpty) {
      return buses;
    }

    return buses.where((bus) {
      return bus.busNumber
          .toLowerCase()
          .contains(search) ||
          bus.route
              .toLowerCase()
              .contains(search);
    }).toList();
  }

  int get totalStudents {
    return buses.fold(
      0,
          (total, bus) =>
      total +
          bus.stops.fold(
            0,
                (stopTotal, stop) =>
            stopTotal + stop.students.length,
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final displayedBuses = filteredBuses;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Student Directory',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,

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
              const SizedBox(height: 10),

              // =================================================
              // HEADER
              // =================================================

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Student Directory',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 4),

                          Text(
                            'Students organized by bus and pickup stop',
                            style: TextStyle(
                              color: Colors.grey.shade700,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                        BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Text(
                            '${buses.length}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                          Text(
                            'Buses',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // =================================================
              // SEARCH
              // =================================================

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                ),
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: 'Search bus number or route',
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
                      BorderRadius.circular(17),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // =================================================
              // STUDENT COUNT
              // =================================================

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                ),
                child: Row(
                  children: [
                    Text(
                      '${displayedBuses.length} buses',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const Spacer(),

                    Text(
                      '$totalStudents students',
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // =================================================
              // BUS LIST
              // =================================================

              Expanded(
                child: displayedBuses.isEmpty
                    ? _emptyState()
                    : ListView.builder(
                  padding:
                  const EdgeInsets.fromLTRB(
                    18,
                    5,
                    18,
                    30,
                  ),
                  itemCount:
                  displayedBuses.length,
                  itemBuilder:
                      (context, index) {
                    final bus =
                    displayedBuses[index];

                    return AdminBusDirectoryCard(
                      bus: bus,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                AdminBusDirectoryStudentsScreen(
                                  bus: bus,
                                ),
                          ),
                        );
                      },
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
          borderRadius: BorderRadius.circular(22),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              'Try a different bus number or route.',
              textAlign: TextAlign.center,
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
import 'package:flutter/material.dart';

import '../data/demo_student_directory.dart';
import '../widgets/admin_stop_section.dart';

class AdminBusDirectoryStudentsScreen
    extends StatefulWidget {
  final DirectoryBus bus;

  const AdminBusDirectoryStudentsScreen({
    super.key,
    required this.bus,
  });

  @override
  State<AdminBusDirectoryStudentsScreen> createState() =>
      _AdminBusDirectoryStudentsScreenState();
}

class _AdminBusDirectoryStudentsScreenState
    extends State<AdminBusDirectoryStudentsScreen> {
  final TextEditingController searchController =
  TextEditingController();

  @override
  void initState() {
    super.initState();

    searchController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  List<DirectoryStop> get filteredStops {
    final search =
    searchController.text.trim().toLowerCase();

    if (search.isEmpty) {
      return widget.bus.stops;
    }

    return widget.bus.stops
        .map((stop) {
      final filteredStudents =
      stop.students.where((student) {
        return student.name
            .toLowerCase()
            .contains(search) ||
            student.usn
                .toLowerCase()
                .contains(search) ||
            student.branch
                .toLowerCase()
                .contains(search) ||
            student.year
                .toLowerCase()
                .contains(search);
      }).toList();

      return DirectoryStop(
        name: stop.name,
        students: filteredStudents,
      );
    })
        .where((stop) => stop.students.isNotEmpty)
        .toList();
  }

  int get totalStudents {
    return widget.bus.stops.fold(
      0,
          (total, stop) =>
      total + stop.students.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    final stops = filteredStops;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.bus.busNumber,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
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
              // BUS INFORMATION
              // =================================================

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                ),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                    BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          gradient:
                          const LinearGradient(
                            colors: [
                              Color(0xff6366f1),
                              Color(0xff8b5cf6),
                            ],
                          ),
                          borderRadius:
                          BorderRadius.circular(15),
                        ),
                        child: const Icon(
                          Icons.directions_bus_rounded,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),

                      const SizedBox(width: 13),

                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.bus.busNumber,
                              style: const TextStyle(
                                fontSize: 19,
                                fontWeight:
                                FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 4),

                            Text(
                              widget.bus.route,
                              style: TextStyle(
                                fontSize: 12,
                                color:
                                Colors.grey.shade600,
                              ),
                            ),

                            const SizedBox(height: 7),

                            Text(
                              '$totalStudents students • ${widget.bus.stops.length} stops',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight:
                                FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 14),

              // =================================================
              // SEARCH STUDENTS
              // =================================================

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                ),
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText:
                    'Search student name, USN, branch or year',
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

              const SizedBox(height: 14),

              // =================================================
              // STOP LIST
              // =================================================

              Expanded(
                child: stops.isEmpty
                    ? _emptyState()
                    : ListView.builder(
                  padding:
                  const EdgeInsets.fromLTRB(
                    18,
                    5,
                    18,
                    30,
                  ),
                  itemCount: stops.length,
                  itemBuilder:
                      (context, index) {
                    return AdminStopSection(
                      stop: stops[index],
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
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.person_search_outlined,
              size: 60,
              color: Colors.grey.shade400,
            ),

            const SizedBox(height: 15),

            const Text(
              'No Students Found',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              'No student matches your search.',
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
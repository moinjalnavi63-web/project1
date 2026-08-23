import 'package:flutter/material.dart';

import '../data/bus_data.dart';
import '../models/bus_model.dart';

import '../widgets/bus_card.dart';
import '../widgets/search_bar_widget.dart';

import 'bus_details_screen.dart';

class BusDirectoryScreen extends StatefulWidget {
  const BusDirectoryScreen({super.key});

  @override
  State<BusDirectoryScreen> createState() =>
      _BusDirectoryScreenState();
}

class _BusDirectoryScreenState
    extends State<BusDirectoryScreen> {

  final TextEditingController searchController =
  TextEditingController();

  List<BusModel> filteredBuses = busList;

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void searchBus(String value) {

    setState(() {

      filteredBuses = busList.where((bus) {

        final query = value.toLowerCase();

        return bus.busNumber
            .toString()
            .contains(query) ||

            bus.driverName
                .toLowerCase()
                .contains(query) ||

            bus.routeName
                .toLowerCase()
                .contains(query) ||

            bus.stops.any(
                  (stop) => stop.name
                  .toLowerCase()
                  .contains(query),
            );

      }).toList();

    });
  }

  @override
  Widget build(BuildContext context) {

    return Container(

      decoration: const BoxDecoration(

        gradient: LinearGradient(

          begin: Alignment.topLeft,
          end: Alignment.bottomRight,

          colors: [

            Color(0xFFD1FAE5),

            Color(0xFFE0E7FF),

            Color(0xFFCFFAFE),

          ],
        ),
      ),

      child: Column(

        children: [

          Padding(

            padding: const EdgeInsets.all(16),

            child: SearchBarWidget(

              controller: searchController,

              onChanged: searchBus,

            ),
          ),

          Expanded(

            child: filteredBuses.isEmpty

                ? const Center(

              child: Text(

                "No buses found",

                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )

                : ListView.builder(

              itemCount: filteredBuses.length,

              itemBuilder: (context, index) {

                final bus = filteredBuses[index];

                return BusCard(

                  bus: bus,

                  onTap: () {

                    Navigator.push(

                      context,

                      MaterialPageRoute(

                        builder: (_) =>
                            BusDetailsScreen(
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
    );
  }
}
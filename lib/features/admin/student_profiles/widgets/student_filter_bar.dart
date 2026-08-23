import 'package:flutter/material.dart';

class StudentFilterBar extends StatelessWidget {
  final TextEditingController searchController;

  final String selectedBranch;
  final String selectedYear;
  final String selectedBus;

  final ValueChanged<String> onSearchChanged;
  final ValueChanged<String> onBranchChanged;
  final ValueChanged<String> onYearChanged;
  final ValueChanged<String> onBusChanged;

  const StudentFilterBar({
    super.key,
    required this.searchController,
    required this.selectedBranch,
    required this.selectedYear,
    required this.selectedBus,
    required this.onSearchChanged,
    required this.onBranchChanged,
    required this.onYearChanged,
    required this.onBusChanged,
  });

  static const List<String> branches = [
    'All',
    'CSE',
    'ISE',
    'ECE',
    'EEE',
    'AIML',
    'AIDS',
    'MECH',
    'CIVIL',
  ];

  static const List<String> years = [
    'All',
    '1st Year',
    '2nd Year',
    '3rd Year',
    '4th Year',
  ];

  // ==========================
  // ALL 24 BUSES
  // ==========================

  static const List<String> buses = [
    'All',
    'Bus 1',
    'Bus 2',
    'Bus 3',
    'Bus 4',
    'Bus 5',
    'Bus 6',
    'Bus 7',
    'Bus 8',
    'Bus 9',
    'Bus 10',
    'Bus 11',
    'Bus 12',
    'Bus 13',
    'Bus 14',
    'Bus 15',
    'Bus 16',
    'Bus 17',
    'Bus 18',
    'Bus 19',
    'Bus 20',
    'Bus 21',
    'Bus 22',
    'Bus 23',
    'Bus 24',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        // ==========================
        // SINGLE SEARCH FIELD
        // ==========================

        TextField(
          controller: searchController,
          onChanged: onSearchChanged,
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            hintText: 'Search by student name or USN',
            prefixIcon: const Icon(
              Icons.search_rounded,
            ),
            suffixIcon: searchController.text.isNotEmpty
                ? IconButton(
              icon: const Icon(
                Icons.clear_rounded,
              ),
              onPressed: () {
                searchController.clear();
                onSearchChanged('');
              },
            )
                : null,
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 15,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
          ),
        ),

        const SizedBox(height: 14),

        // ==========================
        // FILTERS
        // ==========================

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // BRANCH
            Expanded(
              child: _buildDropdown(
                value: selectedBranch,
                label: 'Branch',
                icon: Icons.school_outlined,
                items: branches,
                onChanged: onBranchChanged,
              ),
            ),

            const SizedBox(width: 8),

            // YEAR
            Expanded(
              child: _buildDropdown(
                value: selectedYear,
                label: 'Year',
                icon: Icons.calendar_month_outlined,
                items: years,
                onChanged: onYearChanged,
              ),
            ),

            const SizedBox(width: 8),

            // BUS
            Expanded(
              child: _buildDropdown(
                value: selectedBus,
                label: 'Bus',
                icon: Icons.directions_bus_outlined,
                items: buses,
                onChanged: onBusChanged,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDropdown({
    required String value,
    required String label,
    required IconData icon,
    required List<String> items,
    required ValueChanged<String> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      isExpanded: true,

      icon: const Icon(
        Icons.keyboard_arrow_down_rounded,
        size: 20,
      ),

      decoration: InputDecoration(
        labelText: label,
        floatingLabelBehavior: FloatingLabelBehavior.always,

        prefixIcon: Icon(
          icon,
          size: 20,
        ),

        filled: true,
        fillColor: Colors.white,

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 14,
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(19),
          borderSide: BorderSide.none,
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Colors.deepPurple,
            width: 1.3,
          ),
        ),
      ),

      items: items.map(
            (item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(
              item,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        },
      ).toList(),

      onChanged: (value) {
        if (value != null) {
          onChanged(value);
        }
      },
    );
  }
}
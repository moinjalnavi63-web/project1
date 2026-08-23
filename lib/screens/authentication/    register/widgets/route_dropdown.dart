import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

class RouteDropdown extends StatelessWidget {
  final List<String> routes;
  final String? selectedRoute;
  final ValueChanged<String?> onChanged;

  const RouteDropdown({
    super.key,
    required this.routes,
    required this.selectedRoute,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: DropdownSearch<String>(
        items: (filter, infiniteScrollProps) => routes,
        selectedItem: selectedRoute,
        onChanged: onChanged,
        popupProps: const PopupProps.menu(
          showSearchBox: true,
          searchFieldProps: TextFieldProps(
            decoration: InputDecoration(
              hintText: "Search Route",
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ),
        decoratorProps: DropDownDecoratorProps(
          decoration: InputDecoration(
            labelText: "Route",
            hintText: "Select Route",
            prefixIcon: const Icon(Icons.route),
            filled: true,
            fillColor: Colors.white.withValues(alpha: 0.95),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: const BorderSide(
                color: Colors.indigo,
                width: 2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
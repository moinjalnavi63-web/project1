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
      padding: const EdgeInsets.only(bottom: 16),
      child: DropdownSearch<String>(
        items: (filter, infiniteScrollProps) => routes,
        selectedItem: selectedRoute,
        onChanged: onChanged,
        popupProps: const PopupProps.menu(
          showSearchBox: true,
        ),
        decoratorProps: const DropDownDecoratorProps(
          decoration: InputDecoration(
            labelText: "Route",
            prefixIcon: Icon(Icons.route),
            border: OutlineInputBorder(),
          ),
        ),
      ),
    );
  }
}
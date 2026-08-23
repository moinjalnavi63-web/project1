import 'package:flutter/material.dart';
import '../../../../widgets/custom_radio_selector.dart';

class IdentitySelector extends StatelessWidget {
  final String selectedIdentity;
  final ValueChanged<String> onChanged;

  const IdentitySelector({
    super.key,
    required this.selectedIdentity,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Select Identity",
          style: Theme.of(context).textTheme.titleMedium,
        ),

        const SizedBox(height: 10),

        // STUDENT
        CustomRadioSelector(
          title: "Student",
          value: "Student",
          groupValue: selectedIdentity,
          icon: Icons.school_outlined,
          onChanged: (value) {
            if (value != null) {
              onChanged(value);
            }
          },
        ),

        // FACULTY
        CustomRadioSelector(
          title: "Faculty",
          value: "Faculty",
          groupValue: selectedIdentity,
          icon: Icons.badge_outlined,
          onChanged: (value) {
            if (value != null) {
              onChanged(value);
            }
          },
        ),

        // DRIVER
        CustomRadioSelector(
          title: "Driver",
          value: "Driver",
          groupValue: selectedIdentity,
          icon: Icons.directions_bus_outlined,
          onChanged: (value) {
            if (value != null) {
              onChanged(value);
            }
          },
        ),
      ],
    );
  }
}
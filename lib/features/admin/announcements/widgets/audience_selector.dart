import 'package:flutter/material.dart';

class AudienceSelector
    extends StatelessWidget {
  final String value;
  final ValueChanged<String> onChanged;

  const AudienceSelector({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    const audiences = [
      'Everyone',
      'All Students',
      'Specific Bus',
      'Specific Route',
      'Specific Stop',
      'Specific Branch',
      'Specific Year',
      'Drivers',
      'Faculty',
    ];

    return DropdownButtonFormField<String>(
      initialValue: value,
      isExpanded: true,
      decoration: InputDecoration(
        labelText: 'Target Audience',
        filled: true,
        fillColor: Colors.white,
        prefixIcon: const Icon(
          Icons.groups_outlined,
        ),
        border: OutlineInputBorder(
          borderRadius:
          BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
      items: audiences.map(
            (audience) {
          return DropdownMenuItem<String>(
            value: audience,
            child: Text(audience),
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
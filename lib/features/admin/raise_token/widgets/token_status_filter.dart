import 'package:flutter/material.dart';

import '../models/admin_token_model.dart';

class TokenStatusFilter extends StatelessWidget {
  final AdminTokenCategory? selectedCategory;
  final AdminTokenStatus? selectedStatus;

  final ValueChanged<AdminTokenCategory?>
  onCategoryChanged;

  final ValueChanged<AdminTokenStatus?>
  onStatusChanged;

  const TokenStatusFilter({
    super.key,
    required this.selectedCategory,
    required this.selectedStatus,
    required this.onCategoryChanged,
    required this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _dropdown<AdminTokenCategory?>(
            value: selectedCategory,
            label: 'Category',
            items: [
              const DropdownMenuItem<AdminTokenCategory?>(
                value: null,
                child: Text('All Categories'),
              ),

              ...AdminTokenCategory.values.map(
                    (category) {
                  return DropdownMenuItem<
                      AdminTokenCategory?>(
                    value: category,
                    child: Text(
                      category.title,
                      overflow:
                      TextOverflow.ellipsis,
                    ),
                  );
                },
              ),
            ],
            onChanged: onCategoryChanged,
          ),
        ),

        const SizedBox(width: 10),

        Expanded(
          child: _dropdown<AdminTokenStatus?>(
            value: selectedStatus,
            label: 'Status',
            items: [
              const DropdownMenuItem<AdminTokenStatus?>(
                value: null,
                child: Text('All Status'),
              ),

              ...AdminTokenStatus.values.map(
                    (status) {
                  return DropdownMenuItem<
                      AdminTokenStatus?>(
                    value: status,
                    child: Text(
                      status.title,
                      overflow:
                      TextOverflow.ellipsis,
                    ),
                  );
                },
              ),
            ],
            onChanged: onStatusChanged,
          ),
        ),
      ],
    );
  }

  Widget _dropdown<T>({
    required T value,
    required String label,
    required List<DropdownMenuItem<T>> items,
    required ValueChanged<T?> onChanged,
  }) {
    return DropdownButtonFormField<T>(
      initialValue: value,

      isExpanded: true,

      decoration: InputDecoration(
        labelText: label,

        filled: true,
        fillColor: Colors.white,

        contentPadding:
        const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 5,
        ),

        border: OutlineInputBorder(
          borderRadius:
          BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),

      items: items,

      onChanged: onChanged,
    );
  }
}
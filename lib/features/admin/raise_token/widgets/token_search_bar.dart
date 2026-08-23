import 'package:flutter/material.dart';

class TokenSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;

  const TokenSearchBar({
    super.key,
    required this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      textInputAction: TextInputAction.search,

      decoration: InputDecoration(
        hintText: 'Search token, student name or USN',

        prefixIcon: const Icon(
          Icons.search_rounded,
        ),

        suffixIcon: controller.text.isNotEmpty
            ? IconButton(
          icon: const Icon(
            Icons.clear_rounded,
          ),
          onPressed: () {
            controller.clear();
            onChanged?.call('');
          },
        )
            : null,

        filled: true,
        fillColor: Colors.white,

        contentPadding:
        const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 15,
        ),

        border: OutlineInputBorder(
          borderRadius:
          BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
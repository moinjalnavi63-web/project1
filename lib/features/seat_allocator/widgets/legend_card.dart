import 'package:flutter/material.dart';

class LegendCard extends StatelessWidget {
  const LegendCard({super.key});

  Widget legendItem(Color color, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Wrap(
          spacing: 20,
          runSpacing: 12,
          alignment: WrapAlignment.center,
          children: [
            legendItem(Colors.blue, "Faculty"),
            legendItem(Colors.pink, "Girls"),
            legendItem(Colors.green, "Boys"),
            legendItem(Colors.grey, "Available"),
            legendItem(Colors.red, "Occupied"),
          ],
        ),
      ),
    );
  }
}
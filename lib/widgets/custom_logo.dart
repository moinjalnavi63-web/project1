import 'package:flutter/material.dart';

class CustomLogo extends StatelessWidget {
  final double size;
  final String image;

  const CustomLogo({
    super.key,
    required this.image,
    this.size = 150,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.35),
        borderRadius: BorderRadius.circular(size),
        border: Border.all(
          color: Colors.white.withOpacity(0.5),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipOval(
        child: Image.asset(
          image,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
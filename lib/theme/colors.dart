import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color primary = Color(0xFF5B5FEF);
  static const Color secondary = Color(0xFF14B8A6);

  static const Color white = Colors.white;
  static const Color black = Color(0xFF1F2937);

  static const Color textPrimary = Color(0xFF1F2937);
  static const Color textSecondary = Color(0xFF6B7280);

  static const Color cardColor = Colors.white;

  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFD1FAE5),
      Color(0xFFE0E7FF),
      Color(0xFFCFFAFE),
    ],
  );

  static const LinearGradient buttonGradient = LinearGradient(
    colors: [
      Color(0xFF5B5FEF),
      Color(0xFF14B8A6),
    ],
  );
}
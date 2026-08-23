import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/welcome/welcome_screen.dart';
import 'features/seat_allocator/pages/seat_allocator_screen.dart';

class KUBTransportApp extends StatelessWidget {
  const KUBTransportApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kishkinda University Transport',
      theme: AppTheme.lightTheme,
      routes: {
        "/seatAllocator": (_) => const SeatAllocatorScreen(),
      },

      home: const WelcomeScreen(),
    );
  }
}
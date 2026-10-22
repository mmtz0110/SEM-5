import 'package:flutter/material.dart';

import '../routes/app_routes.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(28, 32, 28, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              Container(
                width: 74,
                height: 74,
                decoration: BoxDecoration(
                  color: const Color(0xFFC76645),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Icon(
                  Icons.explore_outlined,
                  color: Colors.white,
                  size: 38,
                ),
              ),
              const SizedBox(height: 28),
              const Text(
                'NusaTravel',
                style: TextStyle(
                  color: Color(0xFF173B35),
                  fontSize: 44,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -1.5,
                ),
              ),
              const SizedBox(height: 12),
              const SizedBox(
                width: 340,
                child: Text(
                  'Rencanakan jeda yang berarti, mulai dari pulau-pulau Indonesia.',
                  style: TextStyle(
                    color: Color(0xFF52645D),
                    fontSize: 18,
                    height: 1.45,
                  ),
                ),
              ),
              const SizedBox(height: 48),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: FilledButton(
                  onPressed: () => Navigator.pushReplacementNamed(
                    context,
                    AppRoutes.home,
                  ),
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF173B35),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Mulai Eksplorasi',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              const Spacer(),
              const Text(
                'PERJALANAN YANG LEBIH PERSONAL',
                style: TextStyle(
                  color: Color(0xFFC76645),
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.8,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

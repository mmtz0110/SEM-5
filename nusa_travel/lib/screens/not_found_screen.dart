import 'package:flutter/material.dart';

import '../routes/app_routes.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({this.routeName, super.key});

  final String? routeName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                '404',
                style: TextStyle(
                  color: Color(0xFFC76645),
                  fontSize: 88,
                  fontWeight: FontWeight.w900,
                  height: 1,
                ),
              ),
              const SizedBox(height: 18),
              const Text(
                'Halaman tidak ditemukan',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF173B35),
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                routeName == null
                    ? 'Rute yang Anda tuju tidak tersedia.'
                    : 'Rute "$routeName" tidak tersedia.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF52645D),
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 28),
              FilledButton(
                onPressed: () => Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.home,
                  (route) => false,
                ),
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF173B35),
                ),
                child: const Text('Kembali ke beranda'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

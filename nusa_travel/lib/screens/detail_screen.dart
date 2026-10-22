import 'package:flutter/material.dart';

import '../models/tour_package.dart';
import '../routes/app_routes.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({required this.package, super.key});

  final TourPackage package;

  String _formatPrice(int price) {
    final digits = price.toString();
    final parts = <String>[];
    for (var end = digits.length; end > 0; end -= 3) {
      final start = (end - 3).clamp(0, digits.length);
      parts.insert(0, digits.substring(start, end));
    }
    return 'Rp ${parts.join('.')} / peserta';
  }

  Future<void> _openBooking(BuildContext context) async {
    final booked = await Navigator.pushNamed<bool>(
      context,
      AppRoutes.booking,
      arguments: package,
    );
    if (context.mounted && booked == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Pemesanan ${package.title} berhasil dikirim.'),
          behavior: SnackBarBehavior.floating,
          backgroundColor: const Color(0xFF173B35),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail perjalanan')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Image.network(
              package.imageUrl,
              height: 270,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => Container(
                height: 270,
                color: const Color(0xFFD7E0D5),
                child: const Icon(
                  Icons.landscape_outlined,
                  size: 64,
                  color: Color(0xFF173B35),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            package.title,
            style: const TextStyle(
              color: Color(0xFF173B35),
              fontSize: 34,
              fontWeight: FontWeight.w800,
              letterSpacing: -1,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _formatPrice(package.price),
            style: const TextStyle(
              color: Color(0xFFC76645),
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 22),
          Text(
            package.description,
            style: const TextStyle(
              color: Color(0xFF52645D),
              fontSize: 17,
              height: 1.55,
            ),
          ),
          const SizedBox(height: 30),
          SizedBox(
            height: 56,
            child: FilledButton(
              onPressed: () => _openBooking(context),
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFF173B35),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text(
                'Pesan perjalanan ini',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

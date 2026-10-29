import 'package:flutter/material.dart';

class VenueMapViewer extends StatelessWidget {
  const VenueMapViewer({super.key});

  @override
  Widget build(BuildContext context) => InteractiveViewer(
    minScale: .7,
    maxScale: 3.5,
    boundaryMargin: const EdgeInsets.all(40),
    child: Center(
      child: Container(
        width: 560,
        height: 330,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
        ),
        child: Column(
          children: [
            const Text('DENAH VENUE', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2)),
            const SizedBox(height: 14),
            Expanded(
              child: Row(
                children: [
                  _Room(label: 'AUDITORIUM\nNUSANTARA', flex: 2, color: const Color(0xff6d5dfc)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      children: [
                        _Room(label: 'LAB INOVASI 1', color: const Color(0xff168aad)),
                        const SizedBox(height: 10),
                        _Room(label: 'LAB INOVASI 2', color: const Color(0xff168aad)),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      children: [
                        _Room(label: 'RUANG GARUDA', color: const Color(0xffe07a5f)),
                        const SizedBox(height: 10),
                        _Room(label: 'RUANG MERAPI', color: const Color(0xff2a9d8f)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(height: 28, alignment: Alignment.center, color: Theme.of(context).colorScheme.primaryContainer, child: const Text('LOBBY & REGISTRASI')),
          ],
        ),
      ),
    ),
  );
}

class _Room extends StatelessWidget {
  const _Room({required this.label, required this.color, this.flex = 1});
  final String label;
  final Color color;
  final int flex;

  @override
  Widget build(BuildContext context) => Expanded(
    flex: flex,
    child: Container(
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: color.withValues(alpha: .18), border: Border.all(color: color), borderRadius: BorderRadius.circular(12)),
      child: Text(label, textAlign: TextAlign.center, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.bold)),
    ),
  );
}

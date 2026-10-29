import 'package:flutter/material.dart';

import '../widgets/venue_map_viewer.dart';

class VenueGalleryScreen extends StatelessWidget {
  const VenueGalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = [
      const Color(0xff302b63),
      const Color(0xff168aad),
      const Color(0xffe07a5f),
      const Color(0xff2a9d8f),
      const Color(0xff9b5de5),
      const Color(0xff457b9d),
    ];
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: _VenueHeaderCard(
              title: 'Venue & Galeri',
              subtitle: 'Jelajahi ruang dan cerita di balik acara',
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 18, 16, 140),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Text(
                  'Denah interaktif',
                  style: Theme.of(context).textTheme.titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  'Cubit untuk zoom dan geser denah untuk melihat setiap ruang.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 12),
                LayoutBuilder(
                  builder: (context, constraints) {
                    // Tinggi dibatasi agar InteractiveViewer tidak mengambil
                    // gesture scroll parent pada layar pendek.
                    final height = (MediaQuery.sizeOf(context).height * .35)
                        .clamp(220.0, 360.0)
                        .toDouble();
                    return SizedBox(
                      height: height,
                      child: ClipPath(
                        clipper: _AsymmetricClipper(),
                        child: ColoredBox(
                          color: Theme.of(context)
                              .colorScheme
                              .surfaceContainerHighest,
                          child: const VenueMapViewer(),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 28),
                Text(
                  'Poster acara',
                  style: Theme.of(context).textTheme.titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: colors.length,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 220,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: .82,
                  ),
                  itemBuilder: (context, index) => _PosterCard(
                    color: colors[index],
                    number: index + 1,
                    tall: index.isOdd,
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _PosterCard extends StatelessWidget {
  const _PosterCard({
    required this.color,
    required this.number,
    required this.tall,
  });

  final Color color;
  final int number;
  final bool tall;

  @override
  Widget build(BuildContext context) => Card(
    clipBehavior: Clip.antiAlias,
    child: Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [color, color.withValues(alpha: .62)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.auto_awesome, color: Colors.white70),
          if (tall) const Spacer(),
          const Spacer(),
          const Text(
            'NUSA TECH\nFEST',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w900,
              height: .95,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '2025  •  $number',
            style: const TextStyle(color: Colors.white70),
          ),
        ],
      ),
    ),
  );
}

class _VenueHeaderCard extends StatelessWidget {
  const _VenueHeaderCard({required this.title, required this.subtitle});
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 112,
    child: ClipPath(
      clipper: _AsymmetricClipper(),
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 28, 20, 18),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.tertiary,
            ],
          ),
        ),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Opacity(
            opacity: 1,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(subtitle, style: const TextStyle(color: Colors.white70)),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

class _AsymmetricClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) => Path()
    ..moveTo(0, 0)
    ..lineTo(size.width, 0)
    ..lineTo(size.width, size.height - 28)
    ..quadraticBezierTo(
      size.width * .72,
      size.height,
      size.width * .35,
      size.height - 8,
    )
    ..quadraticBezierTo(size.width * .12, size.height - 20, 0, size.height)
    ..close();

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

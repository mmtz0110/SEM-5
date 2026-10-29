import 'package:flutter/material.dart';

import '../data/sample_events.dart';
import '../models/registration_ticket.dart';
import '../widgets/event_card.dart';
import '../widgets/filter_bottom_sheet.dart';
import 'event_registration_screen.dart';

class HomeEventsScreen extends StatefulWidget {
  const HomeEventsScreen({super.key, required this.onRegistered});
  final void Function(RegistrationTicket ticket) onRegistered;

  @override
  State<HomeEventsScreen> createState() => _HomeEventsScreenState();
}

class _HomeEventsScreenState extends State<HomeEventsScreen> {
  String category = 'Semua';

  @override
  Widget build(BuildContext context) {
    final events = category == 'Semua'
        ? sampleEvents
        : sampleEvents.where((event) => event.category == category).toList();
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: _EventHeaderCard(
              onFilter: () async {
                final result = await showCategoryFilter(context, category);
                if (result != null && mounted)
                  setState(() => category = result);
              },
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 18, 16, 140),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _BentoIntro(onExplore: () => setState(() => category = 'AI')),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Pilihan untukmu',
                      style: Theme.of(context).textTheme.titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text('${events.length} acara'),
                  ],
                ),
                const SizedBox(height: 12),
                if (category != 'Semua')
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: InputChip(
                      label: Text(category),
                      onDeleted: () => setState(() => category = 'Semua'),
                    ),
                  ),
                for (final event in events)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: EventCard(
                      event: event,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => EventRegistrationScreen(
                            event: event,
                            onRegistered: widget.onRegistered,
                          ),
                        ),
                      ),
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

class _BentoIntro extends StatelessWidget {
  const _BentoIntro({required this.onExplore});
  final VoidCallback onExplore;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final compact = constraints.maxWidth < 430;
      final cardHeight = compact ? 132.0 : 150.0;
      return Column(
        children: [
          SizedBox(
            height: cardHeight,
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: _BentoTile(
                    height: cardHeight,
                    color: const Color(0xff302b63),
                    eyebrow: 'NUSA TECH FEST',
                    title: 'Ide besar\n dimulai hari ini.',
                    icon: Icons.auto_awesome,
                    onTap: onExplore,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 2,
                  child: _BentoTile(
                    height: cardHeight,
                    color: const Color(0xffe07a5f),
                    eyebrow: '12—14 JUN',
                    title: '3 hari\ninspirasi',
                    icon: Icons.calendar_month,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 92,
            child: Row(
              children: [
                Expanded(
                  child: _BentoTile(
                    height: 92,
                    color: const Color(0xff168aad),
                    eyebrow: '4 KATEGORI',
                    title: 'AI • Mobile • IoT • Cyber',
                    icon: Icons.hub_outlined,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _BentoTile(
                    height: 92,
                    color: const Color(0xff2a9d8f),
                    eyebrow: 'VENUE',
                    title: 'Gedung Nusantara',
                    icon: Icons.location_on_outlined,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}

class _BentoTile extends StatelessWidget {
  const _BentoTile({
    required this.height,
    required this.color,
    required this.eyebrow,
    required this.title,
    required this.icon,
    this.onTap,
  });
  final double height;
  final Color color;
  final String eyebrow;
  final String title;
  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final compact = height < 110;
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Container(
          height: height,
          padding: const EdgeInsets.fromLTRB(16, 15, 16, 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [color, color.withValues(alpha: .68)],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: Colors.white70),
              const Spacer(),
              Text(
                eyebrow,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                title,
                maxLines: compact ? 1 : 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: compact ? 14 : 18,
                  fontWeight: FontWeight.w800,
                  height: 1.05,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EventHeaderCard extends StatelessWidget {
  const _EventHeaderCard({required this.onFilter});
  final VoidCallback onFilter;

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 112,
    child: ClipPath(
      clipper: _HeaderClipper(),
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 28, 16, 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.tertiary,
            ],
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'NusaEvent Hub',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const Text(
                    'Temukan pengalaman baru',
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: onFilter,
              icon: const Icon(Icons.tune, color: Colors.white),
              tooltip: 'Filter kategori',
            ),
          ],
        ),
      ),
    ),
  );
}

class _HeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) => Path()
    ..lineTo(size.width, 0)
    ..lineTo(size.width, size.height - 20)
    ..quadraticBezierTo(
      size.width * .58,
      size.height + 8,
      size.width * .18,
      size.height - 6,
    )
    ..quadraticBezierTo(size.width * .06, size.height - 10, 0, size.height)
    ..close();

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

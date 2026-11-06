import 'package:flutter/material.dart';

import '../models/post.dart';
import '../services/post_service.dart';
import 'add_post_screen.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.service});

  final PostService? service;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final PostService _service;
  late Future<List<Post>> _postsFuture;

  @override
  void initState() {
    super.initState();
    _service = widget.service ?? PostService();
    _postsFuture = _loadPosts();
  }

  Future<List<Post>> _loadPosts() => _service.fetchPosts();

  void _retry() {
    setState(() {
      _postsFuture = _loadPosts();
    });
  }

  Future<void> _refresh() async {
    final future = _loadPosts();
    setState(() {
      _postsFuture = future;
    });
    await future;
  }

  Future<void> _openAddPost() async {
    final created = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => AddPostScreen(service: _service),
      ),
    );
    if (created == true && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pengumuman berhasil dibuat.')),
      );
      _retry();
    }
  }

  @override
  void dispose() {
    if (widget.service == null) {
      _service.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'NusaInfo',
              style: TextStyle(fontWeight: FontWeight.w800),
            ),
            Text(
              'Pusat informasi kegiatanmu',
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.normal),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: _openAddPost,
            tooltip: 'Buat pengumuman',
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openAddPost,
        icon: const Icon(Icons.edit_note),
        label: const Text('Tulis'),
      ),
      body: FutureBuilder<List<Post>>(
        future: _postsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF2A9D8F)),
            );
          }
          if (snapshot.hasError) {
            return _ErrorState(onRetry: _retry);
          }
          final posts = snapshot.data ?? const <Post>[];
          if (posts.isEmpty) {
            return const Center(child: Text('Belum ada pengumuman.'));
          }
          return RefreshIndicator(
            onRefresh: _refresh,
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 96),
              itemCount: posts.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return _HomeHeader(totalEvents: posts.length);
                }
                final post = posts[index - 1];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _EventCard(
                    post: post,
                    eventName: _eventName(index - 1),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailScreen(
                          post: post,
                          service: _service,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  String _eventName(int index) {
    const eventNames = [
      'Info Kegiatan Warga',
      'Agenda Komunitas',
      'Pemberitahuan Penting',
      'Kabar Nusantara',
      'Acara Akhir Pekan',
    ];
    return eventNames[index % eventNames.length];
  }
}

class _HomeHeader extends StatelessWidget {
  const _HomeHeader({required this.totalEvents});

  final int totalEvents;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Color(0xFF0F4C5C),
        borderRadius: BorderRadius.all(Radius.circular(22)),
      ),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Halo, warga Nusa!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Temukan kabar dan event terbaru di sekitarmu.',
                  style: TextStyle(color: Color(0xFFD8EEEA), height: 1.4),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: const BoxDecoration(
              color: Color(0xFFE9C46A),
              borderRadius: BorderRadius.all(Radius.circular(14)),
            ),
            child: Column(
              children: [
                Text(
                  '$totalEvents',
                  style: const TextStyle(
                    color: Color(0xFF173B43),
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const Text(
                  'event',
                  style: TextStyle(
                    color: Color(0xFF173B43),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EventCard extends StatelessWidget {
  const _EventCard({
    required this.post,
    required this.eventName,
    required this.onTap,
  });

  final Post post;
  final String eventName;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: const BoxDecoration(
                  color: Color(0xFFEAF3F1),
                  borderRadius: BorderRadius.all(Radius.circular(14)),
                ),
                child: const Icon(
                  Icons.event_available,
                  color: Color(0xFF0F4C5C),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: const BoxDecoration(
                        color: Color(0xFFFFF4D6),
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                      ),
                      child: Text(
                        eventName,
                        style: const TextStyle(
                          color: Color(0xFF8A6510),
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      post.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xFF173B43),
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      post.body,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xFF607277),
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 8, top: 26),
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                  color: Color(0xFF2A9D8F),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.cloud_off, size: 56),
            const SizedBox(height: 16),
            const Text(
              'Pengumuman tidak dapat dimuat.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Periksa koneksi internet, lalu coba lagi.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Coba Lagi'),
            ),
          ],
        ),
      ),
    );
  }
}

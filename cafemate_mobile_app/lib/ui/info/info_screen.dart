import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/async_state.dart';
import 'info_view_model.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) context.read<InfoViewModel>().load();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kabar & promo'),
        actions: [
          IconButton(
            onPressed: () => _showAbout(context),
            icon: const Icon(Icons.info_outline),
          ),
        ],
      ),
      body: ListenableBuilder(
        listenable: context.read<InfoViewModel>(),
        builder: (context, _) {
          final viewModel = context.read<InfoViewModel>();
          return asyncState(
            isLoading: viewModel.isLoading,
            error: viewModel.error,
            onRetry: viewModel.load,
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                const Text(
                    'Kabar stok, promo, dan agenda komunitas dari tim CafeMate.'),
                const SizedBox(height: 16),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Cari kabar',
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: viewModel.search,
                ),
                const SizedBox(height: 16),
                if (viewModel.filteredItems.isEmpty)
                  const Card(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Text('Tidak ada kabar yang cocok.'),
                    ),
                  )
                else
                  ...viewModel.filteredItems.map(
                    (item) => Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        leading: const Icon(Icons.article_outlined),
                        title: Text(item.title),
                        subtitle:
                            Text('${item.summary}\n${item.publishedAt}'),
                        isThreeLine: true,
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showAbout(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tentang Kabar'),
        content: const Text(
            'Kabar CafeMate menampilkan promo, kabar produk, dan pengumuman komunitas dari repository informasi.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Tutup')),
        ],
      ),
    );
  }
}

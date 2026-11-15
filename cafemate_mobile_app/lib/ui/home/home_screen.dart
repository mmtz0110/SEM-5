import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/cafmate_store.dart';
import '../../domain/models/cafmate_order.dart';
import '../../domain/models/cafmate_product.dart';
import '../core/async_state.dart';
import '../core/cafe_photo_slot.dart';
import 'home_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) context.read<HomeViewModel>().load();
    });
  }

  @override
  Widget build(BuildContext context) {
    final store = context.watch<CafmateStore>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('CAFMATE'),
        actions: [
          IconButton(
            onPressed: () => _showNotifications(context),
            tooltip: 'Notifikasi',
            icon: const Icon(Icons.notifications_none),
          ),
          IconButton(
            onPressed: () => _showAccount(context, store),
            tooltip: 'Akun',
            icon: const Icon(Icons.person_outline),
          ),
        ],
      ),
      body: ListenableBuilder(
        listenable: context.read<HomeViewModel>(),
        builder: (context, _) {
          final viewModel = context.read<HomeViewModel>();
          return asyncState(
            isLoading: viewModel.isLoading,
            error: viewModel.error,
            onRetry: viewModel.load,
            child: RefreshIndicator(
              onRefresh: () => viewModel.load(forceRefresh: true),
              child: ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                children: [
                  Text('PAGI DI CAFE',
                      style: Theme.of(context).textTheme.labelMedium),
                  const SizedBox(height: 4),
                  Text(
                    'Halo, ${store.cafeName}',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 16),
                  const CafePhotoSlot(
                    label: 'Foto suasana cafe hari ini',
                    icon: Icons.photo_camera_back_outlined,
                    aspectRatio: 2.15,
                    assetPath: 'assets/images/cafe-dashboard.jpg',
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _MetricCard(
                          label: 'Hemat bulan ini',
                          value: 'Rp${viewModel.totalSavings}',
                          icon: Icons.savings_outlined,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _MetricCard(
                          label: 'Reliability',
                          value: '${store.reliabilityScore}/100',
                          icon: Icons.verified_user_outlined,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text('Kloter hari ini',
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 4),
                  const Text(
                      'Data utama dari katalog bahan baku yang masih berjalan.'),
                  const SizedBox(height: 8),
                  ...viewModel.todayProducts.map((product) =>
                      _TodayProductCard(product: product)),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: Text('Keranjang belum selesai',
                            style: Theme.of(context).textTheme.titleLarge),
                      ),
                      Chip(
                          label: Text(
                              '${viewModel.pendingCount} pesanan')),
                    ],
                  ),
                  const SizedBox(height: 4),
                  const Text(
                      'Data aksi dari keranjang. Buka tab Checklist untuk menghapus pesanan.'),
                  const SizedBox(height: 8),
                  if (viewModel.pendingCartOrders.isEmpty)
                    const _EmptyState(
                        text:
                            'Keranjang bersih. Tambahkan pesanan dari tab Daftar.')
                  else
                    ...viewModel.pendingCartOrders
                        .take(3)
                        .map((order) => _PendingOrderTile(order: order)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showNotifications(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Notifikasi'),
        content: const Text(
            'Belum ada perubahan status order. CAFMATE menampilkan pembaruan kloter di sini.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Tutup')),
        ],
      ),
    );
  }

  void _showAccount(BuildContext context, CafmateStore store) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(store.cafeName),
        content: Text(
            'Cafe rintisan • Bandung Selatan\nJam operasional ${store.operatingHours}\nReliability ${store.reliabilityScore}/100'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Tutup')),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              store.switchRole();
            },
            child: const Text('Masuk POV Admin'),
          ),
        ],
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard(
      {required this.label, required this.value, required this.icon});
  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) => Card(
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon),
              const SizedBox(height: 8),
              Text(value,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18)),
              Text(label),
            ],
          ),
        ),
      );
}

class _TodayProductCard extends StatelessWidget {
  const _TodayProductCard({required this.product});
  final CafmateProduct product;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(product.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16)),
                ),
                Chip(label: Text(product.category)),
              ],
            ),
            Text('${product.supplier} • ${product.area}'),
            const SizedBox(height: 8),
            Text(
                'Rp${product.wholesalePrice}/${product.unit} • tutup ${product.deadline}'),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: product.progress,
              minHeight: 8,
              borderRadius: BorderRadius.circular(8),
            ),
            const SizedBox(height: 6),
            Text(
                'Terkumpul ${product.quantity}/${product.moq} ${product.unit}'),
          ],
        ),
      ),
    );
  }
}

class _PendingOrderTile extends StatelessWidget {
  const _PendingOrderTile({required this.order});
  final CafmateOrder order;

  @override
  Widget build(BuildContext context) {
    final label = switch (order.status) {
      CafmateOrderStatus.waiting => 'Menunggu kuota penuh',
      CafmateOrderStatus.locked => 'Terkunci, wajib DP',
      CafmateOrderStatus.shipping => 'Dalam pengiriman',
      CafmateOrderStatus.completed => 'Selesai',
      CafmateOrderStatus.cancelled => 'Dibatalkan',
    };
    return Card(
      child: CheckboxListTile(
        value: false,
        onChanged: (_) => context.read<HomeViewModel>().removeFromCart(order),
        secondary: const Icon(Icons.shopping_cart_outlined),
        title: Text(order.productName),
        subtitle:
            Text('${order.quantity} ${order.unit} • Rp${order.total}\n$label'),
        isThreeLine: true,
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) => Card(
      child: Padding(padding: const EdgeInsets.all(20), child: Text(text)));
}

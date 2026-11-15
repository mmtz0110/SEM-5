import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/async_state.dart';
import 'checklist_view_model.dart';

class ChecklistScreen extends StatefulWidget {
  const ChecklistScreen({super.key});

  @override
  State<ChecklistScreen> createState() => _ChecklistScreenState();
}

class _ChecklistScreenState extends State<ChecklistScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) context.read<ChecklistViewModel>().load();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checklist keranjang')),
      body: ListenableBuilder(
        listenable: context.read<ChecklistViewModel>(),
        builder: (context, _) {
          final viewModel = context.read<ChecklistViewModel>();
          return asyncState(
            isLoading: viewModel.isLoading,
            error: viewModel.error,
            onRetry: viewModel.load,
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                        'Centang pesanan yang ingin dihapus dari keranjang. Pesanan yang dicentang pindah ke bagian Selesai.'),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Text('Belum dihapus',
                          style: Theme.of(context).textTheme.titleLarge),
                    ),
                    Chip(label: Text('${viewModel.pendingCount} pesanan')),
                  ],
                ),
                const SizedBox(height: 8),
                if (viewModel.cartOrders.isEmpty)
                  const _EmptyState(
                      text: 'Tidak ada pesanan aktif di keranjang.')
                else
                  ...viewModel.cartOrders.map(
                    (order) => Card(
                      child: CheckboxListTile(
                        value: false,
                        onChanged: (_) => viewModel.setRemoved(order, true),
                        title: Text(order.productName),
                        subtitle: Text(
                            '${order.quantity} ${order.unit} • Rp${order.total}'),
                        secondary:
                            const Icon(Icons.remove_shopping_cart_outlined),
                      ),
                    ),
                  ),
                const Divider(height: 32),
                Text('Selesai',
                    style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 4),
                const Text('Pesanan berikut sudah dihapus dari keranjang.'),
                const SizedBox(height: 8),
                if (viewModel.removedOrders.isEmpty)
                  const _EmptyState(text: 'Belum ada pesanan yang dihapus.')
                else
                  ...viewModel.removedOrders.map(
                    (order) => Card(
                      child: CheckboxListTile(
                        value: true,
                        onChanged: (_) => viewModel.setRemoved(order, false),
                        title: Text(
                          order.productName,
                          style: const TextStyle(
                              decoration: TextDecoration.lineThrough),
                        ),
                        subtitle: Text(
                            '${order.quantity} ${order.unit} • Rp${order.total} • dihapus'),
                        secondary: const Icon(Icons.check_circle_outline),
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
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) => Card(
      child: Padding(padding: const EdgeInsets.all(20), child: Text(text)));
}

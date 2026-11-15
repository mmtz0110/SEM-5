import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/models/cafmate_product.dart';
import '../core/async_state.dart';
import 'catalog_view_model.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) context.read<CatalogViewModel>().load();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar kloter')),
      body: ListenableBuilder(
        listenable: context.read<CatalogViewModel>(),
        builder: (context, _) {
          final viewModel = context.read<CatalogViewModel>();
          return asyncState(
            isLoading: viewModel.isLoading,
            error: viewModel.error,
            onRetry: viewModel.load,
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                SegmentedButton<String>(
                  showSelectedIcon: false,
                  segments: [
                    for (final category in CatalogViewModel.categories)
                      ButtonSegment(value: category, label: Text(category)),
                  ],
                  selected: {viewModel.selectedCategory},
                  onSelectionChanged: (value) =>
                      viewModel.selectCategory(value.first),
                ),
                const SizedBox(height: 16),
                ...viewModel.filteredProducts.map(
                    (product) => _ProductCard(product: product)),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  const _ProductCard({required this.product});
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
            Text('Rp${product.wholesalePrice}/${product.unit}',
                style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: product.progress,
              minHeight: 8,
              borderRadius: BorderRadius.circular(8),
            ),
            const SizedBox(height: 6),
            Text(
                'Terkumpul ${product.quantity}/${product.moq} ${product.unit} • Tutup ${product.deadline}'),
            const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: () => _showOrderDialog(context, product),
              icon: const Icon(Icons.add_shopping_cart),
              label: const Text('Tambah ke keranjang'),
            ),
          ],
        ),
      ),
    );
  }

  void _showOrderDialog(BuildContext context, CafmateProduct product) {
    final controller = TextEditingController(text: '1');
    showModalBottomSheet<void>(
      context: context,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Tambah ${product.name}',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 4),
            Text('Jumlah dalam ${product.unit}'),
            const SizedBox(height: 12),
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Jumlah'),
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () async {
                await context
                    .read<CatalogViewModel>()
                    .addToCart(product, int.tryParse(controller.text) ?? 0);
                if (context.mounted) Navigator.pop(context);
              },
              child: const Text('Simpan di keranjang'),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/book.dart';
import '../providers/cart_provider.dart';
import '../providers/theme_provider.dart';
import 'cart_screen.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  static const books = [
    Book(
      id: '1',
      title: 'Laut Bercerita',
      author: 'Leila S. Chudori',
      price: 95000,
    ),
    Book(
      id: '2',
      title: 'Filosofi Teras',
      author: 'Henry Manampiring',
      price: 110000,
    ),
    Book(id: '3', title: 'Bumi', author: 'Tere Liye', price: 88000),
    Book(id: '4', title: 'Atomic Habits', author: 'James Clear', price: 125000),
  ];

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.watch<ThemeProvider>().isDarkMode;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('NusaBookstore'),
        actions: [
          IconButton(
            tooltip: isDarkMode ? 'Light mode' : 'Dark mode',
            onPressed: context.read<ThemeProvider>().toggleTheme,
            icon: Icon(
              isDarkMode ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
            ),
          ),
          Consumer<CartProvider>(
            builder: (context, cart, child) => Badge(
              label: Text('${cart.totalItems}'),
              isLabelVisible: cart.totalItems > 0,
              backgroundColor: colorScheme.primary,
              child: IconButton(
                tooltip: 'Keranjang',
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute<void>(builder: (_) => const CartScreen()),
                ),
                icon: const Icon(Icons.shopping_cart_outlined),
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          // Header Section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(24),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Temukan Bacaan Favoritmu',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onPrimaryContainer,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Koleksi pilihan untuk menemani setiap cerita.',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: colorScheme.onPrimaryContainer.withValues(
                      alpha: 0.85,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Book Grid
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: GridView.builder(
                padding: const EdgeInsets.only(top: 16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: books.length,
                itemBuilder: (context, index) => _BookCard(book: books[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BookCard extends StatelessWidget {
  const _BookCard({required this.book});

  final Book book;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 3,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.read<CartProvider>().addItem(book),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Book cover
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: book.imageUrl == null
                        ? null
                        : DecorationImage(
                            image: NetworkImage(book.imageUrl!),
                            fit: BoxFit.cover,
                          ),
                    color: book.imageUrl == null
                        ? colorScheme.primaryContainer
                        : null,
                  ),
                  child: book.imageUrl == null
                      ? Center(
                          child: Icon(
                            Icons.menu_book_rounded,
                            size: 40,
                            color: colorScheme.primary,
                          ),
                        )
                      : null,
                ),
              ),
              const SizedBox(height: 12),
              // Book info
              Text(
                book.title,
                style: Theme.of(context).textTheme.titleSmall
                    ?.copyWith(fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                book.author,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurface.withValues(alpha: 0.7),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    formatRupiah(book.price),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.primary,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: colorScheme.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      onPressed: () =>
                          context.read<CartProvider>().addItem(book),
                      icon: Icon(
                        Icons.add,
                        color: colorScheme.onPrimary,
                        size: 20,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 36,
                        minHeight: 36,
                      ),
                      padding: const EdgeInsets.all(8),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String formatRupiah(double value) {
  final formatted = value
      .toStringAsFixed(0)
      .replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => '.');
  return 'Rp $formatted';
}

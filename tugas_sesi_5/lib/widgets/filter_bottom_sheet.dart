import 'package:flutter/material.dart';

Future<String?> showCategoryFilter(BuildContext context, String selected) {
  const categories = ['Semua', 'AI', 'Mobile', 'IoT', 'Cybersecurity'];
  return showModalBottomSheet<String>(
    context: context,
    showDragHandle: true,
    builder: (context) => SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Filter kategori', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ...categories.map((category) => RadioListTile<String>(
              value: category,
              groupValue: selected,
              title: Text(category),
              onChanged: (value) => Navigator.pop(context, value),
            )),
          ],
        ),
      ),
    ),
  );
}

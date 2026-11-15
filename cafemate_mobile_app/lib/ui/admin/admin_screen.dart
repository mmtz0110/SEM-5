import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/cafmate_store.dart';
import '../../domain/models/cafmate_order.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      const _AdminOverview(),
      const _ProductManagement(),
      const _AnnouncementManagement(),
      const _OrderMonitoring(),
    ];
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: index,
            onDestinationSelected: (value) => setState(() => index = value),
            labelType: NavigationRailLabelType.all,
            leading: const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Icon(Icons.admin_panel_settings, size: 32)),
            destinations: const [
              NavigationRailDestination(
                  icon: Icon(Icons.dashboard_outlined),
                  selectedIcon: Icon(Icons.dashboard),
                  label: Text('Dasbor')),
              NavigationRailDestination(
                  icon: Icon(Icons.inventory_2_outlined),
                  selectedIcon: Icon(Icons.inventory_2),
                  label: Text('Listing')),
              NavigationRailDestination(
                  icon: Icon(Icons.campaign_outlined),
                  selectedIcon: Icon(Icons.campaign),
                  label: Text('Kabar')),
              NavigationRailDestination(
                  icon: Icon(Icons.monitor_heart_outlined),
                  selectedIcon: Icon(Icons.monitor_heart),
                  label: Text('Monitoring')),
            ],
          ),
          Expanded(child: IndexedStack(index: index, children: pages)),
        ],
      ),
    );
  }
}

class _AdminOverview extends StatelessWidget {
  const _AdminOverview();
  @override
  Widget build(BuildContext context) {
    final store = context.watch<CafmateStore>();
    return _AdminPage(
      title: 'CAFMATE CMS',
      action: OutlinedButton.icon(
          onPressed: store.switchRole,
          icon: const Icon(Icons.logout),
          label: const Text('Logout ke POV User')),
      children: [
        Text('Pengelolaan supply chain',
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Text(
            'Kelola listing, kabar, kloter, order, dan jalur mitigasi dari satu tempat.'),
        const SizedBox(height: 24),
        Wrap(spacing: 12, runSpacing: 12, children: [
          _AdminMetric(
              label: 'Listing aktif',
              value: '${store.products.length}',
              icon: Icons.inventory_2),
          _AdminMetric(
              label: 'Order masuk',
              value: '${store.orders.length}',
              icon: Icons.receipt_long),
          _AdminMetric(
              label: 'Kabar tayang',
              value: '${store.announcements.length}',
              icon: Icons.campaign),
        ]),
        const SizedBox(height: 28),
        Text('Perlu perhatian', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 8),
        ...store.products.where((p) => p.quantity >= p.moq).map((p) => ListTile(
            leading: const Icon(Icons.lock_outline, color: Colors.amber),
            title: Text(p.name),
            subtitle: const Text('MOQ tercapai, siap dikunci'))),
      ],
    );
  }
}

class _ProductManagement extends StatelessWidget {
  const _ProductManagement();
  @override
  Widget build(BuildContext context) {
    final store = context.watch<CafmateStore>();
    return _AdminPage(
      title: 'Manajemen listing',
      action: FilledButton.icon(
          onPressed: () => _showProductForm(context),
          icon: const Icon(Icons.add),
          label: const Text('Tambah listing')),
      children: [
        const Text(
            'Data di sini langsung tersedia di menu Belanja POV User setelah logout.'),
        const SizedBox(height: 16),
        ...store.products.map((p) => Card(
            child: ListTile(
                leading: const Icon(Icons.inventory_2_outlined),
                title: Text(p.name),
                subtitle:
                    Text('${p.category} • MOQ ${p.moq} ${p.unit} • ${p.area}'),
                trailing: Text('Rp${p.wholesalePrice}')))),
      ],
    );
  }

  void _showProductForm(BuildContext context) {
    final name = TextEditingController();
    final category = TextEditingController(text: 'Biji kopi');
    final price = TextEditingController(text: '100000');
    final moq = TextEditingController(text: '10');
    showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
                title: const Text('Tambah listing'),
                content: Column(mainAxisSize: MainAxisSize.min, children: [
                  _Field(controller: name, label: 'Nama produk'),
                  _Field(controller: category, label: 'Kategori'),
                  _Field(controller: price, label: 'Harga grosir'),
                  _Field(controller: moq, label: 'Target MOQ')
                ]),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Batal')),
                  FilledButton(
                      onPressed: () {
                        if (name.text.trim().isEmpty) return;
                        context.read<CafmateStore>().addProduct(
                            name: name.text.trim(),
                            category: category.text.trim(),
                            wholesalePrice: int.tryParse(price.text) ?? 0,
                            moq: int.tryParse(moq.text) ?? 1);
                        Navigator.pop(context);
                      },
                      child: const Text('Publikasikan'))
                ]));
  }
}

class _AnnouncementManagement extends StatelessWidget {
  const _AnnouncementManagement();
  @override
  Widget build(BuildContext context) {
    final store = context.watch<CafmateStore>();
    return _AdminPage(
      title: 'Manajemen kabar',
      action: FilledButton.icon(
          onPressed: () => _showAnnouncementForm(context),
          icon: const Icon(Icons.add),
          label: const Text('Tulis kabar')),
      children: [
        const Text('Pengumuman baru muncul di linimasa Kabar POV User.'),
        const SizedBox(height: 16),
        ...store.announcements.map((a) => Card(
            child: ListTile(
                title: Text(a.title),
                subtitle: Text(a.summary),
                trailing: Text(a.publishedAt)))),
      ],
    );
  }

  void _showAnnouncementForm(BuildContext context) {
    final title = TextEditingController();
    final body = TextEditingController();
    showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
                title: const Text('Publikasikan kabar'),
                content: Column(mainAxisSize: MainAxisSize.min, children: [
                  _Field(controller: title, label: 'Judul'),
                  _Field(controller: body, label: 'Ringkasan')
                ]),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Batal')),
                  FilledButton(
                      onPressed: () {
                        if (title.text.trim().isEmpty ||
                            body.text.trim().isEmpty) {
                          return;
                        }
                        context.read<CafmateStore>().addAnnouncement(
                            title.text.trim(), body.text.trim());
                        Navigator.pop(context);
                      },
                      child: const Text('Tayangkan'))
                ]));
  }
}

class _OrderMonitoring extends StatelessWidget {
  const _OrderMonitoring();
  @override
  Widget build(BuildContext context) {
    final store = context.watch<CafmateStore>();
    return _AdminPage(
      title: 'Monitoring order',
      children: [
        const Text(
            'Kunci order yang siap dan proses pengiriman dari satu tempat.'),
        const SizedBox(height: 16),
        ...store.orders.map((order) => Card(
            child: ListTile(
                title: Text(order.productName),
                subtitle: Text(
                    '${order.quantity} ${order.unit} • ${_status(order.status)}'),
                trailing: PopupMenuButton<CafmateOrderStatus>(
                    tooltip: 'Ubah status',
                    onSelected: (status) =>
                        store.updateOrderStatus(order, status),
                    itemBuilder: (context) => const [
                          PopupMenuItem(
                              value: CafmateOrderStatus.locked,
                              child: Text('Kunci, wajib DP')),
                          PopupMenuItem(
                              value: CafmateOrderStatus.shipping,
                              child: Text('Dalam pengiriman')),
                          PopupMenuItem(
                              value: CafmateOrderStatus.completed,
                              child: Text('Selesai'))
                        ])))),
      ],
    );
  }

  String _status(CafmateOrderStatus status) => switch (status) {
        CafmateOrderStatus.waiting => 'Menunggu kuota penuh',
        CafmateOrderStatus.locked => 'Terkunci, wajib DP',
        CafmateOrderStatus.shipping => 'Dalam pengiriman',
        CafmateOrderStatus.completed => 'Selesai',
        CafmateOrderStatus.cancelled => 'Dibatalkan',
      };
}

class _AdminPage extends StatelessWidget {
  const _AdminPage({required this.title, required this.children, this.action});
  final String title;
  final List<Widget> children;
  final Widget? action;
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
          title: Text(title),
          actions: action == null
              ? null
              : [
                  Padding(
                      padding: const EdgeInsets.only(right: 16), child: action!)
                ]),
      body: ListView(padding: const EdgeInsets.all(24), children: children));
}

class _AdminMetric extends StatelessWidget {
  const _AdminMetric(
      {required this.label, required this.value, required this.icon});
  final String label;
  final String value;
  final IconData icon;
  @override
  Widget build(BuildContext context) => SizedBox(
      width: 170,
      child: Card(
          child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(icon, color: Colors.amber),
                    const SizedBox(height: 12),
                    Text(value,
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    Text(label)
                  ]))));
}

class _Field extends StatelessWidget {
  const _Field({required this.controller, required this.label});
  final TextEditingController controller;
  final String label;
  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
          controller: controller,
          decoration: InputDecoration(
              labelText: label, border: const OutlineInputBorder())));
}

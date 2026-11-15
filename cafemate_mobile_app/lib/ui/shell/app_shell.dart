import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/cafmate_store.dart';
import '../../data/repositories/order_repository.dart';
import '../admin/admin_screen.dart';
import '../catalog/catalog_screen.dart';
import '../checklist/checklist_screen.dart';
import '../home/home_screen.dart';
import '../info/info_screen.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int index = 0;
  static const pages = [
    HomeScreen(),
    CatalogScreen(),
    ChecklistScreen(),
    InfoScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final isAdmin = context.watch<CafmateStore>().role == CafmateRole.admin;
    if (isAdmin) return const AdminScreen();

    final pendingCount = context.watch<OrderRepository>().pendingBadgeCount;
    return Scaffold(
      body: IndexedStack(index: index, children: pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (value) => setState(() => index = value),
        destinations: [
          const NavigationDestination(
            icon: Icon(Icons.space_dashboard_outlined),
            selectedIcon: Icon(Icons.space_dashboard),
            label: 'Beranda',
          ),
          const NavigationDestination(
            icon: Icon(Icons.storefront_outlined),
            selectedIcon: Icon(Icons.storefront),
            label: 'Daftar',
          ),
          NavigationDestination(
            icon: Badge(
              isLabelVisible: pendingCount > 0,
              label: Text('$pendingCount'),
              child: const Icon(Icons.checklist_outlined),
            ),
            selectedIcon: Badge(
              isLabelVisible: pendingCount > 0,
              label: Text('$pendingCount'),
              child: const Icon(Icons.checklist),
            ),
            label: 'Checklist',
          ),
          const NavigationDestination(
            icon: Icon(Icons.campaign_outlined),
            selectedIcon: Icon(Icons.campaign),
            label: 'Kabar',
          ),
        ],
      ),
    );
  }
}

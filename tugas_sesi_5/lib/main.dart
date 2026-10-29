import 'package:flutter/material.dart';

import 'models/registration_ticket.dart';
import 'screens/home_events_screen.dart';
import 'screens/registered_tickets_screen.dart';
import 'screens/venue_gallery_screen.dart';
import 'widgets/floating_dock_navigation.dart';

void main() => runApp(const NusaEventApp());

class NusaEventApp extends StatelessWidget {
  const NusaEventApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'NusaEvent Hub',
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff6558d3)),
      scaffoldBackgroundColor: const Color(0xfff8f7fc),
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(),
      ),
    ),
    home: const HomeShell(),
  );
}

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int index = 0;
  final tickets = <RegistrationTicket>[];

  void addTicket(RegistrationTicket ticket) =>
      setState(() => tickets.add(ticket));

  void removeTicket(String id) =>
      setState(() => tickets.removeWhere((ticket) => ticket.id == id));

  @override
  Widget build(BuildContext context) => Scaffold(
    extendBody: true,
    body: IndexedStack(
      index: index,
      children: [
        HomeEventsScreen(onRegistered: addTicket),
        const VenueGalleryScreen(),
        RegisteredTicketsScreen(tickets: tickets, onCancel: removeTicket),
      ],
    ),
    bottomNavigationBar: FloatingDockNavigation(
      selectedIndex: index,
      onSelected: (value) => setState(() => index = value),
    ),
  );
}

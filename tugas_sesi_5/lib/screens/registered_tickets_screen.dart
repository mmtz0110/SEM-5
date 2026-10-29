import 'package:flutter/material.dart';

import '../models/registration_ticket.dart';

class RegisteredTicketsScreen extends StatelessWidget {
  const RegisteredTicketsScreen({
    super.key,
    required this.tickets,
    required this.onCancel,
  });
  final List<RegistrationTicket> tickets;
  final void Function(String id) onCancel;

  Future<void> confirmCancel(
    BuildContext context,
    RegistrationTicket ticket,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Batalkan tiket?'),
        content: Text('Tiket untuk "${ticket.event.title}" akan dihapus.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Kembali'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Batalkan'),
          ),
        ],
      ),
    );
    if (confirmed == true) onCancel(ticket.id);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Tiket Terdaftar')),
    body: tickets.isEmpty
        ? Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.confirmation_number_outlined,
                    size: 64,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Belum ada tiket aktif',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Daftarkan diri ke seminar pilihanmu untuk melihat tiket di sini.',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          )
        : ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: tickets.length,
            itemBuilder: (context, index) {
              final ticket = tickets[index];
              return Dismissible(
                key: ValueKey(ticket.id),
                direction: DismissDirection.endToStart,
                confirmDismiss: (_) async {
                  await confirmCancel(context, ticket);
                  return false;
                },
                background: Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.errorContainer,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(Icons.delete_outline),
                ),
                child: Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: CircleAvatar(
                      backgroundColor: Color(ticket.event.colorValue)
                          .withValues(alpha: .15),
                      child: Icon(
                        Icons.confirmation_number_outlined,
                        color: Color(ticket.event.colorValue),
                      ),
                    ),
                    title: Text(
                      ticket.event.title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        '${ticket.name}\n${ticket.event.date} • ${ticket.event.time}\n${ticket.participantType} • ${ticket.seminarKit}',
                      ),
                    ),
                    isThreeLine: true,
                    trailing: const Icon(Icons.chevron_left),
                  ),
                ),
              );
            },
          ),
  );
}

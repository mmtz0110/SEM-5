import 'package:flutter/material.dart';

import '../models/event_item.dart';
import '../models/registration_ticket.dart';

class EventRegistrationScreen extends StatefulWidget {
  const EventRegistrationScreen({
    super.key,
    required this.event,
    required this.onRegistered,
  });
  final EventItem event;
  final void Function(RegistrationTicket ticket) onRegistered;

  @override
  State<EventRegistrationScreen> createState() =>
      _EventRegistrationScreenState();
}

class _EventRegistrationScreenState extends State<EventRegistrationScreen> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final nimController = TextEditingController();
  final emailController = TextEditingController();
  final whatsappController = TextEditingController();
  String participantType = 'Mahasiswa';
  bool kitIncluded = false;
  double donation = 0;
  DateTime? attendanceDate;
  bool agreed = false;
  bool isLoading = false;

  @override
  void dispose() {
    nameController.dispose();
    nimController.dispose();
    emailController.dispose();
    whatsappController.dispose();
    super.dispose();
  }

  Future<void> chooseDate() async {
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime(2025, 6, 12),
      lastDate: DateTime(2025, 6, 14),
      initialDate: DateTime(2025, 6, 12),
      helpText: 'Pilih tanggal kehadiran',
    );
    if (date != null) setState(() => attendanceDate = date);
  }

  Future<void> submit() async {
    if (!formKey.currentState!.validate()) return;
    if (attendanceDate == null || !agreed) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Pilih tanggal dan setujui tata tertib terlebih dahulu.',
          ),
        ),
      );
      return;
    }
    setState(() => isLoading = true);
    await Future<void>.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;
    final ticket = RegistrationTicket(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      event: widget.event,
      name: nameController.text.trim(),
      nim: nimController.text.trim(),
      email: emailController.text.trim(),
      whatsapp: whatsappController.text.trim(),
      participantType: participantType,
      attendanceDate: attendanceDate!,
      seminarKit: kitIncluded ? 'Premium' : 'Reguler',
      donation: donation,
    );
    widget.onRegistered(ticket);
    setState(() => isLoading = false);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Pendaftaran berhasil! Tiket tersimpan.')),
    );
    Navigator.pop(context);
  }

  String? requiredField(String? value, String label) =>
      value == null || value.trim().isEmpty ? '$label wajib diisi' : null;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Daftar Sekarang')),
    body: LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
          20,
          20,
          20,
          MediaQuery.viewInsetsOf(context).bottom + 24,
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraints.maxHeight - 40),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  widget.event.title,
                  style: Theme.of(context).textTheme.headlineSmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text('${widget.event.date} • ${widget.event.location}'),
                const SizedBox(height: 24),
                _field(
                  nameController,
                  'Nama lengkap',
                  Icons.person_outline,
                  (v) => requiredField(v, 'Nama'),
                ),
                _field(
                  nimController,
                  'NIM',
                  Icons.badge_outlined,
                  (v) => requiredField(v, 'NIM'),
                ),
                _field(emailController, 'Email', Icons.email_outlined, (v) {
                  if (requiredField(v, 'Email') != null)
                    return requiredField(v, 'Email');
                  return RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(v!.trim())
                      ? null
                      : 'Format email tidak valid';
                }),
                _field(
                  whatsappController,
                  'Nomor WhatsApp',
                  Icons.phone_outlined,
                  (v) {
                    if (requiredField(v, 'Nomor WhatsApp') != null)
                      return requiredField(v, 'Nomor WhatsApp');
                    return RegExp(r'^[0-9+ -]{10,}$').hasMatch(v!.trim())
                        ? null
                        : 'Nomor WhatsApp tidak valid';
                  },
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: participantType,
                  decoration: const InputDecoration(
                    labelText: 'Tipe peserta',
                    prefixIcon: Icon(Icons.groups_outlined),
                  ),
                  items: ['Mahasiswa', 'Umum', 'Pelajar']
                      .map(
                        (value) =>
                            DropdownMenuItem(value: value, child: Text(value)),
                      )
                      .toList(),
                  onChanged: (value) =>
                      setState(() => participantType = value!),
                ),
                const SizedBox(height: 12),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.event_outlined),
                  title: Text(
                    attendanceDate == null
                        ? 'Tanggal kehadiran'
                        : '${attendanceDate!.day}/${attendanceDate!.month}/${attendanceDate!.year}',
                  ),
                  subtitle: const Text('Pilih tanggal 12 - 14 Juni 2025'),
                  trailing: FilledButton.tonal(
                    onPressed: chooseDate,
                    child: const Text('Pilih'),
                  ),
                ),
                const Divider(),
                Text(
                  'Paket seminar kit',
                  style: Theme.of(context).textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  value: kitIncluded,
                  onChanged: (value) =>
                      setState(() => kitIncluded = value ?? false),
                  title: const Text(
                    'Tambahkan seminar kit premium (+Rp50.000)',
                  ),
                  controlAffinity: ListTileControlAffinity.leading,
                ),
                const SizedBox(height: 4),
                Text(
                  'Donasi sukarela',
                  style: Theme.of(context).textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                Text('Rp${donation.toInt()}'),
                Slider(
                  value: donation,
                  min: 0,
                  max: 100000,
                  divisions: 10,
                  label: 'Rp${donation.toInt()}',
                  onChanged: (value) => setState(() => donation = value),
                ),
                CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  value: agreed,
                  onChanged: (value) => setState(() => agreed = value ?? false),
                  title: const Text('Saya menyetujui tata tertib acara.'),
                  controlAffinity: ListTileControlAffinity.leading,
                ),
                const SizedBox(height: 12),
                FilledButton.icon(
                  onPressed: isLoading ? null : submit,
                  icon: isLoading
                      ? const SizedBox.square(
                          dimension: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.check),
                  label: Text(
                    isLoading ? 'Mendaftarkan...' : 'Konfirmasi pendaftaran',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );

  Widget _field(
    TextEditingController controller,
    String label,
    IconData icon,
    String? Function(String?) validator,
  ) => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: const OutlineInputBorder(),
      ),
    ),
  );
}

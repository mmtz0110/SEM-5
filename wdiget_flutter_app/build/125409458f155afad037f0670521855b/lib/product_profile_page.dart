import 'package:flutter/material.dart';

const Color _ink = Color(0xFF193B35);
const Color _leaf = Color(0xFF34715D);
const int _unitPrice = 249000;
const String _studentName = 'Agnaya Mumtazul';
const String _studentId = '20240040086';
const String _studentProgram = 'Teknik Informatika / TI-23G';

class ProductProfilePage extends StatelessWidget {
  const ProductProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'PPM Sesi 2 - $_studentName ($_studentId)',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
          children: const [
            _SectionHeading(eyebrow: 'KENALAN DULU', title: 'Profil mahasiswa'),
            SizedBox(height: 12),
            StudentProfileCard(),
            SizedBox(height: 24),
            PromoBanner(),
            SizedBox(height: 24),
            _SectionHeading(eyebrow: 'PILIHAN HARI INI', title: 'Produk'),
            SizedBox(height: 12),
            ProductCard(),
          ],
        ),
      ),
    );
  }
}

class _SectionHeading extends StatelessWidget {
  const _SectionHeading({required this.eyebrow, required this.title});

  final String eyebrow;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          eyebrow,
          style: const TextStyle(
            color: _leaf,
            fontSize: 10,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: const TextStyle(
            color: _ink,
            fontSize: 21,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}

class StudentProfileCard extends StatelessWidget {
  const StudentProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: Color(0xFFE4EAE3)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 62,
              height: 62,
              decoration: BoxDecoration(
                color: const Color(0xFFE7F0E9),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.person_rounded, size: 36, color: _leaf),
            ),
            const SizedBox(width: 14),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _studentName,
                    style: TextStyle(
                      color: _ink,
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    'NIM  •  $_studentId',
                    style: TextStyle(color: Color(0xFF64736B), fontSize: 12),
                  ),
                  SizedBox(height: 2),
                  Text(
                    _studentProgram,
                    style: TextStyle(color: Color(0xFF64736B), fontSize: 12),
                  ),
                  SizedBox(height: 7),
                  Row(
                    children: [
                      Icon(Icons.star_rounded, size: 17, color: Color(0xFFE7A638)),
                      Icon(Icons.star_rounded, size: 17, color: Color(0xFFE7A638)),
                      Icon(Icons.star_rounded, size: 17, color: Color(0xFFE7A638)),
                      Icon(Icons.star_rounded, size: 17, color: Color(0xFFE7A638)),
                      Icon(Icons.star_rounded, size: 17, color: Color(0xFFE7A638)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PromoBanner extends StatelessWidget {
  const PromoBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Stack(
        children: [
          Container(
            height: 104,
            width: double.infinity,
            color: const Color(0xFFDCE9D8),
            padding: const EdgeInsets.all(16),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'PROMO MINGGU INI',
                  style: TextStyle(
                    color: _leaf,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Hemat 20% untuk pilihanmu',
                  style: TextStyle(
                    color: _ink,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 18,
            top: 16,
            child: Icon(
              Icons.local_offer_rounded,
              size: 52,
              color: _leaf.withValues(alpha: 0.20),
            ),
          ),
          Positioned(
            right: 23,
            bottom: 12,
            child: Transform.rotate(
              angle: -0.12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFE7774D),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  '20%',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProductCard extends StatefulWidget {
  const ProductCard({super.key});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool _isFavorite = false;
  int _likeCount = 24;
  int _quantity = 1;

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
      _likeCount += _isFavorite ? 1 : -1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final totalPrice = _unitPrice * _quantity;

    return Card(
      key: const Key('product-card'),
      margin: EdgeInsets.zero,
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: Color(0xFFE4EAE3)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 148,
            width: double.infinity,
            color: const Color(0xFFEEF2EC),
            child: const Stack(
              alignment: Alignment.center,
              children: [
                Icon(Icons.headphones_rounded, size: 78, color: _leaf),
                Positioned(left: 12, top: 12, child: _ProductTag(label: 'TERLARIS')),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Elektronik • Audio',
                  style: TextStyle(
                    color: _leaf,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Headphone Wireless',
                  style: TextStyle(
                    color: _ink,
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 3),
                const Text(
                  'Suara jernih, nyaman dipakai seharian.',
                  style: TextStyle(color: Color(0xFF64736B), fontSize: 12),
                ),
                const SizedBox(height: 10),
                Text(
                  _formatRupiah(_unitPrice),
                  style: const TextStyle(
                    color: _ink,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    OutlinedButton.icon(
                      key: const Key('favorite-button'),
                      onPressed: _toggleFavorite,
                      icon: Icon(
                        _isFavorite ? Icons.favorite : Icons.favorite_border,
                        size: 18,
                        color: _isFavorite ? const Color(0xFFE35D5B) : _ink,
                      ),
                      label: const Text('Favorite'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: _ink,
                        minimumSize: const Size(0, 40),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        side: const BorderSide(color: Color(0xFFDCE4DC)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(Icons.favorite, size: 16, color: Colors.red.shade300),
                    const SizedBox(width: 4),
                    Text(
                      '$_likeCount suka',
                      style: const TextStyle(
                        color: Color(0xFF64736B),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const Divider(height: 24),
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Jumlah',
                        style: TextStyle(
                          color: _ink,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    _QuantityButton(
                      key: const Key('decrease-quantity'),
                      icon: Icons.remove,
                      label: 'Kurangi jumlah',
                      onPressed: _quantity > 1
                          ? () => setState(() => _quantity--)
                          : null,
                    ),
                    SizedBox(
                      width: 40,
                      child: Text(
                        '$_quantity',
                        key: const Key('quantity-value'),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: _ink,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    _QuantityButton(
                      key: const Key('increase-quantity'),
                      icon: Icons.add,
                      label: 'Tambah jumlah',
                      onPressed: () => setState(() => _quantity++),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Total harga',
                        style: TextStyle(color: Color(0xFF64736B)),
                      ),
                    ),
                    Text(
                      _formatRupiah(totalPrice),
                      key: const Key('total-price'),
                      style: const TextStyle(
                        color: _ink,
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    key: const Key('add-to-cart-button'),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            '$_quantity Headphone Wireless ditambahkan ke keranjang',
                          ),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    icon: const Icon(Icons.shopping_cart_outlined, size: 18),
                    label: const Text('Tambah ke Keranjang'),
                    style: FilledButton.styleFrom(
                      backgroundColor: _ink,
                      foregroundColor: Colors.white,
                      minimumSize: const Size.fromHeight(46),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductTag extends StatelessWidget {
  const _ProductTag({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFFE7774D),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 9,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.6,
        ),
      ),
    );
  }
}

class _QuantityButton extends StatelessWidget {
  const _QuantityButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 36,
      height: 36,
      child: IconButton(
        onPressed: onPressed,
        tooltip: label,
        icon: Icon(icon, size: 18),
        style: IconButton.styleFrom(
          foregroundColor: _ink,
          backgroundColor: const Color(0xFFF0F4EF),
          disabledForegroundColor: const Color(0xFFB5BDB5),
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
      ),
    );
  }
}

String _formatRupiah(int amount) {
  final digits = amount.toString();
  final formatted = digits.replaceAllMapped(
    RegExp(r'\B(?=(\d{3})+(?!\d))'),
    (_) => '.',
  );
  return 'Rp $formatted';
}
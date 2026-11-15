import '../../domain/models/cafe_info.dart';
import '../../domain/models/cafmate_order.dart';
import '../../domain/models/cafmate_product.dart';

/// Simulasi server: setiap method mengembalikan data contoh setelah jeda.
class CafeMateService {
  Future<List<CafmateProduct>> fetchProducts() async {
    await Future<void>.delayed(const Duration(milliseconds: 350));
    return const [
      CafmateProduct(
        id: 'p1',
        name: 'Biji kopi House Blend',
        category: 'Biji kopi',
        supplier: 'Roastery Lokal Bandung',
        wholesalePrice: 98000,
        marketPrice: 125000,
        quantity: 38,
        moq: 50,
        unit: 'kg',
        area: 'Bandung Selatan',
        deadline: 'Besok, 18.00',
      ),
      CafmateProduct(
        id: 'p2',
        name: 'Susu UHT full cream',
        category: 'Susu',
        supplier: 'Distributor Susu Nusantara',
        wholesalePrice: 318000,
        marketPrice: 360000,
        quantity: 10,
        moq: 10,
        unit: 'dus',
        area: 'Bandung Selatan',
        deadline: 'Hari ini, 16.00',
      ),
      CafmateProduct(
        id: 'p3',
        name: 'Sirup gula aren',
        category: 'Sirup',
        supplier: 'Bahan Baku Rasa',
        wholesalePrice: 246000,
        marketPrice: 280000,
        quantity: 7,
        moq: 12,
        unit: 'karton',
        area: 'Bandung Selatan',
        deadline: 'Jumat, 12.00',
      ),
      CafmateProduct(
        id: 'p4',
        name: 'Single Origin Flores',
        category: 'Biji kopi',
        supplier: 'Roastery Nusantara',
        wholesalePrice: 135000,
        marketPrice: 165000,
        quantity: 14,
        moq: 25,
        unit: 'kg',
        area: 'Bandung Selatan',
        deadline: 'Sabtu, 15.00',
      ),
      CafmateProduct(
        id: 'p5',
        name: 'Oat Milk Barista',
        category: 'Susu',
        supplier: 'Distributor Susu Nusantara',
        wholesalePrice: 390000,
        marketPrice: 440000,
        quantity: 6,
        moq: 10,
        unit: 'dus',
        area: 'Bandung Selatan',
        deadline: 'Besok, 20.00',
      ),
    ];
  }

  Future<List<CafmateOrder>> fetchOrders() async {
    await Future<void>.delayed(const Duration(milliseconds: 350));
    return const [
      CafmateOrder(
        id: 'o1',
        productId: 'p1',
        productName: 'Biji kopi House Blend',
        quantity: 2,
        unit: 'kg',
        total: 196000,
        status: CafmateOrderStatus.waiting,
      ),
      CafmateOrder(
        id: 'o2',
        productId: 'p2',
        productName: 'Susu UHT full cream',
        quantity: 1,
        unit: 'dus',
        total: 318000,
        status: CafmateOrderStatus.locked,
      ),
      CafmateOrder(
        id: 'o3',
        productId: 'p3',
        productName: 'Sirup gula aren',
        quantity: 1,
        unit: 'karton',
        total: 246000,
        status: CafmateOrderStatus.waiting,
      ),
      CafmateOrder(
        id: 'o4',
        productId: 'p4',
        productName: 'Single Origin Flores',
        quantity: 2,
        unit: 'kg',
        total: 270000,
        status: CafmateOrderStatus.waiting,
      ),
      CafmateOrder(
        id: 'o5',
        productId: 'p5',
        productName: 'Oat Milk Barista',
        quantity: 1,
        unit: 'dus',
        total: 390000,
        status: CafmateOrderStatus.shipping,
      ),
    ];
  }

  Future<List<CafeInfo>> fetchInfo() async {
    await Future<void>.delayed(const Duration(milliseconds: 350));
    return const [
      CafeInfo(
          id: 'i1',
          title: 'Promo kopi sore',
          summary: 'Diskon 20% untuk semua kopi pukul 16.00–18.00.',
          publishedAt: 'Hari ini'),
      CafeInfo(
          id: 'i2',
          title: 'Biji baru tiba',
          summary: 'Single origin Flores sudah tersedia untuk manual brew.',
          publishedAt: 'Kemarin'),
      CafeInfo(
          id: 'i3',
          title: 'Jam buka akhir pekan',
          summary: 'CafeMate buka satu jam lebih awal setiap Sabtu.',
          publishedAt: '2 hari lalu'),
      CafeInfo(
          id: 'i4',
          title: 'Workshop latte art',
          summary: 'Daftar ke sesi internal bersama barista utama.',
          publishedAt: '3 hari lalu'),
      CafeInfo(
          id: 'i5',
          title: 'Kabar komunitas',
          summary: 'Komunitas pelanggan mengadakan acara baca buku Jumat ini.',
          publishedAt: '4 hari lalu'),
    ];
  }
}

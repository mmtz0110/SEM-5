import 'package:flutter/foundation.dart';

import '../domain/models/cafe_info.dart';
import '../domain/models/cafmate_order.dart';
import '../domain/models/cafmate_product.dart';

enum CafmateRole { user, admin }

class CafmateStore extends ChangeNotifier {
  CafmateRole role = CafmateRole.user;
  int reliabilityScore = 86;
  String cafeName = 'Kopi Duo Basudara';
  String operatingHours = '06.30 - 17.00';
  String cafeDescription = 'Kafenya dua saudara perintis #bukan_pewaris';
  final List<CafmateProduct> products = [
    const CafmateProduct(
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
    const CafmateProduct(
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
    const CafmateProduct(
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
  ];

  final List<CafmateOrder> orders = [
    const CafmateOrder(
      id: 'o1',
      productId: 'p1',
      productName: 'Biji kopi House Blend',
      quantity: 2,
      unit: 'kg',
      total: 196000,
      status: CafmateOrderStatus.waiting,
    ),
  ];

  final List<CafeInfo> announcements = [
    const CafeInfo(
      id: 'a1',
      title: 'House Blend baru tersedia',
      summary: 'Kloter biji kopi untuk cafe kecil dibuka sampai besok sore.',
      publishedAt: 'Hari ini',
    ),
    const CafeInfo(
      id: 'a2',
      title: 'Harga susu turun di kloter area',
      summary: 'Kebutuhan dus kecil dapat digabung dengan cafe sekitar.',
      publishedAt: 'Kemarin',
    ),
  ];

  int get totalSavings => orders
      .where((order) => order.status != CafmateOrderStatus.cancelled)
      .fold(0, (sum, order) => sum + (order.quantity * 27000));

  void switchRole() {
    role = role == CafmateRole.user ? CafmateRole.admin : CafmateRole.user;
    notifyListeners();
  }

  void addOrder(CafmateProduct product, int quantity) {
    if (quantity <= 0) return;
    final index = products.indexWhere((item) => item.id == product.id);
    products[index] = product.copyWith(quantity: product.quantity + quantity);
    orders.add(CafmateOrder(
      id: 'o${orders.length + 1}',
      productId: product.id,
      productName: product.name,
      quantity: quantity,
      unit: product.unit,
      total: quantity * product.wholesalePrice,
      status: CafmateOrderStatus.waiting,
    ));
    notifyListeners();
  }

  void cancelOrder(CafmateOrder order) {
    final index = orders.indexWhere((item) => item.id == order.id);
    if (index == -1) return;
    orders[index] = order.copyWith(status: CafmateOrderStatus.cancelled);
    reliabilityScore = (reliabilityScore - 8).clamp(0, 100);
    notifyListeners();
  }

  void deductReliability(int cancelledCount) {
    if (cancelledCount <= 0) return;
    reliabilityScore = (reliabilityScore - (8 * cancelledCount)).clamp(0, 100);
    notifyListeners();
  }

  void updateOrderStatus(CafmateOrder order, CafmateOrderStatus status) {
    final index = orders.indexWhere((item) => item.id == order.id);
    if (index != -1) orders[index] = order.copyWith(status: status);
    notifyListeners();
  }

  void addProduct({
    required String name,
    required String category,
    required int wholesalePrice,
    required int moq,
  }) {
    products.add(CafmateProduct(
      id: 'p${products.length + 1}',
      name: name,
      category: category,
      supplier: 'Supplier baru',
      wholesalePrice: wholesalePrice,
      marketPrice: wholesalePrice + 25000,
      quantity: 0,
      moq: moq,
      unit: 'kg',
      area: 'Bandung Selatan',
      deadline: '7 hari dari sekarang',
    ));
    notifyListeners();
  }

  void addAnnouncement(String title, String summary) {
    announcements.insert(
      0,
      CafeInfo(
        id: 'a${announcements.length + 1}',
        title: title,
        summary: summary,
        publishedAt: 'Baru saja',
      ),
    );
    notifyListeners();
  }
}

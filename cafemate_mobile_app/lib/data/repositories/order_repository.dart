import 'package:flutter/foundation.dart';

import '../../domain/models/cafmate_order.dart';
import '../../domain/models/cafmate_product.dart';
import '../services/cafemate_service.dart';

/// Repository data aksi (keranjang) yang memberi tahu Beranda, Checklist,
/// dan badge tab setiap kali isi keranjang berubah.
class OrderRepository extends ChangeNotifier {
  OrderRepository(this._service);
  final CafeMateService _service;

  List<CafmateOrder> _orders = const [];
  bool _loaded = false;
  Future<void>? _inFlight;

  List<CafmateOrder> get cartOrders =>
      _orders.where((order) => !order.isRemovedFromCart).toList();

  List<CafmateOrder> get removedOrders =>
      _orders.where((order) => order.isRemovedFromCart).toList();

  int get pendingBadgeCount => cartOrders.length;

  int get totalSavings =>
      cartOrders.fold(0, (sum, order) => sum + (order.quantity * 27000));

  /// Beranda dan Checklist memanggil ini bersamaan saat aplikasi dibuka,
  /// jadi satu permintaan yang sedang berjalan dipakai ulang.
  Future<void> load({bool forceRefresh = false}) {
    if (_loaded && !forceRefresh) return Future<void>.value();
    return _inFlight ??= _fetch();
  }

  Future<void> _fetch() async {
    try {
      _orders = await _service.fetchOrders();
      _loaded = true;
      notifyListeners();
    } finally {
      _inFlight = null;
    }
  }

  void addOrder(CafmateProduct product, int quantity) {
    if (quantity <= 0) return;
    final nextId =
        'o${_orders.length + 1}_${DateTime.now().millisecondsSinceEpoch}';
    _orders = [
      ..._orders,
      CafmateOrder(
        id: nextId,
        productId: product.id,
        productName: product.name,
        quantity: quantity,
        unit: product.unit,
        total: quantity * product.wholesalePrice,
        status: CafmateOrderStatus.waiting,
      ),
    ];
    _loaded = true;
    notifyListeners();
  }

  /// Menghapus pesanan dari keranjang (atau mengembalikannya).
  void setRemovedFromCart(String orderId, bool removed) {
    _orders = [
      for (final order in _orders)
        order.id == orderId ? order.copyWith(isRemoved: removed) : order,
    ];
    notifyListeners();
  }
}

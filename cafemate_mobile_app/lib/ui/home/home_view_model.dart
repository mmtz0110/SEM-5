import 'package:flutter/foundation.dart';

import '../../data/repositories/order_repository.dart';
import '../../data/repositories/product_repository.dart';
import '../../domain/models/cafmate_order.dart';
import '../../domain/models/cafmate_product.dart';

/// ViewModel Beranda: menggabungkan data utama (produk hari ini) dari
/// [ProductRepository] dan data aksi yang belum selesai dari
/// [OrderRepository].
class HomeViewModel extends ChangeNotifier {
  HomeViewModel(this._productRepository, this._orderRepository) {
    _orderRepository.addListener(_syncOrders);
  }

  final ProductRepository _productRepository;
  final OrderRepository _orderRepository;

  bool isLoading = false;
  String? error;
  List<CafmateProduct> products = const [];

  List<CafmateProduct> get todayProducts => products.take(3).toList();
  List<CafmateOrder> get pendingCartOrders => _orderRepository.cartOrders;
  int get pendingCount => _orderRepository.pendingBadgeCount;
  int get totalSavings => _orderRepository.totalSavings;

  Future<void> load({bool forceRefresh = false}) async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      final results = await Future.wait([
        _productRepository.getProducts(forceRefresh: forceRefresh),
        _orderRepository.load(forceRefresh: forceRefresh),
      ]);
      products = results[0] as List<CafmateProduct>;
    } catch (exception) {
      error = exception.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// Menghapus pesanan dari keranjang langsung dari Beranda.
  void removeFromCart(CafmateOrder order) {
    _orderRepository.setRemovedFromCart(order.id, true);
  }

  void _syncOrders() => notifyListeners();

  @override
  void dispose() {
    _orderRepository.removeListener(_syncOrders);
    super.dispose();
  }
}

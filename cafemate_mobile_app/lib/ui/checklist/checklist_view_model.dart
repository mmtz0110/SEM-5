import 'package:flutter/foundation.dart';

import '../../data/repositories/order_repository.dart';
import '../../domain/models/cafmate_order.dart';

/// ViewModel Checklist hapus pesanan di keranjang.
///
/// Repository data aksi adalah `ChangeNotifier`, sehingga perubahan di sini
/// ikut memperbarui Beranda dan badge tab Checklist.
class ChecklistViewModel extends ChangeNotifier {
  ChecklistViewModel(this._repository) {
    _repository.addListener(_sync);
  }

  final OrderRepository _repository;

  bool isLoading = false;
  String? error;

  List<CafmateOrder> get cartOrders => _repository.cartOrders;
  List<CafmateOrder> get removedOrders => _repository.removedOrders;
  int get pendingCount => _repository.pendingBadgeCount;

  Future<void> load({bool forceRefresh = false}) async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      await _repository.load(forceRefresh: forceRefresh);
    } catch (exception) {
      error = exception.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void setRemoved(CafmateOrder order, bool removed) {
    _repository.setRemovedFromCart(order.id, removed);
  }

  void _sync() => notifyListeners();

  @override
  void dispose() {
    _repository.removeListener(_sync);
    super.dispose();
  }
}

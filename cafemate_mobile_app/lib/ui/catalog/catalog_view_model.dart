import 'package:flutter/foundation.dart';

import '../../data/repositories/order_repository.dart';
import '../../data/repositories/product_repository.dart';
import '../../domain/models/cafmate_product.dart';

/// ViewModel halaman Daftar: data utama per kategori kloter.
class CatalogViewModel extends ChangeNotifier {
  CatalogViewModel(this._productRepository, this._orderRepository);

  final ProductRepository _productRepository;
  final OrderRepository _orderRepository;

  static const categories = ['Semua', 'Biji kopi', 'Susu', 'Sirup'];

  bool isLoading = false;
  String? error;
  List<CafmateProduct> products = const [];
  String selectedCategory = 'Semua';

  List<CafmateProduct> get filteredProducts => selectedCategory == 'Semua'
      ? products
      : products
          .where((product) => product.category == selectedCategory)
          .toList();

  Future<void> load({bool forceRefresh = false}) async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      products = await _productRepository.getProducts(forceRefresh: forceRefresh);
    } catch (exception) {
      error = exception.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void selectCategory(String category) {
    selectedCategory = category;
    notifyListeners();
  }

  Future<void> addToCart(CafmateProduct product, int quantity) async {
    if (quantity <= 0) return;
    _orderRepository.addOrder(product, quantity);
    _productRepository.incrementQuantity(product.id, quantity);
    products = await _productRepository.getProducts();
    notifyListeners();
  }
}

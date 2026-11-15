import '../../domain/models/cafmate_product.dart';
import '../services/cafemate_service.dart';

class ProductRepository {
  ProductRepository(this._service);
  final CafeMateService _service;

  List<CafmateProduct> _cache = const [];
  Future<List<CafmateProduct>>? _inFlight;

  /// Beranda dan Daftar memuat produk bersamaan saat aplikasi dibuka,
  /// jadi satu permintaan yang sedang berjalan dipakai ulang.
  Future<List<CafmateProduct>> getProducts({bool forceRefresh = false}) {
    if (!forceRefresh && _cache.isNotEmpty) {
      return Future.value(List.unmodifiable(_cache));
    }
    return _inFlight ??= _fetch();
  }

  Future<List<CafmateProduct>> _fetch() async {
    try {
      _cache = await _service.fetchProducts();
      return List.unmodifiable(_cache);
    } finally {
      _inFlight = null;
    }
  }

  void incrementQuantity(String productId, int delta) {
    if (delta <= 0) return;
    _cache = [
      for (final product in _cache)
        product.id == productId
            ? product.copyWith(quantity: product.quantity + delta)
            : product,
    ];
  }
}

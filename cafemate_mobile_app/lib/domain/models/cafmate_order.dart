enum CafmateOrderStatus { waiting, locked, shipping, completed, cancelled }

/// Data aksi: pesanan yang tersimpan di keranjang cafe.
///
/// [isRemoved] menandai pesanan yang sudah dihapus lewat halaman Checklist.
/// Status pesanan tetap disimpan apa adanya, sehingga mengembalikan pesanan
/// dari bagian Selesai tidak mengubah status aslinya.
class CafmateOrder {
  const CafmateOrder({
    required this.id,
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.unit,
    required this.total,
    required this.status,
    this.isRemoved = false,
  });

  final String id;
  final String productId;
  final String productName;
  final int quantity;
  final String unit;
  final int total;
  final CafmateOrderStatus status;
  final bool isRemoved;

  bool get isRemovedFromCart => isRemoved;

  factory CafmateOrder.fromJson(Map<String, dynamic> json) => CafmateOrder(
        id: json['id'] as String,
        productId: json['productId'] as String,
        productName: json['productName'] as String,
        quantity: json['quantity'] as int,
        unit: json['unit'] as String,
        total: json['total'] as int,
        status: CafmateOrderStatus.values.byName(json['status'] as String),
        isRemoved: json['isRemoved'] as bool? ?? false,
      );

  CafmateOrder copyWith({
    CafmateOrderStatus? status,
    int? quantity,
    int? total,
    bool? isRemoved,
  }) =>
      CafmateOrder(
        id: id,
        productId: productId,
        productName: productName,
        quantity: quantity ?? this.quantity,
        unit: unit,
        total: total ?? this.total,
        status: status ?? this.status,
        isRemoved: isRemoved ?? this.isRemoved,
      );
}

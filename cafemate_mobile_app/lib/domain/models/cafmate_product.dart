class CafmateProduct {
  const CafmateProduct({
    required this.id,
    required this.name,
    required this.category,
    required this.supplier,
    required this.wholesalePrice,
    required this.marketPrice,
    required this.quantity,
    required this.moq,
    required this.unit,
    required this.area,
    required this.deadline,
  });

  final String id;
  final String name;
  final String category;
  final String supplier;
  final int wholesalePrice;
  final int marketPrice;
  final int quantity;
  final int moq;
  final String unit;
  final String area;
  final String deadline;

  double get progress => (quantity / moq).clamp(0, 1).toDouble();
  int get saving => marketPrice - wholesalePrice;

  factory CafmateProduct.fromJson(Map<String, dynamic> json) => CafmateProduct(
        id: json['id'] as String,
        name: json['name'] as String,
        category: json['category'] as String,
        supplier: json['supplier'] as String,
        wholesalePrice: json['wholesalePrice'] as int,
        marketPrice: json['marketPrice'] as int,
        quantity: json['quantity'] as int,
        moq: json['moq'] as int,
        unit: json['unit'] as String,
        area: json['area'] as String,
        deadline: json['deadline'] as String,
      );

  CafmateProduct copyWith({int? quantity}) => CafmateProduct(
        id: id,
        name: name,
        category: category,
        supplier: supplier,
        wholesalePrice: wholesalePrice,
        marketPrice: marketPrice,
        quantity: quantity ?? this.quantity,
        moq: moq,
        unit: unit,
        area: area,
        deadline: deadline,
      );
}

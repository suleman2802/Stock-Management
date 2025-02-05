import 'radiator_stock.dart';

enum SaleType { retail, wholesale, other }

class SaleItem {
  final String id;
  final int quantity;
  final double sellingPrice;
  final SaleType saleType;
  RadiatorStock radiator;

  SaleItem({
    String? id,
    required this.quantity,
    required this.radiator,
    required this.saleType,
    required this.sellingPrice,
  }) : id = id ?? DateTime.now().millisecondsSinceEpoch.toString();

  SaleItem copyWith({
    String? id,
    int? quantity,
    double? sellingPrice,
    SaleType? saleType,
    RadiatorStock? radiator,
  }) {
    return SaleItem(
      id: id ?? this.id,
      quantity: quantity ?? this.quantity,
      sellingPrice: sellingPrice ?? this.sellingPrice,
      saleType: saleType ?? this.saleType,
      radiator: radiator ?? this.radiator,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'quantity': quantity,
      'sellingPrice': sellingPrice,
      'saleType': saleType.toString().split('.').last,
      'radiator': radiator.toMap(),
    };
  }

  factory SaleItem.fromMap(Map<String, dynamic> map) {
    return SaleItem(
      id: map['id'] as String,
      quantity: map['quantity'] as int,
      sellingPrice: map['sellingPrice'] as double,
      saleType: SaleType.values.firstWhere((e) => e.toString() == 'SaleType.' + map['saleType']),
      radiator: RadiatorStock.fromMap(map['radiator'] as Map<String, dynamic>),
    );
  }
}
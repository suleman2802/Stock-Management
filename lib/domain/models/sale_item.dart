import 'radiator_stock.dart';

enum SaleType { retail, wholesale, other }

class SaleItem {
  final String id;
  final int quantity;
  final double unitCost;
  final double subTotal;
  final SaleType saleType;
  RadiatorStock? radiator;

  SaleItem({
    String? id,
    required this.quantity,
    this.radiator,
    required this.unitCost,
    required this.saleType,
    required this.subTotal,
  }) : id = id ?? DateTime.now().millisecondsSinceEpoch.toString();

  SaleItem copyWith({
    String? id,
    int? quantity,
    double? subTotal,
    double? unitCost,
    SaleType? saleType,
    RadiatorStock? radiator,
  }) {
    return SaleItem(
      id: id ?? this.id,
      quantity: quantity ?? this.quantity,
      unitCost: unitCost ?? this.subTotal,
      subTotal: subTotal ?? this.subTotal,
      saleType: saleType ?? this.saleType,
      radiator: radiator ?? this.radiator,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'quantity': quantity,
      'unitCost': unitCost,
      'subTotal': subTotal,
      'saleType': saleType.toString().split('.').last,
      'radiator': radiator!.toMap(),
    };
  }

  factory SaleItem.fromMap(Map<String, dynamic> map) {
    return SaleItem(
      id: map['id'] as String,
      quantity: map['quantity'] as int,
      subTotal: map['subTotal'] as double,
      unitCost: map['unitCost'] as double,
      saleType: SaleType.values
          .firstWhere((e) => e.toString() == 'SaleType.' + map['saleType']),
      radiator: RadiatorStock.fromMap(map['radiator'] as Map<String, dynamic>),
    );
  }
}

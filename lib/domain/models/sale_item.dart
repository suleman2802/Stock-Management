import 'car.dart';
import 'radiator_stock.dart';

enum SaleType { retail, wholesale, other }

class SaleItem {
  final String id;
  final int quantity;
  final double unitCost;
  final double subTotal;
  final bool isRetail;
  final Car? car;
  RadiatorStock? radiator;

  SaleItem(
      {String? id,
      required this.quantity,
      this.radiator,
      required this.unitCost,
      required this.isRetail,
      required this.subTotal,
      this.car})
      : id = id ?? DateTime.now().millisecondsSinceEpoch.toString();

  SaleItem copyWith({
    String? id,
    int? quantity,
    double? subTotal,
    double? unitCost,
    bool? isRetail,
    Car? car,
    RadiatorStock? radiator,
  }) {
    return SaleItem(
        id: id ?? this.id,
        quantity: quantity ?? this.quantity,
        unitCost: unitCost ?? this.subTotal,
        subTotal: subTotal ?? this.subTotal,
        isRetail: isRetail ?? this.isRetail,
        radiator: radiator ?? this.radiator,
        car: car ?? this.car);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'quantity': quantity,
      'unitCost': unitCost,
      'subTotal': subTotal,
      'isRetail': isRetail,
      "car": car?.toMap() ?? {},
      'radiator': radiator!.toMap(),
    };
  }

  factory SaleItem.fromMap(Map<String, dynamic> map) {
    return SaleItem(
      id: map['id'] as String,
      quantity: map['quantity'] as int,
      subTotal: map['subTotal'] as double,
      unitCost: map['unitCost'] as double,
      isRetail: map['isRetail'] as bool,
      car: Car.fromMap(map['car'] as Map<String, dynamic>),
      radiator: RadiatorStock.fromMap(map['radiator'] as Map<String, dynamic>),
    );
  }
}

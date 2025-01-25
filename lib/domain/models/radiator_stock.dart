// import 'company.dart';
// import 'radiator.dart';

// class RadiatorStock {
//   final String id;
//   final int quantity;
//   final double profitInWholesalePrice;
//   final double profitInRetailPrice;
//   final double retailPrice;
//   final double retailProfitMargin;
//   final double wholesaleRate;
//   final double wholesaleProfitMargin;
//   final double unitCost;
//   final Company company;
//   final Radiator radiator;
//   RadiatorStock({
//     required this.id,
//     required this.quantity,
//     required this.profitInWholesalePrice,
//     required this.profitInRetailPrice,
//     required this.retailPrice,
//     required this.retailProfitMargin,
//     required this.wholesaleRate,
//     required this.wholesaleProfitMargin,
//     required this.unitCost,
//     required this.company,
//     required this.radiator,
//   });
// }

import 'company.dart';
import 'radiator.dart';

class RadiatorStock {
  final String id;
  final int quantity;
  final double profitInWholesalePrice;
  final double profitInRetailPrice;
  final double retailPrice;
  final double retailProfitMargin;
  final double wholesaleRate;
  final double wholesaleProfitMargin;
  final double unitCost;
  final Company? company;
  final Radiator? radiator;

  RadiatorStock({
    String? id,
    required this.quantity,
    required this.profitInWholesalePrice,
    required this.profitInRetailPrice,
    required this.retailPrice,
    required this.retailProfitMargin,
    required this.wholesaleRate,
    required this.wholesaleProfitMargin,
    required this.unitCost,
    required this.company,
    required this.radiator,
  }) : id = id ?? DateTime.now().millisecondsSinceEpoch.toString();

  RadiatorStock copyWith({
    String? id,
    int? quantity,
    double? profitInWholesalePrice,
    double? profitInRetailPrice,
    double? retailPrice,
    double? retailProfitMargin,
    double? wholesaleRate,
    double? wholesaleProfitMargin,
    double? unitCost,
    Company? company,
    Radiator? radiator,
  }) {
    return RadiatorStock(
      id: id ?? this.id,
      quantity: quantity ?? this.quantity,
      profitInWholesalePrice:
          profitInWholesalePrice ?? this.profitInWholesalePrice,
      profitInRetailPrice: profitInRetailPrice ?? this.profitInRetailPrice,
      retailPrice: retailPrice ?? this.retailPrice,
      retailProfitMargin: retailProfitMargin ?? this.retailProfitMargin,
      wholesaleRate: wholesaleRate ?? this.wholesaleRate,
      wholesaleProfitMargin:
          wholesaleProfitMargin ?? this.wholesaleProfitMargin,
      unitCost: unitCost ?? this.unitCost,
      company: company ?? this.company,
      radiator: radiator ?? this.radiator,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'quantity': quantity,
      'profitInWholesalePrice': profitInWholesalePrice,
      'profitInRetailPrice': profitInRetailPrice,
      'retailPrice': retailPrice,
      'retailProfitMargin': retailProfitMargin,
      'wholesaleRate': wholesaleRate,
      'wholesaleProfitMargin': wholesaleProfitMargin,
      'unitCost': unitCost,
      'company': company!.toMap(),
      'radiator': radiator!.toMap(),
    };
  }

  factory RadiatorStock.fromMap(Map<String, dynamic> map) {
    return RadiatorStock(
      id: map['id'] as String,
      quantity: map['quantity'] as int,
      profitInWholesalePrice: map['profitInWholesalePrice'] as double,
      profitInRetailPrice: map['profitInRetailPrice'] as double,
      retailPrice: map['retailPrice'] as double,
      retailProfitMargin: map['retailProfitMargin'] as double,
      wholesaleRate: map['wholesaleRate'] as double,
      wholesaleProfitMargin: map['wholesaleProfitMargin'] as double,
      unitCost: map['unitCost'] as double,
      company: Company.fromMap(map['company'] as Map<String, dynamic>),
      radiator: Radiator.fromMap(map['radiator'] as Map<String, dynamic>),
    );
  }
}

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
  final String company;
  final Radiator radiator;
  RadiatorStock({
    required this.id,
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
  });
}

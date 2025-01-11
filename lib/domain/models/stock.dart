import 'rows.dart';
import 'car.dart';

class Stock {
  final int id;
  final double profitInWholesalePrice;
  final double profitInRetailPrice;
  final double retailPrice;
  final double retailProfitMargin;
  final double wholesaleRate;
  final double wholesaleProfitMargin;
  final double unitCost;
  final DateTime dateTimeOfAddingStock;
  final int quantity;
  final Rows rows;
  final Car car;

  Stock({
    required this.id,
    required this.profitInWholesalePrice,
    required this.profitInRetailPrice,
    required this.retailPrice,
    required this.retailProfitMargin,
    required this.wholesaleRate,
    required this.wholesaleProfitMargin,
    required this.unitCost,
    required this.dateTimeOfAddingStock,
    required this.quantity,
    required this.rows,
    required this.car,
  });
}

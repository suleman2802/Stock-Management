import 'package:stock_management_application/domain/models/radiator_stock.dart';

class SaleItem {
  final String id;
  final int quantity;
  final double price;
  final bool isRetail;
  RadiatorStock radiator;

  SaleItem({
    required this.id,
    required this.quantity,
    required this.radiator,
    required this.isRetail,
    required this.price,
  });
}

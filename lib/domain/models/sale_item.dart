import 'radiator.dart';

class SaleItem {
  final String id;
  final int quantity;
  Radiator radiator;

  SaleItem({
    required this.id,
    required this.quantity,
    required this.radiator,
  });
}

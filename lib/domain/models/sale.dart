import 'sale_item.dart';

class Sale {
  final String id;
  final DateTime date;
  final DateTime time;
  final String customerName;
  final double totalBill;
  List<SaleItem> saleItems;

  Sale({
    required this.customerName,
    required this.date,
    required this.time,
    required this.totalBill,
    required this.id,
    required this.saleItems,
  });
}

import 'sale_item.dart';

class Sale {
  final String id;
  final DateTime date;
  final DateTime time;
  final String customerName;
  final double totalBill;
  List<SaleItem> saleItems;

  Sale({
    String? id,
    required this.customerName,
    required this.date,
    required this.time,
    required this.totalBill,
    required this.saleItems,
  }) : id = id ?? DateTime.now().millisecondsSinceEpoch.toString();

  Sale copyWith({
    String? id,
    DateTime? date,
    DateTime? time,
    String? customerName,
    double? totalBill,
    List<SaleItem>? saleItems,
  }) {
    return Sale(
      id: id ?? this.id,
      customerName: customerName ?? this.customerName,
      date: date ?? this.date,
      time: time ?? this.time,
      totalBill: totalBill ?? this.totalBill,
      saleItems: saleItems ?? this.saleItems,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'time': time.toIso8601String(),
      'customerName': customerName,
      'totalBill': totalBill,
      'saleItems': saleItems.map((e) => e.toMap()).toList(),
    };
  }

  factory Sale.fromMap(Map<String, dynamic> map) {
    return Sale(
      id: map['id'] as String,
      customerName: map['customerName'] as String,
      date: DateTime.parse(map['date'] as String),
      time: DateTime.parse(map['time'] as String),
      totalBill: map['totalBill'] as double,
      saleItems: List<SaleItem>.from(
        (map['saleItems'] as List)
            .map((e) => SaleItem.fromMap(e as Map<String, dynamic>)),
      ),
    );
  }
}

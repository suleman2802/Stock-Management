// import 'car.dart';
// import 'radiator_stock.dart';

// class Stock {
//   final String id;
//   final DateTime date;
//   final DateTime time;
//   final Car car;
//   List<RadiatorStock> radiatorStock;

//   Stock({
//     required this.id,
//     required this.date,
//     required this.time,
//     required this.car,
//     required this.radiatorStock,
//   });
// }


import 'car.dart'; 
import 'radiator_stock.dart';

class Stock {
  final String id;
  final DateTime date;
  final DateTime time;
  final Car car;
  List<RadiatorStock> radiatorStock;

  Stock({
    required this.id,
    required this.date,
    required this.time,
    required this.car,
    required this.radiatorStock,
  });

  Stock copyWith({
    String? id,
    DateTime? date,
    DateTime? time,
    Car? car,
    List<RadiatorStock>? radiatorStock,
  }) {
    return Stock(
      id: id ?? this.id,
      date: date ?? this.date,
      time: time ?? this.time,
      car: car ?? this.car,
      radiatorStock: radiatorStock ?? this.radiatorStock,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'time': time.toIso8601String(),
      'car': car.toMap(),
      'radiatorStock': radiatorStock.map((e) => e.toMap()).toList(),
    };
  }

  factory Stock.fromMap(Map<String, dynamic> map) {
    return Stock(
      id: map['id'] as String,
      date: DateTime.parse(map['date'] as String),
      time: DateTime.parse(map['time'] as String),
      car: Car.fromMap(map['car'] as Map<String, dynamic>),
      radiatorStock: List<RadiatorStock>.from(
        (map['radiatorStock'] as List).map((e) => RadiatorStock.fromMap(e as Map<String, dynamic>)),
      ),
    );
  }
}

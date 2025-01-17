import 'car.dart';
import 'radiatorStock.dart';

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
}

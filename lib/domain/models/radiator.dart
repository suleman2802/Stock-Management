import 'rows.dart';
import 'car.dart';

class Radidator {
  final int id;
  final String size;
  final CarFuelType carFuelType;
  final CarAutomation carAutomation;
  final int fromYear;
  final int toYear;
  final Rows rows;
  final Car car;

  Radidator({
    required this.id,
    required this.size,
    required this.carFuelType,
    required this.carAutomation,
    required this.fromYear,
    required this.toYear,
    required this.rows,
    required this.car,
  });
}

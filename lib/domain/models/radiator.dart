import 'fin.dart';
import 'rows.dart';
import 'car.dart';

enum CarFuelType { petrol, diesel }
enum CarAutomation {automatic,manual}

class Radiator {
  final String id;
  final String size;
  final CarFuelType carFuelType;
  final CarAutomation carAutomation;
  final int fromYear;
  final int toYear;
  final Rows rows;
  final Fin fin;
  final Car car;

  Radiator({
    required this.id,
    required this.size,
    required this.carFuelType,
    required this.carAutomation,
    required this.fromYear,
    required this.toYear,
    required this.rows,
    required this.car,
    required this.fin,
  });
}

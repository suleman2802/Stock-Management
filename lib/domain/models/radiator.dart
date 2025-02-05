import 'fin.dart';
import 'rows.dart';
import 'car.dart';

enum CarFuelType { petrol, diesel }
enum CarAutomation { automatic, manual }

class Radiator {
  final String id;
  final String size;
  final CarFuelType carFuelType;
  final CarAutomation carAutomation;
  final int fromYear;
  final int toYear;
  final Rows? rows;
  final Fin? fin;
  final Car car;

  Radiator({
    String? id,
    required this.size,
    required this.carFuelType,
    required this.carAutomation,
    required this.fromYear,
    required this.toYear,
    required this.rows,
    required this.car,
    required this.fin,
  }) : id = id ?? DateTime.now().millisecondsSinceEpoch.toString();

  Radiator copyWith({
    String? id,
    String? size,
    CarFuelType? carFuelType,
    CarAutomation? carAutomation,
    int? fromYear,
    int? toYear,
    Rows? rows,
    Fin? fin,
    Car? car,
  }) {
    return Radiator(
      id: id ?? this.id,
      size: size ?? this.size,
      carFuelType: carFuelType ?? this.carFuelType,
      carAutomation: carAutomation ?? this.carAutomation,
      fromYear: fromYear ?? this.fromYear,
      toYear: toYear ?? this.toYear,
      rows: rows ?? this.rows,
      fin: fin ?? this.fin,
      car: car ?? this.car,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'size': size,
      'carFuelType': carFuelType.toString().split('.').last,
      'carAutomation': carAutomation.toString().split('.').last,
      'fromYear': fromYear,
      'toYear': toYear,
      'rows': rows!.toMap(),
      'fin': fin!.toMap(),
      'car': car.toMap(),
    };
  }

  factory Radiator.fromMap(Map<String, dynamic> map) {
    return Radiator(
      id: map['id'] as String,
      size: map['size'] as String,
      carFuelType: CarFuelType.values.firstWhere((e) => e.toString() == 'CarFuelType.' + map['carFuelType']),
      carAutomation: CarAutomation.values.firstWhere((e) => e.toString() == 'CarAutomation.' + map['carAutomation']),
      fromYear: map['fromYear'] as int,
      toYear: map['toYear'] as int,
      rows: Rows.fromMap(map['rows'] as Map<String, dynamic>),
      fin: Fin.fromMap(map['fin'] as Map<String, dynamic>),
      car: Car.fromMap(map['car'] as Map<String, dynamic>),
    );
  }
}

enum CarFuelType { petrol, diesel }
enum CarAutomation {automatic,manual}

class Car {
  final String carName;
  final String carModel;
  final String carCompany;
  final CarFuelType carFuelType;
  final CarAutomation carAutomation;
  final int fromYear;
  final int toYear;

  Car({
    required this.carName,
    required this.carModel,
    required this.carCompany,
    required this.carFuelType,
    required this.carAutomation,
    required this.fromYear,
    required this.toYear,
  });

}

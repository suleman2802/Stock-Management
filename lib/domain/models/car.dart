enum CarFuelType { petrol, diesel }
enum CarAutomation {automatic,manual}

class Car {
  final String id;
  final String carName;
  final String carModel;
  final String carCompany;


  Car({
    required this.id,
    required this.carName,
    required this.carModel,
    required this.carCompany,
  });

}

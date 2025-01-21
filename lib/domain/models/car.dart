class Car {
  final String id;
  final String carName;
  final String carModel;
  final String carCompany;
  Car({
    String? id,
    required this.carName,
    required this.carModel,
    required this.carCompany,
  }) : id = id ?? DateTime.now().millisecondsSinceEpoch.toString();

  Car copyWith({
    String? id,
    String? carName,
    String? carModel,
    String? carCompany,
  }) {
    return Car(
      id: id ?? this.id,
      carName: carName ?? this.carName,
      carModel: carModel ?? this.carModel,
      carCompany: carCompany ?? this.carCompany,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'carName': carName,
      'carModel': carModel,
      'carCompany': carCompany,
    };
  }

  factory Car.fromMap(Map<String, dynamic> map) {
    return Car(
      id: map['id'] as String,
      carName: map['carName'] as String,
      carModel: map['carModel'] as String,
      carCompany: map['carCompany'] as String,
    );
  }
}

import '../../../models/car.dart';

abstract class CarRepository {
  Future<List<Car>> getAllCars(bool isAluminium);
  Future<bool> addNewCar(Car car, bool isAluminium);
  Future<bool> updateCar(Car car, bool isAluminium);
  Future<bool> deleteCar(String id, bool isAluminium);
  Future<List<Car>> getAllCarByName(String carName, bool isAluminium);
}

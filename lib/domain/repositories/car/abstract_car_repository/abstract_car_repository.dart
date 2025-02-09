import '../../../models/car.dart';

abstract class CarRepository {
  Future<List<Car>> getAllCars();
  Future<bool> addNewCar(Car car);
  Future<bool> updateCar(Car car);
  Future<bool> deleteCar(String id);
  Future<List<Car>> getAllCarByName(String carName);
}

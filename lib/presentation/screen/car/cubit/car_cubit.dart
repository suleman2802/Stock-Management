import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stock_management_application/domain/repositories/car/abstract_car_repository/abstract_car_repository.dart';

import '../../../../domain/models/car.dart';

part 'car_state.dart';

class CarCubit extends Cubit<CarState> {
  final CarRepository carRepository;
  CarCubit({required this.carRepository}) : super(CarInitialState()) {
    fetchAllCars(true);
  }
  Future<void> fetchAllCarsByName(String name, bool isAluminium) async {
    try {
      emit(CarLoadingState());
      final List<Car> carList =
          await carRepository.getAllCarByName(name, isAluminium);
      emit(
        CarLoadedState(
          carList: carList,
        ),
      );
    } catch (error) {
      emit(CarErrorState(errorMessage: error.toString()));
    }
  }

  Future<void> fetchAllCars(bool isAluminium) async {
    try {
      emit(CarLoadingState());
      final List<Car> carList = await carRepository.getAllCars(isAluminium);
      emit(
        CarLoadedState(
          carList: carList,
        ),
      );
    } catch (error) {
      emit(CarErrorState(errorMessage: error.toString()));
    }
  }

  Future<bool> addNewCar(Car car, bool isAluminium) async {
    try {
      final bool isAddedSuccessfully =
          await carRepository.addNewCar(car, isAluminium);
      await fetchAllCars(isAluminium);
      return isAddedSuccessfully;
    } catch (error) {
      log("Unable to add Car $error");
      await fetchAllCars(isAluminium);
      return false;
    }
  }

  Future<bool> updateCar(Car car, bool isAluminium) async {
    try {
      final bool isUpdatedSuccessfully =
          await carRepository.updateCar(car, isAluminium);
      await fetchAllCars(isAluminium);
      return isUpdatedSuccessfully;
    } catch (error) {
      log("Unable to upadate Car Size $error");
      await fetchAllCars(isAluminium);
      return false;
    }
  }

  Future<bool> deleteCar(String id, bool isAluminium) async {
    try {
      final bool isDeletedSuccessfully =
          await carRepository.deleteCar(id, isAluminium);
      await fetchAllCars(isAluminium);
      return isDeletedSuccessfully;
    } catch (error) {
      log("Unable to delete Car $error");
      await fetchAllCars(isAluminium);
      return false;
    }
  }
}

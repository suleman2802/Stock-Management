import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../models/car.dart';
import '../abstract_car_repository/abstract_car_repository.dart';

class CarRepositoryImplementation implements CarRepository {
  FirebaseFirestore firestoreInstance;
  CarRepositoryImplementation(this.firestoreInstance);
  @override
  Future<bool> addNewCar(Car car) async {
    try {
      await firestoreInstance.collection('cars').doc(car.id).set(car.toMap());

      log('Fin with ID $car.id added successfully.');
      return true;
    } catch (e) {
      log('Failed to add car: $e');
      return false;
    }
  }

  @override
  Future<bool> deleteCar(String id) async {
    try {
      await firestoreInstance.collection('cars').doc(id).delete();

      log('car with ID $id deleted successfully.');
      return true;
    } catch (e) {
      log('Failed to delete car: $e');
      return false;
    }
  }

  @override
  Future<List<Car>> getAllCars() async {
    try {
      QuerySnapshot snapshot = await firestoreInstance.collection('cars').get();

      List<Car> cars = snapshot.docs.map((doc) {
        return Car.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();

      log('Retrieved cars: $cars');
      return cars;
    } catch (e) {
      log('Failed to retrieve cars: $e');
      return [];
    }
  }

  @override
  Future<bool> updateCar(Car car) async {
    try {
      await firestoreInstance
          .collection('cars')
          .doc(car.id)
          .update(car.toMap());

      log('Car with ID ${car.id} updated successfully.');
      return true;
    } catch (e) {
      log('Failed to update car: $e');
      return false;
    }
  }
  
  @override
  Future<List<Car>> getAllCarByName(String carName)async {
   try {
      // Retrieve all companies from Firestore
      QuerySnapshot snapshot =
          await firestoreInstance.collection('cars').get();

      // Filter companies on the client side (case-insensitive partial match)
      List<Car> carList = snapshot.docs
          .where((doc) {
            final data = doc.data() as Map<String, dynamic>;
            final name = data['carName'] as String?;

            // Perform case-insensitive partial match
            return name?.toLowerCase().contains(carName.toLowerCase()) ??
                false;
          })
          .map((doc) => Car.fromMap(doc.data() as Map<String, dynamic>))
          .toList();

      // Debug: Print the filtered list
      log('Filtered cars for name $carName: $carList');
      return carList;
    } catch (e) {
      log('Failed to retrieve cars for name $carName: $e');
      return [];
    }
  }
}

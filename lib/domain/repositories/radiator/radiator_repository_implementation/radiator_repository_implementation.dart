import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../models/radiator.dart';
import '../abstract_radiator_repository/abstract_radiator_repository.dart';

class RadiatorRepositoryImplementation implements RadiatorRepository {
  final FirebaseFirestore firestoreInstance;
  RadiatorRepositoryImplementation(this.firestoreInstance);
  @override
  Future<bool> addNewRadiator(Radiator radiator, bool isAluminium) async {
    try {
      await firestoreInstance
          .collection(isAluminium ? 'radiatorsA' : 'radiatorsC')
          .doc(radiator.id)
          .set(radiator.toMap());

      log('Radiator with ID $radiator.id added successfully.');
      return true;
    } catch (e) {
      log('Failed to add radiator: $e');
      return false;
    }
  }

  @override
  Future<bool> deleteRadiator(String id, bool isAluminium) async {
    try {
      await firestoreInstance
          .collection(isAluminium ? 'radiatorsA' : 'radiatorsC')
          .doc(id)
          .delete();

      log('Radiator with ID $id deleted successfully.');
      return true;
    } catch (e) {
      log('Failed to delete Radiator: $e');
      return false;
    }
  }

  @override
  Future<List<Radiator>> getAllRadiators(bool isAluminium) async {
    try {
      QuerySnapshot snapshot = await firestoreInstance
          .collection(isAluminium ? 'radiatorsA' : 'radiatorsC')
          .get();

      List<Radiator> radiators = snapshot.docs.map((doc) {
        return Radiator.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();

      log('Retrieved radiators: $radiators');
      return radiators;
    } catch (e) {
      log('Failed to retrieve radiators: $e');
      return [];
    }
  }

  @override
  Future<bool> updateRadiator(Radiator radiator, bool isAluminium) async {
    try {
      await firestoreInstance
          .collection(isAluminium ? 'radiatorsA' : 'radiatorsC')
          .doc(radiator.id)
          .update(radiator.toMap());

      log('Radiator with ID ${radiator.id} updated successfully.');
      return true;
    } catch (e) {
      log('Failed to update radiator: $e');
      return false;
    }
  }

  @override
  Future<List<Radiator>> getAllRadiatorsByCarId(
      String carId, bool isAluminium) async {
    try {
      // Query Firestore to get documents where 'car.id' matches the given carId
      QuerySnapshot snapshot = await firestoreInstance
          .collection(isAluminium ? 'radiatorsA' : 'radiatorsC')
          .where('car.id', isEqualTo: carId)
          .get();

      // Map the documents to Radiator objects
      List<Radiator> radiators = snapshot.docs.map((doc) {
        return Radiator.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();

      log('Retrieved radiators for carId $carId: $radiators');
      return radiators;
    } catch (e) {
      log('Failed to retrieve radiators for carId $carId: $e');
      return [];
    }
  }

  @override
  Future<List<Radiator>> getAllRadiatorsBySize(
      String size, bool isAluminium) async {
    try {
      // Retrieve all radiators from Firestore
      QuerySnapshot snapshot = await firestoreInstance
          .collection(isAluminium ? 'radiatorsA' : 'radiatorsC')
          .get();

      // Filter radiators on the client side (case-insensitive partial match)
      List<Radiator> radiators = snapshot.docs
          .where((doc) {
            final data = doc.data() as Map<String, dynamic>;
            final radiatorSize = data['size'] as String?;

            // Debug: Print the size and the search term
            log('Checking radiator size: $radiatorSize against search term: $size');

            // Perform case-insensitive partial match
            return radiatorSize?.toLowerCase().contains(size.toLowerCase()) ??
                false;
          })
          .map((doc) => Radiator.fromMap(doc.data() as Map<String, dynamic>))
          .toList();

      // Debug: Print the filtered list
      log('Filtered radiators for size $size: $radiators');
      return radiators;
    } catch (e) {
      log('Failed to retrieve radiators for size $size: $e');
      return [];
    }
  }
}

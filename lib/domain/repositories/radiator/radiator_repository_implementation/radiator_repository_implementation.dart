import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../models/radiator.dart';
import '../abstract_radiator_repository/abstract_radiator_repository.dart';

class RadiatorRepositoryImplementation implements RadiatorRepository {
  final FirebaseFirestore firestoreInstance;
  RadiatorRepositoryImplementation(this.firestoreInstance);
  @override
  Future<bool> addNewRadiator(Radiator radiator) async {
    try {
      await firestoreInstance
          .collection('radiators')
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
  Future<bool> deleteRadiator(String id) async {
    try {
      await firestoreInstance.collection('radiators').doc(id).delete();

      log('Radiator with ID $id deleted successfully.');
      return true;
    } catch (e) {
      log('Failed to delete Radiator: $e');
      return false;
    }
  }

  @override
  Future<List<Radiator>> getAllRadiators() async {
    try {
      QuerySnapshot snapshot =
          await firestoreInstance.collection('radiators').get();

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
  Future<bool> updateRadiator(Radiator radiator) async {
    try {
      await firestoreInstance
          .collection('radiators')
          .doc(radiator.id)
          .update(radiator.toMap());

      log('Radiator with ID ${radiator.id} updated successfully.');
      return true;
    } catch (e) {
      log('Failed to update radiator: $e');
      return false;
    }
  }
}

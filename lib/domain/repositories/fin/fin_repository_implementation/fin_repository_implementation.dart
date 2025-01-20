import 'dart:developer';

import 'package:stock_management_application/domain/models/fin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../abstract_fin_repository/abstract_fin_repository.dart';

class FinRepositoryImplementation implements FinRepository {
  FirebaseFirestore firestoreInstance;
  FinRepositoryImplementation(this.firestoreInstance);
  @override
  Future<bool> addNewFinSize(Fin fin) async {
    try {
      await firestoreInstance
          .collection('fins')
          .doc(fin.id)
          .set(fin.toMap());

      log('Fin with ID $fin.id added successfully.');
      return true;
    } catch (e) {
      log('Failed to add fin: $e');
      return false;
    }
  }

  @override
  Future<bool> deleteFinSize(String id) async {
    try {
      await firestoreInstance.collection('fins').doc(id).delete();

      log('Fin with ID $id deleted successfully.');
      return true;
    } catch (e) {
      log('Failed to delete fin: $e');
      return false;
    }
  }

  @override
  Future<List<Fin>> getAllFinSizes() async {
    try {
      QuerySnapshot snapshot =
          await firestoreInstance.collection('fins').get();

      List<Fin> fins = snapshot.docs.map((doc) {
        return Fin.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();

      log('Retrieved fins: $fins');
      return fins;
    } catch (e) {
      log('Failed to retrieve fins: $e');
      return [];
    }
  }

  @override
  Future<bool> updateFinSize(Fin fin) async {
    try {
      await firestoreInstance
          .collection('fins')
          .doc(fin.id)
          .update(fin.toMap());

      log('Fin with ID ${fin.id} updated successfully.');
      return true;
    } catch (e) {
      log('Failed to update fin: $e');
      return false;
    }
  }
}

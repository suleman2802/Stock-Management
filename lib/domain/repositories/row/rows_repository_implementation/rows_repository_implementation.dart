import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../models/rows.dart';
import '../abstract_rows_repository/abstract_rows_repository.dart';

class RowsRepositoryImplementation implements RowsRepository {
  FirebaseFirestore firestoreInstance;
  RowsRepositoryImplementation(this.firestoreInstance);
  @override
  Future<bool> addNewRow(Rows rows) async {
    try {
      await firestoreInstance.collection('rows').doc(rows.id).set(rows.toMap());

      log('Rows with ID $rows.id added successfully.');
      return true;
    } catch (e) {
      log('Failed to add Rows: $e');
      return false;
    }
  }

  @override
  Future<bool> deleteRow(String id) async {
    try {
      await firestoreInstance.collection('rows').doc(id).delete();

      log('Rows with ID $id deleted successfully.');
      return true;
    } catch (e) {
      log('Failed to delete Rows: $e');
      return false;
    }
  }

  @override
  Future<List<Rows>> getAllRows() async {
    try {
      QuerySnapshot snapshot = await firestoreInstance.collection('rows').get();

      List<Rows> rowsList = snapshot.docs.map((doc) {
        return Rows.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();

      log('Retrieved Rows: $rowsList');
      return rowsList;
    } catch (e) {
      log('Failed to retrieve Rows: $e');
      return [];
    }
  }

  @override
  Future<bool> updateRow(Rows rows) async {
    try {
      await firestoreInstance
          .collection('Rows')
          .doc(rows.id)
          .update(rows.toMap());

      log('Rows with ID ${rows.id} updated successfully.');
      return true;
    } catch (e) {
      log('Failed to update Rows: $e');
      return false;
    }
  }
}

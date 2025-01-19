import 'package:stock_management_application/domain/models/fin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../abstract_fin_repository/abstract_fin_repository.dart';

class FinRepositoryImplementation implements FinRepository {
  @override
  Future<bool> addNewFinSize(Fin fin) async {
    try {
      // Reference to the 'fins' collection
      CollectionReference finsCollection =
          FirebaseFirestore.instance.collection('fins');

      // Add the integer value as a document to the collection
      await finsCollection.add({
        'fin_size': fin.finSize,
      });

      print('fin successfully stored in the fins collection.');
      return true;
    } catch (e) {
      print('Failed to store value in the fins collection: $e');
      return false;
    }
  }

  @override
  Future<bool> deleteFinSize(Fin fin) {
    // TODO: implement deleteFinSize
    throw UnimplementedError();
  }

  @override
  Future<Fin> getAllFinSizes() {
    // TODO: implement getAllFinSizes
    throw UnimplementedError();
  }

  @override
  Future<bool> updateFinSize(Fin fin) {
    // TODO: implement updateFinSize
    throw UnimplementedError();
  }
}

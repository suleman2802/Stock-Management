import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';


import '../../../models/sale.dart';
import '../abstract_sale_repository/abstract_sale_repository.dart';


class SaleRepositoryImplementation implements SaleRepository {
  final FirebaseFirestore firestoreInstance;
  SaleRepositoryImplementation(this.firestoreInstance);
  @override
  Future<bool> addNewSale(Sale sale) async {
    try {
      await firestoreInstance
          .collection('sales')
          .doc(sale.id)
          .set(sale.toMap());

      log('sale with ID $sale.id added successfully.');
      return true;
    } catch (e) {
      log('Failed to add sale: $e');
      return false;
    }
  }

  @override
  Future<bool> deleteSale(String id) async {
    try {
      await firestoreInstance.collection('sales').doc(id).delete();

      log('sale with ID $id deleted successfully.');
      return true;
    } catch (e) {
      log('Failed to delete sale: $e');
      return false;
    }
  }

  @override
  Future<List<Sale>> getAllSales() async {
    try {
      QuerySnapshot snapshot =
          await firestoreInstance.collection('sales').get();

      List<Sale> sales = snapshot.docs.map((doc) {
        return Sale.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();

      log('Retrieved sales: $sales');
      return sales;
    } catch (e) {
      log('Failed to retrieve sales: $e');
      return [];
    }
  }

  @override
  Future<bool> updateSale(Sale sale) async {
    try {
      await firestoreInstance
          .collection('sales')
          .doc(sale.id)
          .update(sale.toMap());

      log('sale with ID ${sale.id} updated successfully.');
      return true;
    } catch (e) {
      log('Failed to update sale: $e');
      return false;
    }
  }
}

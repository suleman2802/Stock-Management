import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';


import '../../../models/stock.dart';
import '../abstract_stock_repository/abstract_stock_repository.dart';

class StockRepositoryImplementation implements StockRepository {
  final FirebaseFirestore firestoreInstance;
  StockRepositoryImplementation(this.firestoreInstance);
  @override
  Future<bool> addNewStock(Stock stock) async {
    try {
      await firestoreInstance
          .collection('stocks')
          .doc(stock.id)
          .set(stock.toMap());

      log('Stock with ID $stock.id added successfully.');
      return true;
    } catch (e) {
      log('Failed to add Stock: $e');
      return false;
    }
  }

  @override
  Future<bool> deleteStock(String id) async {
    try {
      await firestoreInstance.collection('stocks').doc(id).delete();

      log('Stock with ID $id deleted successfully.');
      return true;
    } catch (e) {
      log('Failed to delete Stock: $e');
      return false;
    }
  }

  @override
  Future<List<Stock>> getAllStocks() async {
    try {
      QuerySnapshot snapshot =
          await firestoreInstance.collection('stocks').get();

      List<Stock> stocks = snapshot.docs.map((doc) {
        return Stock.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();

      log('Retrieved Stocks: $stocks');
      return stocks;
    } catch (e) {
      log('Failed to retrieve Stocks: $e');
      return [];
    }
  }

  @override
  Future<bool> updateStock(Stock stock) async {
    try {
      await firestoreInstance
          .collection('stocks')
          .doc(stock.id)
          .update(stock.toMap());

      log('Stock with ID ${stock.id} updated successfully.');
      return true;
    } catch (e) {
      log('Failed to update Stock: $e');
      return false;
    }
  }
}

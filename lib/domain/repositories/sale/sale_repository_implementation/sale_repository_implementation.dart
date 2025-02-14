import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../models/sale.dart';
import '../../../models/sale_item.dart';
import '../abstract_sale_repository/abstract_sale_repository.dart';

class SaleRepositoryImplementation implements SaleRepository {
  final FirebaseFirestore firestoreInstance;
  SaleRepositoryImplementation(this.firestoreInstance);
  @override
  Future<bool> addNewSale(Sale sale, bool isAluminium) async {
    try {
      await firestoreInstance
          .collection(isAluminium ? 'salesA' : 'salesC')
          .doc(sale.id)
          .set(sale.toMap());

      log('sale with ID $sale.id added successfully.');
      for (SaleItem saleItem in sale.saleItems) {
        updateRadiatorStockQuantity(saleItem.radiator!.id, saleItem.quantity);
      }

      return true;
    } catch (e) {
      log('Failed to add sale: $e');
      return false;
    }
  }

  Future<bool> updateRadiatorStockQuantity(
      String radiatorStockId, int newQuantity) async {
    try {
      // Retrieve all documents from the 'stocksA' collection
      QuerySnapshot snapshot =
          await firestoreInstance.collection('stocksA').get();

      // Iterate through each document
      for (var doc in snapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        final radiatorStockList = data['radiatorStock'] as List<dynamic>?;

        if (radiatorStockList != null) {
          // Check if any RadiatorStock object matches the provided radiatorStockId
          final updatedRadiatorStockList = radiatorStockList.map((item) {
            final radiatorStock = item as Map<String, dynamic>;
            if (radiatorStock['id'] == radiatorStockId) {
              // Update the quantity of the matching RadiatorStock object
              radiatorStock['quantity'] =
                  radiatorStock['quantity'] - newQuantity;
            }
            return radiatorStock;
          }).toList();

          // Update the document with the modified radiatorStock list
          await doc.reference.update({
            'radiatorStock': updatedRadiatorStockList,
          });

          log('Updated quantity for RadiatorStock with ID $radiatorStockId in document ${doc.id}');
        }
      }

      log('Successfully updated quantity for RadiatorStock with ID $radiatorStockId');
      return true;
    } catch (e) {
      log('Failed to update quantity for RadiatorStock with ID $radiatorStockId: $e');
      return false;
    }
  }

  @override
  Future<bool> deleteSale(String id, bool isAluminium) async {
    try {
      await firestoreInstance
          .collection(isAluminium ? 'salesA' : 'salesC')
          .doc(id)
          .delete();

      log('sale with ID $id deleted successfully.');
      return true;
    } catch (e) {
      log('Failed to delete sale: $e');
      return false;
    }
  }

  @override
  Future<List<Sale>> getAllSales(bool isAluminium) async {
    try {
      QuerySnapshot snapshot = await firestoreInstance
          .collection(isAluminium ? 'salesA' : 'salesC')
          .get();
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
  Future<bool> updateSale(Sale sale, bool isAluminium) async {
    try {
      await firestoreInstance
          .collection(isAluminium ? 'salesA' : 'salesC')
          .doc(sale.id)
          .update(sale.toMap());

      log('sale with ID ${sale.id} updated successfully.');
      return true;
    } catch (e) {
      log('Failed to update sale: $e');
      return false;
    }
  }

  @override
  Future<List<Sale>> getAllSalesByCustomerName(
      String customerName, bool isAluminium) async {
    try {
      // Retrieve all companies from Firestore
      QuerySnapshot snapshot = await firestoreInstance
          .collection(isAluminium ? 'salesA' : 'salesC')
          .get();

      // Filter companies on the client side (case-insensitive partial match)
      List<Sale> saleList = snapshot.docs
          .where((doc) {
            final data = doc.data() as Map<String, dynamic>;
            final name = data['customerName'] as String?;

            // Perform case-insensitive partial match
            return name?.toLowerCase().contains(customerName.toLowerCase()) ??
                false;
          })
          .map((doc) => Sale.fromMap(doc.data() as Map<String, dynamic>))
          .toList();

      // Debug: Print the filtered list
      log('Filtered sales for name $customerName: $saleList');
      return saleList;
    } catch (e) {
      log('Failed to retrieve sales for name $customerName: $e');
      return [];
    }
  }

  @override
  Future<List<Sale>> getAllSalesByStartEndDate(
      DateTime startDate, DateTime endDate, bool isAluminium) async {
    // Fetch all sales data (since Firestore doesn't support string date filtering)
    QuerySnapshot snapshot = await firestoreInstance
        .collection(isAluminium ? 'salesA' : 'salesC')
        .get();

    // Convert documents to Sale objects
    List<Sale> sales = snapshot.docs.map((doc) {
      return Sale.fromMap(doc.data() as Map<String, dynamic>);
    }).toList();

    // Filter sales by date range locally
    sales = sales.where((sale) {
      final saleDate = sale.date; // Sale date as DateTime
      return saleDate.isAfter(startDate.subtract(Duration(days: 1))) &&
          saleDate.isBefore(endDate.add(Duration(days: 1)));
    }).toList();

    return sales;
  }

  Future<List<Sale>> getSalesReport(DateTime? startDate, DateTime? endDate,
      String carId, String radiatorStockId, bool isAluminium) async {
    final firestoreInstance = FirebaseFirestore.instance;

    // Fetch all sales data (since Firestore doesn't support string date filtering)
    QuerySnapshot snapshot = await firestoreInstance
        .collection(isAluminium ? 'salesA' : 'salesC')
        .get();

    // Convert documents to Sale objects
    List<Sale> sales = snapshot.docs.map((doc) {
      return Sale.fromMap(doc.data() as Map<String, dynamic>);
    }).toList();
    if (startDate != null && endDate != null) {
      // Filter sales by date range locally
      sales = sales.where((sale) {
        final saleDate = sale.date; // Sale date as DateTime
        return saleDate.isAfter(startDate.subtract(Duration(days: 1))) &&
            saleDate.isBefore(endDate.add(Duration(days: 1)));
      }).toList();
    }
    // Further filter by car ID and radiator stock ID
    sales = sales.where((sale) {
      return sale.saleItems.any((item) =>
          item.car?.id == carId && item.radiator?.id == radiatorStockId);
    }).toList();

    return sales;
  }
}

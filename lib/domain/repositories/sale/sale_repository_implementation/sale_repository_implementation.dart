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

  @override
  Future<List<Sale>> getAllSalesByCustomerName(String customerName) async {
    try {
      // Retrieve all companies from Firestore
      QuerySnapshot snapshot =
          await firestoreInstance.collection('sales').get();

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
      DateTime startDate, DateTime endDate) async {
    // Fetch all sales data (since Firestore doesn't support string date filtering)
    QuerySnapshot snapshot = await firestoreInstance.collection('sales').get();

    // Convert documents to Sale objects
    List<Sale> sales = snapshot.docs.map((doc) {
      return Sale.fromMap(doc.data() as Map<String, dynamic>);
    }).toList();

    // Filter sales by date range locally
    sales = sales.where((sale) {
      final saleDate = sale.date; // Sale date as DateTime
      return saleDate.isAfter(startDate!.subtract(Duration(days: 1))) &&
          saleDate.isBefore(endDate!.add(Duration(days: 1)));
    }).toList();

    return sales;
  }
  Future<List<Sale>> getSalesReport(DateTime? startDate, DateTime? endDate,
      String carId, String radiatorStockId) async {
    final firestoreInstance = FirebaseFirestore.instance;

    // Fetch all sales data (since Firestore doesn't support string date filtering)
    QuerySnapshot snapshot = await firestoreInstance.collection('sales').get();

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

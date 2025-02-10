import '../../../models/sale.dart';

abstract class SaleRepository {
  Future<List<Sale>> getAllSales(bool isAluminium);
  Future<bool> addNewSale(Sale sale, bool isAluminium);
  Future<bool> updateSale(Sale sale, bool isAluminium);
  Future<bool> deleteSale(String id, bool isAluminium);
  Future<List<Sale>> getAllSalesByCustomerName(
      String customerName, bool isAluminium);
  Future<List<Sale>> getAllSalesByStartEndDate(
      DateTime startDate, DateTime endDate, bool isAluminium);
  Future<List<Sale>> getSalesReport(DateTime? startDate, DateTime? endDate,
      String carId, String radiatorStockId, bool isAluminium);
}

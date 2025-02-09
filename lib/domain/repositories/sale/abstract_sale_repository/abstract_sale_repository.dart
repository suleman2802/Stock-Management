import '../../../models/sale.dart';

abstract class SaleRepository {
  Future<List<Sale>> getAllSales();
  Future<bool> addNewSale(Sale sale);
  Future<bool> updateSale(Sale sale);
  Future<bool> deleteSale(String id);
  Future<List<Sale>> getAllSalesByCustomerName(String customerName);
  Future<List<Sale>> getAllSalesByStartEndDate(
      DateTime startDate, DateTime endDate);
  Future<List<Sale>> getSalesReport(DateTime? startDate, DateTime? endDate,
      String carId, String radiatorStockId);
}

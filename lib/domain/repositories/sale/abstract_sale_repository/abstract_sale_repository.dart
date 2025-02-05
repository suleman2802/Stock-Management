import '../../../models/sale.dart';

abstract class SaleRepository {
  Future<List<Sale>> getAllSales();
  Future<bool> addNewSale(Sale sale);
  Future<bool> updateSale(Sale sale);
  Future<bool> deleteSale(String id);
}

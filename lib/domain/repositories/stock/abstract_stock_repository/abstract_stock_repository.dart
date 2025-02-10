import '../../../models/stock.dart';

abstract class StockRepository {
  Future<List<Stock>> getAllStocks(bool isAluminium);
  Future<bool> addNewStock(Stock stock, bool isAluminium);
  Future<bool> updateStock(Stock stock, bool isAluminium);
  Future<bool> deleteStock(String id, bool isAluminium);
  Future<List<Stock>> getAllStocksByCarId(String carId, bool isAluminium);
  Future<List<Stock>> getAllStocksByCarName(String carName, bool isAluminium);
}

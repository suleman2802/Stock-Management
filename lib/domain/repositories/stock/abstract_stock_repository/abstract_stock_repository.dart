import '../../../models/stock.dart';

abstract class StockRepository {
  Future<List<Stock>> getAllStocks();
  Future<bool> addNewStock(Stock stock);
  Future<bool> updateStock(Stock stock);
  Future<bool> deleteStock(String id);
  Future<List<Stock>> getAllStocksByCarId(String carId);
  Future<List<Stock>> getAllStocksByCarName(String carName);
  
}

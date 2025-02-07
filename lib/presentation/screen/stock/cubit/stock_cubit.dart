import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/models/stock.dart';
import '../../../../domain/repositories/stock/abstract_stock_repository/abstract_stock_repository.dart';

part 'stock_state.dart';

class StockCubit extends Cubit<StockState> {
  final StockRepository stockRepository;
  StockCubit({required this.stockRepository}) : super(StockInitialState());

  Future<void> fetchAllStocks() async {
    try {
      emit(StockLoadingState());
      final List<Stock> stockList = await stockRepository.getAllStocks();
      emit(
        StockLoadedState(
          stockList: stockList,
        ),
      );
    } catch (error) {
      emit(StockErrorState(errorMessage: error.toString()));
    }
  }

  Future<bool> addNewStock(Stock stock) async {
    try {
      final bool isAddedSuccessfully = await stockRepository.addNewStock(stock);
      await fetchAllStocks();
      return isAddedSuccessfully;
    } catch (error) {
      log("Unable to add Stock $error");
      await fetchAllStocks();
      return false;
    }
  }

  Future<bool> updateStock(Stock stock) async {
    try {
      final bool isUpdatedSuccessfully =
          await stockRepository.updateStock(stock);
      await fetchAllStocks();
      return isUpdatedSuccessfully;
    } catch (error) {
      log("Unable to upadate Stock  $error");
      await fetchAllStocks();
      return false;
    }
  }

  Future<bool> deleteStock(String id) async {
    try {
      final bool isDeletedSuccessfully = await stockRepository.deleteStock(id);
      await fetchAllStocks();
      return isDeletedSuccessfully;
    } catch (error) {
      log("Unable to delete Stock $error");
      await fetchAllStocks();
      return false;
    }
  }

    Future<void> fetchAllStocksByCarId(String carId) async {
    try {
      emit(StockLoadingState());
      final List<Stock> stockList =
          await stockRepository.getAllStocksByCarId(carId);
      emit(
        StockLoadedState(
          stockList: stockList,
        ),
      );
    } catch (error) {
      emit(StockErrorState(errorMessage: error.toString()));
    }
  }
}

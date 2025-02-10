import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/models/stock.dart';
import '../../../../domain/repositories/stock/abstract_stock_repository/abstract_stock_repository.dart';

part 'stock_state.dart';

class StockCubit extends Cubit<StockState> {
  final StockRepository stockRepository;
  StockCubit({required this.stockRepository}) : super(StockInitialState());

  Future<void> fetchAllStocks(bool isAluminium) async {
    try {
      emit(StockLoadingState());
      final List<Stock> stockList =
          await stockRepository.getAllStocks(isAluminium);
      emit(
        StockLoadedState(
          stockList: stockList,
        ),
      );
    } catch (error) {
      emit(StockErrorState(errorMessage: error.toString()));
    }
  }

  Future<bool> addNewStock(Stock stock, bool isAluminium) async {
    try {
      final bool isAddedSuccessfully =
          await stockRepository.addNewStock(stock, isAluminium);
      await fetchAllStocks(isAluminium);
      return isAddedSuccessfully;
    } catch (error) {
      log("Unable to add Stock $error");
      await fetchAllStocks(isAluminium);
      return false;
    }
  }

  Future<bool> updateStock(Stock stock, bool isAluminium) async {
    try {
      final bool isUpdatedSuccessfully =
          await stockRepository.updateStock(stock, isAluminium);
      await fetchAllStocks(isAluminium);
      return isUpdatedSuccessfully;
    } catch (error) {
      log("Unable to upadate Stock  $error");
      await fetchAllStocks(isAluminium);
      return false;
    }
  }

  Future<bool> deleteStock(String id, bool isAluminium) async {
    try {
      final bool isDeletedSuccessfully =
          await stockRepository.deleteStock(id, isAluminium);
      await fetchAllStocks(isAluminium);
      return isDeletedSuccessfully;
    } catch (error) {
      log("Unable to delete Stock $error");
      await fetchAllStocks(isAluminium);
      return false;
    }
  }

  Future<void> fetchAllStocksByCarId(String carId, bool isAluminium) async {
    try {
      emit(StockLoadingState());
      final List<Stock> stockList =
          await stockRepository.getAllStocksByCarId(carId, isAluminium);
      emit(
        StockLoadedState(
          stockList: stockList,
        ),
      );
    } catch (error) {
      emit(StockErrorState(errorMessage: error.toString()));
    }
  }

  Future<void> fetchAllStocksByCarName(String carName, bool isAluminium) async {
    try {
      emit(StockLoadingState());
      final List<Stock> stockList =
          await stockRepository.getAllStocksByCarName(carName, isAluminium);
      emit(
        StockLoadedState(
          stockList: stockList,
        ),
      );
    } catch (error) {
      emit(StockErrorState(errorMessage: error.toString()));
    }
    //  try {
    //   // Get the current state
    //   if (state is StockLoadedState) {
    //     final currentState = state as StockLoadedState;

    //     // Filter the stock list based on carName (case-insensitive)
    //     final List<Stock> filteredStocks = currentState.stockList.where((stock) {
    //       return stock.car.carName.toLowerCase().contains(carName.toLowerCase());
    //     }).toList();

    //     // Emit a new state with the filtered list
    //     emit(
    //       StockLoadedState(
    //         stockList: filteredStocks,
    //       ),
    //     );
    //   } else {
    //     log("Cannot filter stocks: Current state is not StockLoadedState");
    //   }
    // } catch (error) {
    //   emit(StockErrorState(errorMessage: error.toString()));
    // }
  }
}

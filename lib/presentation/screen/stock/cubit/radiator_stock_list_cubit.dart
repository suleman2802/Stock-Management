import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_management_application/domain/models/radiator_stock.dart';

class RadiatorStockCubit extends Cubit<List<RadiatorStock>> {
  RadiatorStockCubit({List<RadiatorStock>? initialStocks})
      : super(initialStocks ?? []);

  void addStock(RadiatorStock stock) => emit([...state, stock]);

  void intilizeStockList(List<RadiatorStock> stockList) => emit(stockList);

  void updateStock(int index, RadiatorStock updatedStock) {
    final newList = List<RadiatorStock>.from(state);
    newList[index] = updatedStock;
    emit(newList);
  }

  void removeStock(int index) {
    final newList = List<RadiatorStock>.from(state)..removeAt(index);
    emit(newList);
  }

  List<RadiatorStock> getAllListRecord() {
    return state;
  }

  bool valiadatRadiatorStockList() {
    for (RadiatorStock singleRadiatorStockItem in state) {
      if (singleRadiatorStockItem.company == null) {
        return false;
      } else if (singleRadiatorStockItem.radiator == null) {
        return false;
      }
    }
    return true;
  }

  calculateProfitMargins(int index) {
    final List<RadiatorStock> newList = List<RadiatorStock>.from(state);
    RadiatorStock stockItem = state[index];
    double unitCost = stockItem.unitCost;
    double retailProfit = stockItem.profitInRetailPrice;
    double retailPrice = stockItem.retailPrice;
    double retailProfitMargin = stockItem.retailProfitMargin;

    unitCost = retailPrice - retailProfit;
    retailPrice = unitCost + retailProfit;
    retailProfit = retailPrice - unitCost;
    retailProfitMargin = (retailProfit / unitCost) * 100;

    log("unit cost $unitCost");
    log("retailPrice $retailPrice");
    log("retailProfitMargin $retailProfitMargin");
    log("retailProfit : $retailProfit");

    newList[index] = stockItem.copyWith(
      profitInRetailPrice: retailProfit,
      unitCost: unitCost,
      retailPrice: retailPrice,
      retailProfitMargin: retailProfitMargin,
    );
    
    emit(newList);
  }
}

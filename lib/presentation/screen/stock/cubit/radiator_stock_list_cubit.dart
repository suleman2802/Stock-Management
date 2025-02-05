import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/models/radiator_stock.dart';

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
}

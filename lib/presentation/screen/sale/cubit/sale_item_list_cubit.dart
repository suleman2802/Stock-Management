import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/models/sale_item.dart';

class SaleItemListCubit extends Cubit<List<SaleItem>> {
  SaleItemListCubit({List<SaleItem>? initialsaleItems})
      : super(initialsaleItems ?? []);

  void addSaleItem(SaleItem saleItem) => emit([...state, saleItem]);

  void intilizeSaleItemList(List<SaleItem> saleItemList) => emit(saleItemList);

  void updatesaleItem(int index, SaleItem updatedSaleItem) {
    final newList = List<SaleItem>.from(state);
    newList[index] = updatedSaleItem;
    emit(newList);
  }

  void removeSaleItem(int index) {
    final newList = List<SaleItem>.from(state)..removeAt(index);
    emit(newList);
  }

  List<SaleItem> getAllListRecord() {
    return state;
  }

  bool valiadatSaleItemList() {
    for (SaleItem singleSaleItem in state) {
      if (singleSaleItem.radiator == null) {
        return false;
      }
      if (singleSaleItem.car == null) {
        return false;
      }
    }
    return true;
  }
}

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/models/sale.dart';
import '../../../../domain/repositories/sale/abstract_sale_repository/abstract_sale_repository.dart';

part 'sale_state.dart';

class SaleCubit extends Cubit<SaleState> {
  final SaleRepository saleRepository;
  SaleCubit({required this.saleRepository}) : super(SaleInitial()) {
    fetchAllSales();
  }

  Future<void> fetchAllSales() async {
    try {
      emit(SaleLoadingState());
      final List<Sale> saleList = await saleRepository.getAllSales();
      emit(
        SaleLoadedState(
          saleList: saleList,
        ),
      );
    } catch (error) {
      emit(SaleErrorState(errorMessage: error.toString()));
    }
  }

  Future<bool> addNewsale(Sale sale) async {
    try {
      final bool isAddedSuccessfully = await saleRepository.addNewSale(sale);
      await fetchAllSales();
      return isAddedSuccessfully;
    } catch (error) {
      log("Unable to add sale $error");
      await fetchAllSales();
      return false;
    }
  }

  Future<bool> updatesale(Sale sale) async {
    try {
      final bool isUpdatedSuccessfully = await saleRepository.updateSale(sale);
      await fetchAllSales();
      return isUpdatedSuccessfully;
    } catch (error) {
      log("Unable to upadate sale  $error");
      await fetchAllSales();
      return false;
    }
  }

  Future<bool> deleteSale(String id) async {
    try {
      final bool isDeletedSuccessfully = await saleRepository.deleteSale(id);
      await fetchAllSales();
      return isDeletedSuccessfully;
    } catch (error) {
      log("Unable to delete sale $error");
      await fetchAllSales();
      return false;
    }
  }
}

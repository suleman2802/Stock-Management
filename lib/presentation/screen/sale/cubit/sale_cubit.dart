import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/models/sale.dart';
import '../../../../domain/repositories/sale/abstract_sale_repository/abstract_sale_repository.dart';

part 'sale_state.dart';

class SaleCubit extends Cubit<SaleState> {
  final SaleRepository saleRepository;
  SaleCubit({required this.saleRepository}) : super(SaleInitial()) {
    fetchAllSales(true);
  }

  Future<void> getAllSalesByStartEndDate(
      DateTime startDate, DateTime endDate, bool isAluminium) async {
    try {
      emit(SaleLoadingState());
      final List<Sale> saleList =
          await saleRepository.getAllSalesByStartEndDate(startDate, endDate,isAluminium);
      emit(
        SaleLoadedState(
          saleList: saleList,
        ),
      );
    } catch (error) {
      emit(SaleErrorState(errorMessage: error.toString()));
    }
  }

  Future<void> fetchAllSalesByCustomerName(String customerName, bool isAluminium) async {
    try {
      emit(SaleLoadingState());
      final List<Sale> saleList =
          await saleRepository.getAllSalesByCustomerName(customerName,isAluminium);
      emit(
        SaleLoadedState(
          saleList: saleList,
        ),
      );
    } catch (error) {
      emit(SaleErrorState(errorMessage: error.toString()));
    }
  }

  Future<void> fetchAllSales(bool isAluminium) async {
    try {
      emit(SaleLoadingState());
      final List<Sale> saleList = await saleRepository.getAllSales(isAluminium);
      emit(
        SaleLoadedState(
          saleList: saleList,
        ),
      );
    } catch (error) {
      emit(SaleErrorState(errorMessage: error.toString()));
    }
  }

  Future<bool> addNewsale(Sale sale, bool isAluminium) async {
    try {
      final bool isAddedSuccessfully = await saleRepository.addNewSale(sale,isAluminium);
      await fetchAllSales(isAluminium);
      return isAddedSuccessfully;
    } catch (error) {
      log("Unable to add sale $error");
      await fetchAllSales(isAluminium);
      return false;
    }
  }

  Future<bool> updatesale(Sale sale, bool isAluminium) async {
    try {
      final bool isUpdatedSuccessfully = await saleRepository.updateSale(sale,isAluminium);
      await fetchAllSales(isAluminium);
      return isUpdatedSuccessfully;
    } catch (error) {
      log("Unable to upadate sale  $error");
      await fetchAllSales(isAluminium);
      return false;
    }
  }

  Future<bool> deleteSale(String id, bool isAluminium) async {
    try {
      final bool isDeletedSuccessfully = await saleRepository.deleteSale(id,isAluminium);
      await fetchAllSales(isAluminium);
      return isDeletedSuccessfully;
    } catch (error) {
      log("Unable to delete sale $error");
      await fetchAllSales(isAluminium);
      return false;
    }
  }
}

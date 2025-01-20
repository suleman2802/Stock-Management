import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/models/fin.dart';
import '../../../../domain/repositories/fin/abstract_fin_repository/abstract_fin_repository.dart';

part 'fin_state.dart';

class FinCubit extends Cubit<FinState> {
  final FinRepository finRepository;
  FinCubit({required this.finRepository}) : super(FinInitialState()) {
    fetchAllFinSizes();
  }

  Future<void> fetchAllFinSizes() async {
    try {
      emit(FinLoadingState());
      final List<Fin> finSizesList = await finRepository.getAllFinSizes();
      emit(FinLoadedState(finList: finSizesList));
    } catch (error) {
      emit(FinErrorState(errorMessage: error.toString()));
    }
  }

  Future<bool> addNewFinSize(Fin fin) async {
    try {
      final bool isAddedSuccessfully = await finRepository.addNewFinSize(fin);
      fetchAllFinSizes();
      return isAddedSuccessfully;
    } catch (error) {
      log("Unable to add Fin Size $error");
      return false;
    }
  }

  Future<bool> uppdateFinSize(Fin fin) async {
    try {
      final bool isUpdatedSuccessfully = await finRepository.updateFinSize(fin);
      fetchAllFinSizes();
      return isUpdatedSuccessfully;
    } catch (error) {
      log("Unable to upadate Fin Size $error");
      return false;
    }
  }

  Future<bool> deleteFinSize(String id) async {
    try {
      final bool isDeletedSuccessfully = await finRepository.deleteFinSize(id);
      fetchAllFinSizes();
      return isDeletedSuccessfully;
    } catch (error) {
      log("Unable to delete Fin Size $error");
      return false;
    }
  }
}

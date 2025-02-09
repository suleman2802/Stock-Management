import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/models/fin.dart';
import '../../../../domain/repositories/fin/abstract_fin_repository/abstract_fin_repository.dart';

part 'fin_state.dart';

class FinCubit extends Cubit<FinState> {
  final FinRepository finRepository;
  FinCubit({required this.finRepository}) : super(FinInitialState()) {
    fetchAllFinSizes(true);
  }

  Future<void> fetchAllFinSizes(bool isAluminium) async {
    log("inside get");
    try {
      emit(FinLoadingState());
      final List<Fin> finSizesList =
          await finRepository.getAllFinSizes(isAluminium);
      emit(
        FinLoadedState(
          finList: finSizesList,
        ),
      );
    } catch (error) {
      emit(FinErrorState(errorMessage: error.toString()));
    }
  }

  Future<bool> addNewFinSize(Fin fin, bool isAluminium) async {
    try {
      final bool isAddedSuccessfully =
          await finRepository.addNewFinSize(fin, isAluminium);
      await fetchAllFinSizes(isAluminium);
      return isAddedSuccessfully;
    } catch (error) {
      log("Unable to add Fin Size $error");
      await fetchAllFinSizes(isAluminium);
      return false;
    }
  }

  Future<bool> updateFinSize(Fin fin, bool isAluminium) async {
    try {
      final bool isUpdatedSuccessfully =
          await finRepository.updateFinSize(fin, isAluminium);
      await fetchAllFinSizes(isAluminium);
      return isUpdatedSuccessfully;
    } catch (error) {
      log("Unable to upadate Fin Size $error");
      await fetchAllFinSizes(isAluminium);
      return false;
    }
  }

  Future<bool> deleteFinSize(String id, bool isAluminium) async {
    try {
      final bool isDeletedSuccessfully =
          await finRepository.deleteFinSize(id, isAluminium);
      await fetchAllFinSizes(isAluminium);
      return isDeletedSuccessfully;
    } catch (error) {
      log("Unable to delete Fin Size $error");
      await fetchAllFinSizes(isAluminium);
      return false;
    }
  }
}

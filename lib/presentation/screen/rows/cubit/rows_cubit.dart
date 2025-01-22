import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/models/rows.dart';
import '../../../../domain/repositories/rows/abstract_rows_repository/abstract_rows_repository.dart';

part 'rows_state.dart';

class RowsCubit extends Cubit<RowsState> {
  final RowsRepository rowsRepository;
  RowsCubit({required this.rowsRepository}) : super(RowsInitialState()) {
    fetchAllRows();
  }

  Future<void> fetchAllRows() async {
    log("inside get");
    try {
      emit(RowsLoadingState());
      final List<Rows> rowsList = await rowsRepository.getAllRows();
      emit(
        RowsLoadedState(
          rowsList: rowsList,
        ),
      );
    } catch (error) {
      emit(RowsErrorState(errorMessage: error.toString()));
    }
  }

  Future<bool> addNewRows(Rows rows) async {
    try {
      final bool isAddedSuccessfully = await rowsRepository.addNewRow(rows);
      await fetchAllRows();
      return isAddedSuccessfully;
    } catch (error) {
      log("Unable to add Rows $error");
      await fetchAllRows();
      return false;
    }
  }

  Future<bool> updateRows(Rows rows) async {
    try {
      final bool isUpdatedSuccessfully = await rowsRepository.updateRow(rows);
      await fetchAllRows();
      return isUpdatedSuccessfully;
    } catch (error) {
      log("Unable to upadate Rows $error");
      await fetchAllRows();
      return false;
    }
  }

  Future<bool> deleteRows(String id) async {
    try {
      final bool isDeletedSuccessfully = await rowsRepository.deleteRow(id);
      await fetchAllRows();
      return isDeletedSuccessfully;
    } catch (error) {
      log("Unable to delete Rows $error");
      await fetchAllRows();
      return false;
    }
  }
}

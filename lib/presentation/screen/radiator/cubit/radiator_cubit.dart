import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/models/radiator.dart';
import '../../../../domain/repositories/radiator/abstract_radiator_repository/abstract_radiator_repository.dart';

part 'radiator_state.dart';

class RadiatorCubit extends Cubit<RadiatorState> {
  final RadiatorRepository radiatorRepository;

  RadiatorCubit({required this.radiatorRepository})
      : super(RadiatorInitialState());

  Future<void> fetchAllRadiators(bool isAluminium) async {
    try {
      emit(RadiatorLoadingState());
      final List<Radiator> radiatorList =
          await radiatorRepository.getAllRadiators(isAluminium);
      emit(
        RadiatorLoadedState(
          radiatorList: radiatorList,
        ),
      );
    } catch (error) {
      emit(RadiatorErrorState(errorMessage: error.toString()));
    }
  }

  Future<void> fetchAllRadiatorsByCarId(String carId,bool isAluminium) async {
    try {
      emit(RadiatorLoadingState());
      final List<Radiator> radiatorList =
          await radiatorRepository.getAllRadiatorsByCarId(carId, isAluminium);
      emit(
        RadiatorLoadedState(
          radiatorList: radiatorList,
        ),
      );
    } catch (error) {
      emit(RadiatorErrorState(errorMessage: error.toString()));
    }
  }

  Future<bool> addNewRadiator(Radiator radiator,bool isAluminium) async {
    try {
      final bool isAddedSuccessfully =
          await radiatorRepository.addNewRadiator(radiator, isAluminium);
      await fetchAllRadiators(isAluminium);
      return isAddedSuccessfully;
    } catch (error) {
      log("Unable to add Radiator $error");
      await fetchAllRadiators(isAluminium);
      return false;
    }
  }

  Future<bool> updateRadiator(Radiator radiator,bool isAluminium) async {
    try {
      final bool isUpdatedSuccessfully =
          await radiatorRepository.updateRadiator(radiator,isAluminium);
      await fetchAllRadiators(isAluminium);
      return isUpdatedSuccessfully;
    } catch (error) {
      log("Unable to upadate Radiator  $error");
      await fetchAllRadiators(isAluminium);
      return false;
    }
  }

  Future<bool> deleteRadiator(String id,bool isAluminium) async {
    try {
      final bool isDeletedSuccessfully =
          await radiatorRepository.deleteRadiator(id, isAluminium);
      await fetchAllRadiators(isAluminium);
      return isDeletedSuccessfully;
    } catch (error) {
      log("Unable to delete Radiator $error");
      await fetchAllRadiators(isAluminium);
      return false;
    }
  }

  Future<void> fetchAllRadiatorsBySize(String size,bool isAluminium)async{
    try {
      emit(RadiatorLoadingState());
      final List<Radiator> radiatorList =
          await radiatorRepository.getAllRadiatorsBySize(size,isAluminium);
      emit(
        RadiatorLoadedState(
          radiatorList: radiatorList,
        ),
      );
    } catch (error) {
      emit(RadiatorErrorState(errorMessage: error.toString()));
    }
  }
}

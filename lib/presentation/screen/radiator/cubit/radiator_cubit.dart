import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/models/radiator.dart';
import '../../../../domain/repositories/radiator/abstract_radiator_repository/abstract_radiator_repository.dart';

part 'radiator_state.dart';

class RadiatorCubit extends Cubit<RadiatorState> {
  final RadiatorRepository radiatorRepository;

  RadiatorCubit({required this.radiatorRepository})
      : super(RadiatorInitialState()) {
 fetchAllRadiators();
  }

  Future<void> fetchAllRadiators() async {
    try {
      emit(RadiatorLoadingState());
      final List<Radiator> radiatorList =
          await radiatorRepository.getAllRadiators();
      emit(
        RadiatorLoadedState(
          radiatorList: radiatorList,
        ),
      );
    } catch (error) {
      emit(RadiatorErrorState(errorMessage: error.toString()));
    }
  }

  Future<void> fetchAllRadiatorsByCarId(String carId) async {
    try {
      emit(RadiatorLoadingState());
      final List<Radiator> radiatorList =
          await radiatorRepository.getAllRadiatorsByCarId(carId);
      emit(
        RadiatorLoadedState(
          radiatorList: radiatorList,
        ),
      );
    } catch (error) {
      emit(RadiatorErrorState(errorMessage: error.toString()));
    }
  }

  Future<bool> addNewRadiator(Radiator radiator) async {
    try {
      final bool isAddedSuccessfully =
          await radiatorRepository.addNewRadiator(radiator);
      await fetchAllRadiators();
      return isAddedSuccessfully;
    } catch (error) {
      log("Unable to add Radiator $error");
      await fetchAllRadiators();
      return false;
    }
  }

  Future<bool> updateRadiator(Radiator radiator) async {
    try {
      final bool isUpdatedSuccessfully =
          await radiatorRepository.updateRadiator(radiator);
      await fetchAllRadiators();
      return isUpdatedSuccessfully;
    } catch (error) {
      log("Unable to upadate Radiator  $error");
      await fetchAllRadiators();
      return false;
    }
  }

  Future<bool> deleteRadiator(String id) async {
    try {
      final bool isDeletedSuccessfully =
          await radiatorRepository.deleteRadiator(id);
      await fetchAllRadiators();
      return isDeletedSuccessfully;
    } catch (error) {
      log("Unable to delete Radiator $error");
      await fetchAllRadiators();
      return false;
    }
  }
}

part of 'car_cubit.dart';

sealed class CarState extends Equatable {
  const CarState();

  @override
  List<Object> get props => [];
}

final class CarInitialState extends CarState {}

final class CarLoadingState extends CarState {}

final class CarLoadedState extends CarState {
  final List<Car> carList;
  const CarLoadedState({required this.carList});
  @override
  List<Object> get props => [carList];
}

final class CarErrorState extends CarState {
  final String errorMessage;
  const CarErrorState({required this.errorMessage});
}

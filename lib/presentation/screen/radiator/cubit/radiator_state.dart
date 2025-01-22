part of 'radiator_cubit.dart';

sealed class RadiatorState extends Equatable {
  const RadiatorState();

  @override
  List<Object> get props => [];
}

final class RadiatorInitialState extends RadiatorState {}

final class RadiatorLoadingState extends RadiatorState {}

final class RadiatorLoadedState extends RadiatorState {
  final List<Radiator> radiatorList;
  const RadiatorLoadedState({required this.radiatorList});
  @override
  List<Object> get props => [radiatorList];
}

final class RadiatorErrorState extends RadiatorState {
  final String errorMessage;
  const RadiatorErrorState({required this.errorMessage});
}

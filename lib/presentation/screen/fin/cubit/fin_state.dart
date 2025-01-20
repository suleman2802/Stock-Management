part of 'fin_cubit.dart';

sealed class FinState extends Equatable {
  const FinState();

  @override
  List<Object> get props => [];
}

final class FinInitialState extends FinState {}

final class FinLoadingState extends FinState {}

final class FinLoadedState extends FinState {
  final List<Fin> finList;
  const FinLoadedState({required this.finList});
  @override
  List<Object> get props => [finList];
}

final class FinErrorState extends FinState {
  final String errorMessage;
  const FinErrorState({required this.errorMessage});
}

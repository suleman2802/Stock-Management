part of 'sale_cubit.dart';

sealed class SaleState extends Equatable {
  const SaleState();

  @override
  List<Object> get props => [];
}

final class SaleInitial extends SaleState {}

final class SaleInitialState extends SaleState {}

final class SaleLoadingState extends SaleState {}

final class SaleLoadedState extends SaleState {
  final List<Sale> saleList;
  const SaleLoadedState({required this.saleList});
  @override
  List<Object> get props => [saleList];
}

final class SaleErrorState extends SaleState {
  final String errorMessage;
  const SaleErrorState({required this.errorMessage});
}

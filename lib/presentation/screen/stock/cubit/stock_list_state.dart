part of 'stock_list_cubit.dart';


sealed class StockListState extends Equatable {
  const StockListState();

  @override
  List<Object> get props => [];
}

final class StockListInitialState extends StockListState {}

final class StockListLoadingState extends StockListState {}

final class StockListLoadedState extends StockListState {
  final List<RadiatorStock> radiatorStockList;
  const StockListLoadedState({required this.radiatorStockList});
  @override
  List<Object> get props => [radiatorStockList];
}

final class StockListErrorState extends StockListState {
  final String errorMessage;
  const StockListErrorState({required this.errorMessage});
}
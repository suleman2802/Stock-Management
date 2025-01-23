part of 'stock_cubit.dart';

sealed class StockState extends Equatable {
  const StockState();

  @override
  List<Object> get props => [];
}

final class StockInitialState extends StockState {}

final class StockLoadingState extends StockState {}

final class StockLoadedState extends StockState {
  final List<Stock> stockList;
  const StockLoadedState({required this.stockList});
  @override
  List<Object> get props => [stockList];
}

final class StockErrorState extends StockState {
  final String errorMessage;
  const StockErrorState({required this.errorMessage});
}

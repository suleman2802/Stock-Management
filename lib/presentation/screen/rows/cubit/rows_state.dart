part of 'rows_cubit.dart';

sealed class RowsState extends Equatable {
  const RowsState();

  @override
  List<Object> get props => [];
}

final class RowsInitialState extends RowsState {}

final class RowsLoadingState extends RowsState {}

final class RowsLoadedState extends RowsState {
  final List<Rows> rowsList;
  const RowsLoadedState({required this.rowsList});
  @override
  List<Object> get props => [rowsList];
}

final class RowsErrorState extends RowsState {
  final String errorMessage;
  const RowsErrorState({required this.errorMessage});
}

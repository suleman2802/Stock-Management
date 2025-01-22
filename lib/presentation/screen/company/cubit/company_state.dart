part of 'company_cubit.dart';

sealed class CompanyState extends Equatable {
  const CompanyState();

  @override
  List<Object> get props => [];
}

final class CompanyInitialState extends CompanyState {}

final class CompanyLoadingState extends CompanyState {}

final class CompanyLoadedState extends CompanyState {
  final List<Company> companyList;
  const CompanyLoadedState({required this.companyList});
  @override
  List<Object> get props => [companyList];
}

final class CompanyErrorState extends CompanyState {
  final String errorMessage;
  const CompanyErrorState({required this.errorMessage});
}

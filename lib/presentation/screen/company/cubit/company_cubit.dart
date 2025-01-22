import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stock_management_application/domain/repositories/company/abstract_company_repository/abstract_company_repository.dart';

import '../../../../domain/models/company.dart';

part 'company_state.dart';

class CompanyCubit extends Cubit<CompanyState> {
  final CompanyRepository companyRepository;
  CompanyCubit({required this.companyRepository})
      : super(CompanyInitialState()) {
    fetchAllCompany();
  }

  Future<void> fetchAllCompany() async {
    log("inside get");
    try {
      emit(CompanyLoadingState());
      final List<Company> companyList =
          await companyRepository.getAllCompanies();
      emit(
        CompanyLoadedState(
          companyList: companyList,
        ),
      );
    } catch (error) {
      emit(CompanyErrorState(errorMessage: error.toString()));
    }
  }

  Future<bool> addNewCompany(Company company) async {
    try {
      final bool isAddedSuccessfully =
          await companyRepository.addNewCompany(company);
      await fetchAllCompany();
      return isAddedSuccessfully;
    } catch (error) {
      log("Unable to add Company $error");
      await fetchAllCompany();
      return false;
    }
  }

  Future<bool> updateCompany(Company company) async {
    try {
      final bool isUpdatedSuccessfully =
          await companyRepository.updateCompany(company);
      await fetchAllCompany();
      return isUpdatedSuccessfully;
    } catch (error) {
      log("Unable to upadate Company $error");
      await fetchAllCompany();
      return false;
    }
  }

  Future<bool> deleteCompany(String id) async {
    try {
      final bool isDeletedSuccessfully =
          await companyRepository.deleteCompany(id);
      await fetchAllCompany();
      return isDeletedSuccessfully;
    } catch (error) {
      log("Unable to delete Company $error");
      await fetchAllCompany();
      return false;
    }
  }
}

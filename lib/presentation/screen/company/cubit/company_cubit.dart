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
    fetchAllCompany(true);
  }

  Future<void> fetchAllCompany(bool isAluminium) async {
    log("inside get");
    try {
      emit(CompanyLoadingState());
      final List<Company> companyList =
          await companyRepository.getAllCompanies(isAluminium);
      emit(
        CompanyLoadedState(
          companyList: companyList,
        ),
      );
    } catch (error) {
      emit(CompanyErrorState(errorMessage: error.toString()));
    }
  }

  Future<bool> addNewCompany(Company company, bool isAluminium) async {
    try {
      final bool isAddedSuccessfully =
          await companyRepository.addNewCompany(company, isAluminium);
      await fetchAllCompany(isAluminium);
      return isAddedSuccessfully;
    } catch (error) {
      log("Unable to add Company $error");
      await fetchAllCompany(isAluminium);
      return false;
    }
  }

  Future<bool> updateCompany(Company company, bool isAluminium) async {
    try {
      final bool isUpdatedSuccessfully =
          await companyRepository.updateCompany(company, isAluminium);
      await fetchAllCompany(isAluminium);
      return isUpdatedSuccessfully;
    } catch (error) {
      log("Unable to upadate Company $error");
      await fetchAllCompany(isAluminium);
      return false;
    }
  }

  Future<bool> deleteCompany(String id, bool isAluminium) async {
    try {
      final bool isDeletedSuccessfully =
          await companyRepository.deleteCompany(id, isAluminium);
      await fetchAllCompany(isAluminium);
      return isDeletedSuccessfully;
    } catch (error) {
      log("Unable to delete Company $error");
      await fetchAllCompany(isAluminium);
      return false;
    }
  }

  Future<void> fetchAllCompaniesByName(String name, bool isAluminium) async {
    try {
      emit(CompanyLoadingState());
      final List<Company> companyList =
          await companyRepository.getAllCompaniesByName(name, isAluminium);
      emit(
        CompanyLoadedState(
          companyList: companyList,
        ),
      );
    } catch (error) {
      emit(CompanyErrorState(errorMessage: error.toString()));
    }
  }
}

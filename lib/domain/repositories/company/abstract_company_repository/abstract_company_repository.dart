import '../../../models/company.dart';

abstract class CompanyRepository {
  Future<List<Company>> getAllCompanies();
  Future<bool> addNewCompany(Company company);
  Future<bool> updateCompany(Company company);
  Future<bool> deleteCompany(String id);
  Future<List<Company>> getAllCompaniesByName(String name);
}

import '../../../models/company.dart';

abstract class CompanyRepository {
  Future<List<Company>> getAllCompanies(bool isAluminium);
  Future<bool> addNewCompany(Company company, bool isAluminium);
  Future<bool> updateCompany(Company company, bool isAluminium);
  Future<bool> deleteCompany(String id, bool isAluminium);
  Future<List<Company>> getAllCompaniesByName(
      String companyName, bool isAluminium);
}

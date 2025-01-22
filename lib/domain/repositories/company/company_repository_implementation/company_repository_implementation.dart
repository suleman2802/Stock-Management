import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../models/company.dart';
import '../abstract_company_repository/abstract_company_repository.dart';

class CompanyRepositoryImplementation implements CompanyRepository {
  FirebaseFirestore firestoreInstance;
  CompanyRepositoryImplementation(this.firestoreInstance);
  @override
  Future<bool> addNewCompany(Company company) async {
    try {
      await firestoreInstance
          .collection('companies')
          .doc(company.id)
          .set(company.toMap());

      log('company with ID $company.id added successfully.');
      return true;
    } catch (e) {
      log('Failed to add company: $e');
      return false;
    }
  }

  @override
  Future<bool> deleteCompany(String id) async {
    try {
      await firestoreInstance.collection('companies').doc(id).delete();

      log('company with ID $id deleted successfully.');
      return true;
    } catch (e) {
      log('Failed to delete company: $e');
      return false;
    }
  }

  @override
  Future<List<Company>> getAllCompanies() async {
    try {
      QuerySnapshot snapshot =
          await firestoreInstance.collection('companies').get();

      List<Company> companyList = snapshot.docs.map((doc) {
        return Company.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();

      log('Retrieved company: $companyList');
      return companyList;
    } catch (e) {
      log('Failed to retrieve company: $e');
      return [];
    }
  }

  @override
  Future<bool> updateCompany(Company company) async {
    try {
      await firestoreInstance
          .collection('companies')
          .doc(company.id)
          .update(company.toMap());

      log('company with ID ${company.id} updated successfully.');
      return true;
    } catch (e) {
      log('Failed to update company: $e');
      return false;
    }
  }
}

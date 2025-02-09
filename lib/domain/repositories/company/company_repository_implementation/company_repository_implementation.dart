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

  @override
  Future<List<Company>> getAllCompaniesByName(String companyName) async {
    try {
      // Retrieve all companies from Firestore
      QuerySnapshot snapshot =
          await firestoreInstance.collection('companies').get();

      // Filter companies on the client side (case-insensitive partial match)
      List<Company> companyList = snapshot.docs
          .where((doc) {
            final data = doc.data() as Map<String, dynamic>;
            final name = data['name'] as String?;

            // Perform case-insensitive partial match
            return name?.toLowerCase().contains(companyName.toLowerCase()) ??
                false;
          })
          .map((doc) => Company.fromMap(doc.data() as Map<String, dynamic>))
          .toList();

      // Debug: Print the filtered list
      log('Filtered companies for name $companyName: $companyList');
      return companyList;
    } catch (e) {
      log('Failed to retrieve companies for name $companyName: $e');
      return [];
    }
  }
}

import '../../../models/fin.dart';

abstract class FinRepository {
  Future<List<Fin>> getAllFinSizes();
  Future<bool> addNewFinSize(Fin fin);
  Future<bool> updateFinSize(Fin fin);
  Future<bool> deleteFinSize(String id);
}

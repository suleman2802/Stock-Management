import '../../../models/fin.dart';

abstract class FinRepository {
  Future<List<Fin>> getAllFinSizes(bool isAluminium);
  Future<bool> addNewFinSize(Fin fin,bool isAluminium);
  Future<bool> updateFinSize(Fin fin,bool isAluminium);
  Future<bool> deleteFinSize(String id,bool isAluminium);
}

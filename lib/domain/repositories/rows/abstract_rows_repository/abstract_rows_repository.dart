import '../../../models/rows.dart';

abstract class RowsRepository {
  Future<List<Rows>> getAllRows(bool isAluminium);
  Future<bool> addNewRow(Rows rows, bool isAluminium);
  Future<bool> updateRow(Rows rows, bool isAluminium);
  Future<bool> deleteRow(String id, bool isAluminium);
}

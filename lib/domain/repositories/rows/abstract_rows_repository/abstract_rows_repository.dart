import '../../../models/rows.dart';

abstract class RowsRepository {
  Future<List<Rows>> getAllRows();
  Future<bool> addNewRow(Rows rows);
  Future<bool> updateRow(Rows rows);
  Future<bool> deleteRow(String id);
}

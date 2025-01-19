import '../../../models/fin.dart';

abstract class FinRepository {
  Future<Fin> getAllFinSizes();
  Future<bool> addNewFinSize(Fin fin);
  Future<bool> updateFinSize(Fin fin);
  Future<bool> deleteFinSize(Fin fin);
}

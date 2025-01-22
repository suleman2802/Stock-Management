import '../../../models/radiator.dart';

abstract class RadiatorRepository {
  Future<List<Radiator>> getAllRadiators();
  Future<bool> addNewRadiator(Radiator radiator);
  Future<bool> updateRadiator(Radiator radiator);
  Future<bool> deleteRadiator(String id);
}

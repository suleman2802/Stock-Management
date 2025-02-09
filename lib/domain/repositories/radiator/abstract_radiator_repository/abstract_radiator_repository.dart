import '../../../models/radiator.dart';

abstract class RadiatorRepository {
  Future<List<Radiator>> getAllRadiators(bool isAluminium);
  Future<List<Radiator>> getAllRadiatorsByCarId(String carId, bool isAluminium);
  Future<bool> addNewRadiator(Radiator radiator, bool isAluminium);
  Future<bool> updateRadiator(Radiator radiator, bool isAluminium);
  Future<bool> deleteRadiator(String id, bool isAluminium);
}

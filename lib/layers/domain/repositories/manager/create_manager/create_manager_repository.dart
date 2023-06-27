import 'package:apupu_eventos/layers/domain/entities/manager/manager_entity.dart';

abstract class ICreateManagerRepository {
  Future<ManagerEntity> call(ManagerEntity manager);
}

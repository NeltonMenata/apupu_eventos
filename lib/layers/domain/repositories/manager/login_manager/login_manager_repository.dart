import 'package:apupu_eventos/layers/domain/entities/manager/manager_entity.dart';

abstract class ILoginManagerRepository {
  Future<ManagerEntity> call(String username, String password);
}
